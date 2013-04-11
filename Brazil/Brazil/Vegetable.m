//
//  Vegetable.m
//  Brazil
//
//  Created by zhaozilong on 12-12-7.
//
//

#import "Vegetable.h"

@implementation Vegetable

@synthesize pngFruitName = _pngFruitName;
@synthesize isTouchHandled = _isTouchHandled;
@synthesize currentFruitTag = _currentFruitTag;
//@synthesize fruitSprite = _fruitSprite;
//@synthesize currentTouchLocation = _currentTouchLocation;

extern BOOL NewBoyIsAnimLocked;

- (void)dealloc {
    
    CCLOG(@"Fruit dealloc");
    [[VegetablesScene sharedEatFurits] setFruit:nil];
    [[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
    [super dealloc];
}

+ (id)furitWithParentNode:(CCNode *)parentNode fruitTag:(int)fruitNameTag position:(CGPoint)point {
    return [[[self alloc] initWithParentNode:parentNode fruitTag:fruitNameTag position:point] autorelease];
}

- (id)initWithParentNode:(CCNode *)parentNode fruitTag:(int)fruitNameTag position:(CGPoint)point {
    
    if (self = [super init]) {
        //当前的水果
        _currentFruitTag = fruitNameTag;
        
        //获取屏幕大小
        //        CGSize size = [[CCDirector sharedDirector] winSize];
        
        //set _PNGFruitName
        [self setPNGFruitNameWithFruitNameTag:_currentFruitTag];
        
        
        //允许触摸
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:-1 swallowsTouches:YES];
        
        //set audioName & preload audio
        [self setSoundFruitNameWithFruitNameTag:_currentFruitTag];
        
        
        //用帧初始化当前的精灵
        fruitSprite = [CCSprite spriteWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:_pngFruitName]];
        
        [parentNode addChild:fruitSprite z:2];
        
        //set sprite's position
        fruitSprite.anchorPoint = ccp(0, 0);
        fruitSprite.position = ccp(point.x, point.y);
        defaultPosition = fruitSprite.position;
    }
    
    return self;
}

- (void)setPNGFruitNameWithFruitNameTag:(int)tag {
    switch (tag) {
        case NBFruitAppleTag:
            _pngFruitName = [NSString stringWithFormat:@"%@.png", NBfruitAppleName];
            break;
            
        case NBFruitGrapeTag:
            _pngFruitName = [NSString stringWithFormat:@"%@.png", NBfruitGrapeName];
            break;
            
        case NBFruitBananaTag:
            _pngFruitName = [NSString stringWithFormat:@"%@.png", NBfruitBananaName];
            break;
            
        case NBFruitCherryTag:
            _pngFruitName = [NSString stringWithFormat:@"%@.png", NBfruitCherryName];
            break;
            
        case NBFruitOrangeTag:
            _pngFruitName = [NSString stringWithFormat:@"%@.png", NBfruitOrangeName];
            break;
            
        case NBFruitWatermelonTag:
            _pngFruitName = [NSString stringWithFormat:@"%@.png", NBfruitWatermelonName];
            break;
            
            //        case FruitDurianTag:
            //            _pngFruitName = [NSString stringWithFormat:@"%@.png", fruitDurianName];
            //            break;
            
        default:
            CCLOGERROR(@"Fruit:Wrong fruit tag.");
            break;
    }
}

- (void)setTitleFruitNameWithFruitNameTag:(int)tag {
    switch (tag) {
        case NBFruitAppleTag:
            
            [[[VegetablesScene sharedEatFurits] navBar] setTitleLabelWithString:NSLocalizedStringFromTable(@"carrot", [ZZNavBar getStringEnCnJp], nil)];
            break;
            
        case NBFruitGrapeTag:
            
            [[[VegetablesScene sharedEatFurits] navBar] setTitleLabelWithString:NSLocalizedStringFromTable(@"corn", [ZZNavBar getStringEnCnJp], nil)];
            break;
            
        case NBFruitBananaTag:
            
            [[[VegetablesScene sharedEatFurits] navBar] setTitleLabelWithString:NSLocalizedStringFromTable(@"mushroom", [ZZNavBar getStringEnCnJp], nil)];
            break;
            
        case NBFruitCherryTag:
            
            [[[VegetablesScene sharedEatFurits] navBar] setTitleLabelWithString:NSLocalizedStringFromTable(@"pumpkin", [ZZNavBar getStringEnCnJp], nil)];
            break;
            
        case NBFruitOrangeTag:
            
            [[[VegetablesScene sharedEatFurits] navBar] setTitleLabelWithString:NSLocalizedStringFromTable(@"tomato", [ZZNavBar getStringEnCnJp], nil)];
            break;
            
        case NBFruitWatermelonTag:
            
            [[[VegetablesScene sharedEatFurits] navBar] setTitleLabelWithString:NSLocalizedStringFromTable(@"potato", [ZZNavBar getStringEnCnJp], nil)];
            break;
            
        default:
            CCLOGERROR(@"Fruit:Wrong sound fruit tag.");
            break;
    }
}

