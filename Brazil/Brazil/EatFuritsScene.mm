//
//  EatFuritsScene.m
//  Brazil
//
//  Created by zhaozilong on 12-10-30.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "EatFuritsScene.h"

@interface EatFuritsScene (PrivateMethods)
-(void) update:(ccTime)delta;
@end


@implementation EatFuritsScene

//@synthesize isAnimLocked = _isAnimLocked;
@synthesize fruit = _fruit;
@synthesize boy = _boy;
@synthesize navBar = _navBar;

static EatFuritsScene *instanceOfEatFuritsScene;

- (void)dealloc {
    CCLOG(@"eat Dealloc");
    
    [EatFuritsScene unloadEffectMusic];
    instanceOfEatFuritsScene = nil;
    
//    [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"eatFurit.plist"];
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    [super dealloc];
    
}

+ (EatFuritsScene *)sharedEatFurits {
    NSAssert(instanceOfEatFuritsScene != nil, @"EatFuritsScene instance not yet initialized!");
	return instanceOfEatFuritsScene;
}

+ (id)scene {
    CCScene *scene = [CCScene node];
    
    EatFuritsScene *layer = [EatFuritsScene node];
    
    [scene addChild:layer];
    
    return scene;
}

- (id)init {
    if (self = [super init]) {
        instanceOfEatFuritsScene = self;
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];

        CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        [frameCache addSpriteFramesWithFile:@"eatFurit.plist"];
        
        //背景
        CCSpriteFrame *frame;// = [frameCache spriteFrameByName:@"BGEatFruits.png"];
        if ([ZZNavBar isiPhone5]) {
            frame = [frameCache spriteFrameByName:@"BGEatFruits-568.png"];
        } else {
            frame = [frameCache spriteFrameByName:@"BGEatFruits.png"];
        }
        CCSprite* background = [CCSprite spriteWithSpriteFrame:frame];
//        CCSprite* background = [CCSprite spriteWithFile:@"vegetablesBG.png"];
		background.position = CGPointMake(screenSize.width / 2, screenSize.height / 2);
		[self addChild:background];
        
        _navBar = [ZZNavBar node];
        [self addChild:_navBar z:3];
        
        
        //loadEffects
        [EatFuritsScene loadEffectMusic];
        
        //创建一个男孩
        _boy = [Boy boyWithParentNode:self];
        
        
        CGPoint orangePoint, cherryPoint, durianPoint, watermelonPoint, applePoint, bananaPoint, grapePoint;
        if ([ZZNavBar isiPad]) {
            orangePoint = ccp(100 + 50 + 60, 5 + 40 + 10);
            cherryPoint = ccp(40 + 50 + 40, 55 + 80 + 20);
            durianPoint = ccp(10 + 50 + 20, 105 + 120 + 30);
            watermelonPoint = ccp(0 + 50, 175 + 160 + 40);
            applePoint = ccp(10 + 50 + 20, 230 + 200 + 50);
            bananaPoint = ccp(40 + 50 + 40, 285 + 240 + 60);
            grapePoint = ccp(105 + 50 + 60, 330 + 280 + 80);
        } else {
            orangePoint = ccp(100, 5);
            cherryPoint = ccp(40, 55);
            durianPoint = ccp(10, 105);
            watermelonPoint = ccp(0, 175);
            applePoint = ccp(10, 230);
            bananaPoint = ccp(40, 285);
            grapePoint = ccp(105, 330);
        }
        
        //Create a kind of fruit.
        orange = [Furit furitWithParentNode:self fruitTag:FruitOrangeTag position:orangePoint];
        cherry = [Furit furitWithParentNode:self fruitTag:FruitCherryTag position:cherryPoint];
        durian = [Furit furitWithParentNode:self fruitTag:FruitDurianTag position:durianPoint];
        watermelon = [Furit furitWithParentNode:self fruitTag:FruitWatermelonTag position:watermelonPoint];
        apple = [Furit furitWithParentNode:self fruitTag:FruitAppleTag position:applePoint];
        banana = [Furit furitWithParentNode:self fruitTag:FruitBananaTag position:bananaPoint];
        grape = [Furit furitWithParentNode:self fruitTag:FruitGrapeTag position:grapePoint];
        
        [_navBar setTitleLabelWithString:NSLocalizedStringFromTable(@"eatFruits", [ZZNavBar getStringEnCnJp], nil)];
        
        //update
        [self scheduleUpdate];
        
    }
    
    return self;
}

