//
//  Rubbish.m
//  Brazil
//
//  Created by zhaozilong on 12-11-29.
//
//

#import "Rubbish.h"

@implementation Rubbish

@synthesize pngRubbishName = _pngRubbishName;
@synthesize isTouchHandled = _isTouchHandled;
@synthesize currentRubbishTag = _currentRubbishTag;
@synthesize lastTouchPoint = _lastTouchPoint;

//extern BOOL BoyIsAnimLocked;

- (void)dealloc {
    
    CCLOG(@"%d,Rubbish dealloc", _currentRubbishTag);
    
    //释放选中的rubbish
    [[RubbishScene sharedRubbishScene] setRubbish:nil];
    
    [[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
    [super dealloc];
}

+ (id)rubbishWithParentNode:(CCNode *)parentNode rubbishTag:(int)rubbishNameTag position:(CGPoint)point {
    return [[[self alloc] initWithParentNode:parentNode rubbishTag:rubbishNameTag position:point] autorelease];
}

- (id)initWithParentNode:(CCNode *)parentNode rubbishTag:(int)rubbishNameTag position:(CGPoint)point {
    
    if (self = [super init]) {
        //当前的水果
        _currentRubbishTag = rubbishNameTag;
        
        //获取屏幕大小
        //        CGSize size = [[CCDirector sharedDirector] winSize];
        
        //set _PNGFruitName
        [self setPNGRubbishNameWithRubbishNameTag:_currentRubbishTag];
        
        //set audioName & preload audio
        [self setSoundRubbishNameWithRubbishNameTag:_currentRubbishTag];
        
        //允许触摸
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:-1 swallowsTouches:YES];
        
        
        //用帧初始化当前的精灵
        rubbishSprite = [CCSprite spriteWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:_pngRubbishName]];
        
        [parentNode addChild:rubbishSprite];
        
        //set sprite's position
        rubbishSprite.anchorPoint = ccp(0, 0);
        rubbishSprite.position = ccp(point.x, point.y);
        defaultPosition = rubbishSprite.position;
    }
    
    return self;
}

- (void)setSpritePostion:(CGPoint)point {
    rubbishSprite.position = point;
}

- (void)setPNGRubbishNameWithRubbishNameTag:(int)tag {
    switch (tag) {
        case RubbishDiskTag:
            _pngRubbishName = [NSString stringWithFormat:@"%@.png", rubbishDiskName];
            break;
            
        case RubbishPlasticTag:
            _pngRubbishName = [NSString stringWithFormat:@"%@.png", rubbishPlasticName];
            break;
            
        case RubbishCokeTag:
            _pngRubbishName = [NSString stringWithFormat:@"%@.png", rubbishCokeName];
            break;
            
        case RubbishBottleTag:
            _pngRubbishName = [NSString stringWithFormat:@"%@.png", rubbishBottleName];
            break;
            
        case RubbishBatteryTag:
            _pngRubbishName = [NSString stringWithFormat:@"%@.png", rubbishBatteryName];
            break;
            
        case RubbishNewspaperTag:
            _pngRubbishName = [NSString stringWithFormat:@"%@.png", rubbishNewspaperName];
            break;
            
        default:
            CCLOGERROR(@"Rubbish:Wrong rubbish tag.");
            break;
    }
}

- (void)setTitleRubbishNameWithRubbishNameTag:(int)tag {
    switch (tag) {
        case RubbishDiskTag:
            //            soundFruitName = [NSString stringWithFormat:@"%@.caf", fruitAppleName];
            [[[RubbishScene sharedRubbishScene] navBar] setTitleLabelWithString:@"Disk\n光盘"];
            break;
            
        case RubbishPlasticTag:
            //            soundFruitName = [NSString stringWithFormat:@"%@.caf", fruitGrapeName];
            [[[RubbishScene sharedRubbishScene] navBar] setTitleLabelWithString:@"Plastic Bag\n塑料袋"];
            break;
            
        case RubbishCokeTag:
            //            soundFruitName = [NSString stringWithFormat:@"%@.caf", fruitBananaName];
            [[[RubbishScene sharedRubbishScene] navBar] setTitleLabelWithString:@"Banana Skin\n香蕉皮"];
            break;
            
        case RubbishBottleTag:
            //            soundFruitName = [NSString stringWithFormat:@"%@.caf", fruitCherryName];
            [[[RubbishScene sharedRubbishScene] navBar] setTitleLabelWithString:@"Paper Cup\n纸杯"];
            break;
            
        case RubbishBatteryTag:
            //            soundFruitName = [NSString stringWithFormat:@"%@.caf", fruitOrangeName];
            [[[RubbishScene sharedRubbishScene] navBar] setTitleLabelWithString:@"Fishbone\n鱼刺"];
            break;
            
        case RubbishNewspaperTag:
            //            soundFruitName = [NSString stringWithFormat:@"%@.caf", fruitWatermelonName];
            [[[RubbishScene sharedRubbishScene] navBar] setTitleLabelWithString:@"Newspaper\n报纸"];
            break;
            
        default:
            CCLOGERROR(@"Rubbish:Wrong sound rubbish tag.");
            break;
    }
}

