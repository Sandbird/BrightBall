//
//  Furit.m
//  Brazil
//
//  Created by zhaozilong on 12-10-31.
//
//

#import "Furit.h"

@implementation Furit

@synthesize pngFruitName = _pngFruitName;
@synthesize isTouchHandled = _isTouchHandled;
@synthesize currentFruitTag = _currentFruitTag;

extern BOOL BoyIsAnimLocked;

- (void)dealloc {
    
    CCLOG(@"Fruit dealloc");
    [[EatFuritsScene sharedEatFurits] setFruit:nil];
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
        case FruitAppleTag:
            _pngFruitName = [NSString stringWithFormat:@"%@.png", fruitAppleName];
            break;
            
        case FruitGrapeTag:
            _pngFruitName = [NSString stringWithFormat:@"%@.png", fruitGrapeName];
            break;
            
        case FruitBananaTag:
            _pngFruitName = [NSString stringWithFormat:@"%@.png", fruitBananaName];
            break;
            
        case FruitCherryTag:
            _pngFruitName = [NSString stringWithFormat:@"%@.png", fruitCherryName];
            break;
            
        case FruitOrangeTag:
            _pngFruitName = [NSString stringWithFormat:@"%@.png", fruitOrangeName];
            break;
            
        case FruitWatermelonTag:
            _pngFruitName = [NSString stringWithFormat:@"%@.png", fruitWatermelonName];
            break;
            
        case FruitDurianTag:
            _pngFruitName = [NSString stringWithFormat:@"%@.png", fruitDurianName];
            break;
            
        default:
            CCLOGERROR(@"Fruit:Wrong fruit tag.");
            break;
    }
}

- (void)setTitleFruitNameWithFruitNameTag:(int)tag {
    switch (tag) {
        case FruitAppleTag:
            [[[EatFuritsScene sharedEatFurits] navBar] setTitleLabelWithString:NSLocalizedStringFromTable(@"apple", [ZZNavBar getStringEnCnJp], nil)];
            break;
            
        case FruitGrapeTag:
            [[[EatFuritsScene sharedEatFurits] navBar] setTitleLabelWithString:NSLocalizedStringFromTable(@"grape", [ZZNavBar getStringEnCnJp], nil)];
            break;
            
        case FruitBananaTag:
            [[[EatFuritsScene sharedEatFurits] navBar] setTitleLabelWithString:NSLocalizedStringFromTable(@"banana", [ZZNavBar getStringEnCnJp], nil)];
            break;
            
        case FruitCherryTag:
            [[[EatFuritsScene sharedEatFurits] navBar] setTitleLabelWithString:NSLocalizedStringFromTable(@"cherry", [ZZNavBar getStringEnCnJp], nil)];
            break;
            
        case FruitOrangeTag:
            [[[EatFuritsScene sharedEatFurits] navBar] setTitleLabelWithString:NSLocalizedStringFromTable(@"orange", [ZZNavBar getStringEnCnJp], nil)];
            break;
            
        case FruitWatermelonTag:
            [[[EatFuritsScene sharedEatFurits] navBar] setTitleLabelWithString:NSLocalizedStringFromTable(@"watermelon", [ZZNavBar getStringEnCnJp], nil)];
            break;
            
        case FruitDurianTag:
            [[[EatFuritsScene sharedEatFurits] navBar] setTitleLabelWithString:NSLocalizedStringFromTable(@"durian", [ZZNavBar getStringEnCnJp], nil)];
            break;
            
        default:
            CCLOGERROR(@"Fruit:Wrong sound fruit tag.");
            break;
    }
}

