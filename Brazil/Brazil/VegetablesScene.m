//
//  VegetablesScene.m
//  Brazil
//
//  Created by zhaozilong on 12-12-7.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "VegetablesScene.h"

@interface VegetablesScene (PrivateMethods)
-(void) update:(ccTime)delta;
@end


@implementation VegetablesScene

//@synthesize isAnimLocked = _isAnimLocked;
@synthesize fruit = _fruit;
@synthesize boy = _boy;
@synthesize navBar = _navBar;

static VegetablesScene *instanceOfVegetableScene;

- (void)dealloc {
    CCLOG(@"eat Dealloc");
    
    [VegetablesScene unloadEffectMusic];
    
    instanceOfVegetableScene = nil;
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"vegetables.plist"];
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    [super dealloc];
}

+ (VegetablesScene *)sharedEatFurits {
    NSAssert(instanceOfVegetableScene != nil, @"EatFuritsScene instance not yet initialized!");
	return instanceOfVegetableScene;
}

+ (id)scene {
    CCScene *scene = [CCScene node];
    
    VegetablesScene *layer = [VegetablesScene node];
    
    [scene addChild:layer];
    
    return scene;
}

- (id)init {
    if (self = [super init]) {
        instanceOfVegetableScene = self;
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        [frameCache addSpriteFramesWithFile:@"vegetables.plist"];
        
        //背景
        CCSpriteFrame *frame;// = [frameCache spriteFrameByName:@"BGEatFruits.png"];
        if ([ZZNavBar isiPhone5]) {
            frame = [frameCache spriteFrameByName:@"vegetablesBG-568.png"];
        } else {
            frame = [frameCache spriteFrameByName:@"vegetablesBG.png"];
        }
        CCSprite* background = [CCSprite spriteWithSpriteFrame:frame];
//        CCSprite* background = [CCSprite spriteWithFile:@"vegetablesBG.png"];
		background.position = CGPointMake(screenSize.width / 2, screenSize.height / 2);
		[self addChild:background];
        
        _navBar = [ZZNavBar node];
        [self addChild:_navBar z:3];
//        [_navBar setTitleLabelWithString:@"蔬菜\nVegetable"];
        
        //loadEffects
        [VegetablesScene loadEffectMusic];
        
        //创建一个男孩
        _boy = [NewBoy boyWithParentNode:self];
        
        
        CGPoint orangePoint, cherryPoint, /*durianPoint, */watermelonPoint, applePoint, bananaPoint, grapePoint;
        if ([ZZNavBar isiPad]) {
            
            
            applePoint = ccp(70, 670);
            grapePoint = ccp(230, 650);
            bananaPoint = ccp(380, 680);
            cherryPoint = ccp(570, 680);
            
            watermelonPoint = ccp(60, 250);
            orangePoint = ccp(200, 115);
        } else {
            
            
            applePoint = ccp(10, 310);
            grapePoint = ccp(90, 300);
            bananaPoint = ccp(160, 320);
            cherryPoint = ccp(250, 320);
            
            if ([ZZNavBar isiPhone5]) {
                orangePoint = ccp(70, 420);
                watermelonPoint = ccp(180, 420);
            } else {
                orangePoint = ccp(90, 15);
                watermelonPoint = ccp(15, 75);
            }
        }
        
        //Create a kind of fruit.
        carrot = [Vegetable furitWithParentNode:self fruitTag:NBFruitAppleTag position:applePoint];
        corn = [Vegetable furitWithParentNode:self fruitTag:NBFruitGrapeTag position:grapePoint];
        mushroom = [Vegetable furitWithParentNode:self fruitTag:NBFruitBananaTag position:bananaPoint];
        pumpkin = [Vegetable furitWithParentNode:self fruitTag:NBFruitCherryTag position:cherryPoint];
        tomato = [Vegetable furitWithParentNode:self fruitTag:NBFruitOrangeTag position:orangePoint];
        potato = [Vegetable furitWithParentNode:self fruitTag:NBFruitWatermelonTag position:watermelonPoint];
        
        [_navBar setTitleLabelWithString:NSLocalizedStringFromTable(@"vegetable", [ZZNavBar getStringEnCnJp], nil)];
        
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
        [_boy boySetActionByActionTag:NBHeadOpenMouthTagAction fruitTag:0];
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
            [_boy boySetActionByActionTag:NBHeadEatTagAction fruitTag:_fruit.currentFruitTag ];
            
        } else {
            if (_boy.isSpeakAnimLocked == NO) {
                [_boy boySetActionByActionTag:NBHeadNormalTagAction fruitTag:0];
            }
            
            
        }
    }
    
}

- (void)onExitTransitionDidStart {
    
    [self unscheduleUpdate];
    [[CCTouchDispatcher sharedDispatcher] removeAllDelegates];
}

+ (void)loadEffectMusic {
    
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_PUMPKIN_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_TOMATO_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_TOMATO_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_CARROT_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_CORN_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_MUSHROOM_EN];
    
    switch ([ZZNavBar getNumberEnCnJp]) {
        case 2:
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_PUMPKIN_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_TOMATO_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_TOMATO_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_CARROT_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_CORN_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_MUSHROOM_CN];
            break;
            
        case 3:
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_PUMPKIN_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_TOMATO_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_TOMATO_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_CARROT_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_CORN_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_MUSHROOM_JP];
            break;
            
        default:
            break;
    }

}

+ (void)unloadEffectMusic {

    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_PUMPKIN_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_TOMATO_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_TOMATO_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_CARROT_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_CORN_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_MUSHROOM_EN];
    
    switch ([ZZNavBar getNumberEnCnJp]) {
        case 2:
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_PUMPKIN_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_TOMATO_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_TOMATO_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_CARROT_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_CORN_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_MUSHROOM_CN];

            break;
            
        case 3:
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_PUMPKIN_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_TOMATO_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_TOMATO_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_CARROT_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_CORN_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_MUSHROOM_JP];

            break;
            
        default:
            break;
    }
}


@end