- (void)setSoundRubbishNameWithRubbishNameTag:(int)tag {
    switch (tag) {
        case RubbishDiskTag:
            soundRubbishName = SOUND_DISK_EN;
            soundRubbishNameCN = SOUND_DISK_CN;
            break;
            
        case RubbishPlasticTag:
            soundRubbishName = SOUND_PLASTIC_EN;
            soundRubbishNameCN = SOUND_PLASTIC_CN;
            break;
            
        case RubbishCokeTag:
            soundRubbishName = SOUND_BANANASKIN_EN;
            soundRubbishNameCN = SOUND_BANANASKIN_CN;

            break;
            
        case RubbishBottleTag:
            soundRubbishName = SOUND_PAPERCUP_EN;
            soundRubbishNameCN = SOUND_PAPERCUP_CN;

            break;
            
        case RubbishBatteryTag:
            soundRubbishName = SOUND_FISHBONE_EN;
            soundRubbishNameCN = SOUND_FISHBONE_CN;

            break;
            
        case RubbishNewspaperTag:
            soundRubbishName = SOUND_NEWSPAPER_EN;
            soundRubbishNameCN = SOUND_NEWSPAPER_CN;

            break;
            
        default:
            CCLOGERROR(@"Fruit:Wrong sound fruit tag.");
            break;
    }
}

- (CGRect)getRubbishSpriteRect {
    CGRect rect;
//    rect.origin = rubbishSprite.boundingBox.origin;
    rect.origin = _lastTouchPoint;
    rect.size = rubbishSprite.boundingBox.size;
    
    //    CCLOG(@"Fruit:x = %f, y = %f", rect.origin.x, rect.origin.y);
    
    return rect;
}

- (void)setRubbishSpriteVisible:(BOOL)isVisible {
    rubbishSprite.visible = isVisible;
}

- (void)setRubbishSpriteAppearEffect {
    [rubbishSprite runAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1 scale:1.2], [CCScaleTo actionWithDuration:0.1 scale:0.8], [CCScaleTo actionWithDuration:0.1 scale:1.0], nil]];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    
    lastTouchLocation = [RubbishScene locationFromTouch:touch];
    
    _isTouchHandled = CGRectContainsPoint([rubbishSprite boundingBox], lastTouchLocation);
    
    if (_isTouchHandled) {
        
        //只有当前可见的水果才可以设置成为活动的水果
        if ([[[RubbishScene sharedRubbishScene] dustbin] isCanAnimationLocked] == NO) {
            [[RubbishScene sharedRubbishScene] setRubbish:self];
            
            //播放水果的声音
            [self setTitleRubbishNameWithRubbishNameTag:_currentRubbishTag];
            if ([[[RubbishScene sharedRubbishScene] navBar] isEnglish]) {
                [[SimpleAudioEngine sharedEngine] playEffect:soundRubbishName];
            } else {
                [[SimpleAudioEngine sharedEngine] playEffect:soundRubbishNameCN];
            }
            
        }
        
        [rubbishSprite runAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.05 scale:1.1], [CCScaleTo actionWithDuration:0.05 scale:1.0], nil]];
    }
    
    return _isTouchHandled;
    
}

-(void) ccTouchMoved:(UITouch*)touch withEvent:(UIEvent *)event
{
    
	CGPoint currentTouchLocation = [RubbishScene locationFromTouch:touch];
	
	// Take the difference of the current to the last touch location.
	CGPoint moveTo = ccpSub(lastTouchLocation, currentTouchLocation);
	// Then reverse it since the goal is not to give the impression of moving the camera over the background,
	// but to touch and move the background.
	moveTo = ccpMult(moveTo, -1);
	
	lastTouchLocation = currentTouchLocation;
	
	// Adjust the layer's position accordingly, this will change the position of all nodes it contains too.
	rubbishSprite.position = ccpAdd(rubbishSprite.position, moveTo);
    
    _lastTouchPoint = rubbishSprite.position;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    _isTouchHandled = NO;
    
    // Move the game layer back to its designated position.
	CCMoveTo* move = [CCMoveTo actionWithDuration:0.1 position:defaultPosition];
	CCEaseIn* ease = [CCEaseIn actionWithAction:move rate:0.5f];
    
	[rubbishSprite runAction:ease];
    
//    lastTouchPoint = ccp(0, 0);   
}



@end