- (void)setSoundFruitNameWithFruitNameTag:(int)tag {
    switch (tag) {
        case NBFruitAppleTag:
            soundFruitName = SOUND_CARROT_EN;
            
            if ([ZZNavBar getNumberEnCnJp] == 2) {
                soundFruitNameCN = SOUND_CARROT_CN;
            } else {
                soundFruitNameCN = SOUND_CARROT_JP;
            }
            break;
            
        case NBFruitGrapeTag:
            soundFruitName = SOUND_CORN_EN;
            
            if ([ZZNavBar getNumberEnCnJp] == 2) {
                soundFruitNameCN = SOUND_CORN_CN;
            } else {
                soundFruitNameCN = SOUND_CORN_JP;
            }
            break;
            
        case NBFruitBananaTag:
            soundFruitName = SOUND_MUSHROOM_EN;
            
            if ([ZZNavBar getNumberEnCnJp] == 2) {
                soundFruitNameCN = SOUND_MUSHROOM_CN;
            } else {
                soundFruitNameCN = SOUND_MUSHROOM_JP;
            }
            break;
            
        case NBFruitCherryTag:
            soundFruitName = SOUND_PUMPKIN_EN;
            
            if ([ZZNavBar getNumberEnCnJp] == 2) {
                soundFruitNameCN = SOUND_PUMPKIN_CN;
            } else {
                soundFruitNameCN = SOUND_PUMPKIN_JP;
            }
            break;
            
        case NBFruitOrangeTag:
            soundFruitName = SOUND_TOMATO_EN;
            
            if ([ZZNavBar getNumberEnCnJp] == 2) {
                soundFruitNameCN = SOUND_TOMATO_CN;
            } else {
                soundFruitNameCN = SOUND_TOMATO_JP;
            }
            break;
            
        case NBFruitWatermelonTag:
            soundFruitName = SOUND_POTATO_EN;
            
            if ([ZZNavBar getNumberEnCnJp] == 2) {
                soundFruitNameCN = SOUND_POTATO_CN;
            } else {
                soundFruitNameCN = SOUND_POTATO_JP;
            }
            break;
            
        default:
            CCLOGERROR(@"Fruit:Wrong sound fruit tag.");
            break;
    }
    
    [[SimpleAudioEngine sharedEngine] preloadEffect:soundFruitName];
    [[SimpleAudioEngine sharedEngine] preloadEffect:soundFruitNameCN];
}

- (CGRect)getFruitSpriteRect {
    CGRect rect;
    rect.origin = fruitSprite.boundingBox.origin;
    rect.size = fruitSprite.boundingBox.size;
    
    return rect;
}

- (void)setFruitSpriteVisible:(BOOL)isVisible {
    fruitSprite.visible = isVisible;
}

- (void)setFruitSpriteAppearEffect {
    [fruitSprite runAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1 scale:1.2], [CCScaleTo actionWithDuration:0.1 scale:0.8], [CCScaleTo actionWithDuration:0.1 scale:1.0], nil]];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    
    lastTouchLocation = [VegetablesScene locationFromTouch:touch];
    
    _isTouchHandled = CGRectContainsPoint([fruitSprite boundingBox], lastTouchLocation);
    
    if (_isTouchHandled) {
        
        //播放水果的声音
        if ([[[VegetablesScene sharedEatFurits] navBar] isEnglish]) {
            [[SimpleAudioEngine sharedEngine] playEffect:soundFruitName];
        } else {
            [[SimpleAudioEngine sharedEngine] playEffect:soundFruitNameCN];
        }
        
        //只有当前可见的水果才可以设置成为活动的水果
        if (NewBoyIsAnimLocked == NO) {
            [[VegetablesScene sharedEatFurits] setFruit:self];
            
            [self setTitleFruitNameWithFruitNameTag:_currentFruitTag];
        }
        
        [fruitSprite runAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.05 scale:1.1], [CCScaleTo actionWithDuration:0.05 scale:1.0], nil]];
    }
    
    return _isTouchHandled;
    
}

-(void) ccTouchMoved:(UITouch*)touch withEvent:(UIEvent *)event
{
    
	CGPoint currentTouchLocation = [VegetablesScene locationFromTouch:touch];
	
	// Take the difference of the current to the last touch location.
	CGPoint moveTo = ccpSub(lastTouchLocation, currentTouchLocation);
	// Then reverse it since the goal is not to give the impression of moving the camera over the background,
	// but to touch and move the background.
	moveTo = ccpMult(moveTo, -1);
	
	lastTouchLocation = currentTouchLocation;
	
	// Adjust the layer's position accordingly, this will change the position of all nodes it contains too.
	fruitSprite.position = ccpAdd(fruitSprite.position, moveTo);
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    _isTouchHandled = NO;
    
    // Move the game layer back to its designated position.
	CCMoveTo* move = [CCMoveTo actionWithDuration:0.1 position:defaultPosition];
	CCEaseIn* ease = [CCEaseIn actionWithAction:move rate:0.5f];
    
	[fruitSprite runAction:ease];
    
}


@end