+(CGPoint) locationFromTouch:(UITouch*)touch
{
	CGPoint touchLocation = [touch locationInView: [touch view]];
	return [[CCDirector sharedDirector] convertToGL:touchLocation];
}

- (void)setFruitVisible:(BOOL)isVisible {
    [_fruit setFruitSpriteVisible:YES];
    [_fruit setFruitSpriteAppearEffect];
    
//    [apple setFruitSpriteVisible:YES];
//    [apple setFruitSpriteAppearEffect];
}

- (void)update:(ccTime)delta {
    //如果动画锁开启，则主控制界面不再处理调度
    if (/*_isAnimLocked || */[_boy isAnimationLocked] || [_boy isSpeakAnimLocked]) {
        return;
    }
    
    if (_fruit.isTouchHandled) {
        [_boy boySetActionByActionTag:HeadOpenMouthTagAction fruitTag:0];
    } else/* if (_boy.isTouchHandled)*/{
        
#if 0
        //用来测试男孩嘴的位置
        CCSprite *test = [CCSprite spriteWithFile:@"Default@2x.png" rect:[_boy getBoyHeadSpriteRect]];
        test.anchorPoint = ccp(0, 0);
        test.position = [_boy getBoyHeadSpriteRect].origin;
        [self addChild:test z:10];
#endif
        
        if (CGRectIntersectsRect([_boy getBoyHeadSpriteRect], [_fruit getFruitSpriteRect])) {
            
            //fruit dispeared
            [_fruit setFruitSpriteVisible:NO];
            
            //Action of head
            [_boy boySetActionByActionTag:HeadEatTagAction fruitTag:_fruit.currentFruitTag ];
            
        } else {
            if (_boy.isSpeakAnimLocked == NO) {
                [_boy boySetActionByActionTag:HeadNormalTagAction fruitTag:0];
            }
            
            
        }
    }

}

- (void)onExitTransitionDidStart {
    
    [self unscheduleUpdate];
    [[CCTouchDispatcher sharedDispatcher] removeAllDelegates];
}

+ (void)loadEffectMusic {

    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_APPLE_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_GRAPE_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_BANANA_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_CHERRY_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_ORANGE_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_WATERMELON_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_DURIAN_EN];
    
    switch ([ZZNavBar getNumberEnCnJp]) {
        case 2:
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_APPLE_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_GRAPE_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_BANANA_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_CHERRY_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_ORANGE_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_WATERMELON_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_DURIAN_CN];
            break;
            
        case 3:
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_APPLE_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_GRAPE_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_BANANA_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_CHERRY_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_ORANGE_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_WATERMELON_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_DURIAN_JP];
            break;
            
        default:
            break;
    }
}

+ (void)unloadEffectMusic {
    
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_APPLE_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_GRAPE_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_BANANA_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_CHERRY_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_ORANGE_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_WATERMELON_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_DURIAN_EN];
    
    switch ([ZZNavBar getNumberEnCnJp]) {
        case 2:
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_APPLE_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_GRAPE_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_BANANA_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_CHERRY_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_ORANGE_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_WATERMELON_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_DURIAN_CN];
            break;
            
        case 3:
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_APPLE_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_GRAPE_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_BANANA_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_CHERRY_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_ORANGE_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_WATERMELON_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_DURIAN_JP];
            break;
            
        default:
            break;
    }

}



@end