- (void)setSoundFruitNameWithFruitNameTag:(int)tag {
    
    switch (tag) {
        case FruitAppleTag:
            soundFruitName = SOUND_APPLE_EN;
            if ([ZZNavBar getNumberEnCnJp] == 2) {
                soundFruitNameCN = SOUND_APPLE_CN;
            } else {
                soundFruitNameCN = SOUND_APPLE_JP;
            }
            
            break;
            
        case FruitGrapeTag:
            soundFruitName = SOUND_GRAPE_EN;
            if ([ZZNavBar getNumberEnCnJp] == 2) {
                soundFruitNameCN = SOUND_GRAPE_CN;
            } else {
                soundFruitNameCN = SOUND_GRAPE_JP;
            }

            break;
            
        case FruitBananaTag:
            soundFruitName = SOUND_BANANA_EN;
            if ([ZZNavBar getNumberEnCnJp] == 2) {
                soundFruitNameCN = SOUND_BANANA_CN;
            } else {
                soundFruitNameCN = SOUND_BANANA_JP;
            }
            break;
            
        case FruitCherryTag:
            soundFruitName = SOUND_CHERRY_EN;
            if ([ZZNavBar getNumberEnCnJp] == 2) {
                soundFruitNameCN = SOUND_CHERRY_CN;
            } else {
                soundFruitNameCN = SOUND_CHERRY_JP;
            }
            break;
            
        case FruitOrangeTag:
            soundFruitName = SOUND_ORANGE_EN;
            if ([ZZNavBar getNumberEnCnJp] == 2) {
                soundFruitNameCN = SOUND_ORANGE_CN;
            } else {
                soundFruitNameCN = SOUND_ORANGE_JP;
            }
            break;
            
        case FruitWatermelonTag:
            
            soundFruitName = SOUND_WATERMELON_EN;
            if ([ZZNavBar getNumberEnCnJp] == 2) {
                soundFruitNameCN = SOUND_WATERMELON_CN;
            } else {
                soundFruitNameCN = SOUND_WATERMELON_JP;
            }
            break;
            
        case FruitDurianTag:
            
            soundFruitName = SOUND_DURIAN_EN;
            if ([ZZNavBar getNumberEnCnJp] == 2) {
                soundFruitNameCN = SOUND_DURIAN_CN;
            } else {
                soundFruitNameCN = SOUND_DURIAN_JP;
            }
            break;
            
        default:
            CCLOGERROR(@"Fruit:Wrong sound fruit tag.");
            break;
    }
    
    [[SimpleAudioEngine sharedEngine] preloadEffect:soundFruitName];
    switch ([ZZNavBar getNumberEnCnJp]) {
        case 2:            
        case 3:
            [[SimpleAudioEngine sharedEngine] preloadEffect:soundFruitNameCN];
            break;
            
        default:
            break;
    }
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
    
    lastTouchLocation = [EatFuritsScene locationFromTouch:touch];
    
    _isTouchHandled = CGRectContainsPoint([fruitSprite boundingBox], lastTouchLocation);
    
    if (_isTouchHandled) {
        
        //播放水果的声音
        if ([[[EatFuritsScene sharedEatFurits] navBar] isEnglish]) {
            [[SimpleAudioEngine sharedEngine] playEffect:soundFruitName];
        } else {
            [[SimpleAudioEngine sharedEngine] playEffect:soundFruitNameCN];
        }
        
        //只有当前可见的水果才可以设置成为活动的水果
        if (BoyIsAnimLocked == NO) {
            [[EatFuritsScene sharedEatFurits] setFruit:self];
            
            [self setTitleFruitNameWithFruitNameTag:_currentFruitTag];
        }
        
        
        [fruitSprite runAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.05 scale:1.1], [CCScaleTo actionWithDuration:0.05 scale:1.0], nil]];
    }
    
    return _isTouchHandled;
    
}

-(void) ccTouchMoved:(UITouch*)touch withEvent:(UIEvent *)event
{
    
	CGPoint currentTouchLocation = [EatFuritsScene locationFromTouch:touch];
	
	// Take the difference of the current to the last touch location.
	CGPoint moveTo = ccpSub(lastTouchLocation, currentTouchLocation);
	// Then reverse it since the goal is not to give the impression of moving the camera over the background,
	// but to touch and move the background.
	moveTo = ccpMult(moveTo, -1);
	
	lastTouchLocation = currentTouchLocation;
	
	// Adjust the layer's position accordingly, this will change the position of all nodes it contains too.
	fruitSprite.position = ccpAdd(fruitSprite.position, moveTo);
    //    fruitSprite.position = ccpAdd(fruitSprite.position, ccp(moveTo.x, 0));
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    _isTouchHandled = NO;
    
    // Move the game layer back to its designated position.
	CCMoveTo* move = [CCMoveTo actionWithDuration:0.1 position:defaultPosition];
	CCEaseIn* ease = [CCEaseIn actionWithAction:move rate:0.5f];
    
	[fruitSprite runAction:ease];
    
}


@end
