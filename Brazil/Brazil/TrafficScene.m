//
//  TrafficScene.m
//  Brazil
//
//  Created by zhaozilong on 12-12-20.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "TrafficScene.h"


@implementation TrafficScene

@synthesize navBar = _navBar;
@synthesize background = _background;
@synthesize currentCar = _currentCar;

static TrafficScene *instanceOfTrafficScene;

- (void)dealloc {
    
    CCLOG(@"trafficScene dealloc");
    [TrafficScene unloadEffects];
    instanceOfTrafficScene = nil;

//    [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
    if ([ZZNavBar isiPad]) {
        if ([ZZNavBar isRetina]) {
            [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"traffic0.plist"];
            [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"traffic1.plist"];
        } else {
            [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"traffic.plist"];
        }
    } else {
        if ([ZZNavBar isiPhone5]) {
            [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"traffic.plist"];
        } else {
            [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"traffic0.plist"];
            [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"traffic1.plist"];
        }
    }

    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    
    [super dealloc];
}

+ (TrafficScene *)sharedTrafficScene {
    NSAssert(instanceOfTrafficScene != nil, @"TrafficScene is not yet initialize");
    return instanceOfTrafficScene;
}

+ (id)scene {
    CCScene *scene = [CCScene node];
    TrafficScene *layer = [TrafficScene node];
    [scene addChild:layer];
    return scene;
}

- (id)init {
    
    if (self = [super init]) {
        instanceOfTrafficScene = self;
        
        _currentCar = CarNoneTag;
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        if ([ZZNavBar isiPad]) {
            if ([ZZNavBar isRetina]) {
                [frameCache addSpriteFramesWithFile:@"traffic0.plist"];
                [frameCache addSpriteFramesWithFile:@"traffic1.plist"];
            } else {
                [frameCache addSpriteFramesWithFile:@"traffic.plist"];
            }
        } else {
            if ([ZZNavBar isiPhone5]) {
                [frameCache addSpriteFramesWithFile:@"traffic.plist"];
            } else {
                [frameCache addSpriteFramesWithFile:@"traffic0.plist"];
                [frameCache addSpriteFramesWithFile:@"traffic1.plist"];
            }
        }

        
//        CCSprite *bgSprite = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"sky.png"]];
//        bgSprite.position = ccp(screenSize.width / 2, screenSize.height / 2);
        
        CCLayerColor *bg = [CCLayerColor layerWithColor:ccc4(140, 224, 232, 255)];
        [self addChild:bg z:-1];
        
//        CCSprite *sunSprite = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"sun.png"]];
        CCSprite *sunSprite = [CCSprite spriteWithFile:@"sun.png"];
        if ([ZZNavBar isiPhone5]) {
            sunSprite.position = ccp(screenSize.width / 2, screenSize.height / 2 + 30);
        } else {
            sunSprite.position = ccp(screenSize.width / 2, screenSize.height * 2 / 3);
        }
        [self addChild:sunSprite z:-1];
        [sunSprite runAction:[CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:10 angle:360]]];
        
        _background = [ParallaxBackground node];
		[self addChild:_background z:-1];
        
        _navBar = [ZZNavBar node];
        [self addChild:_navBar];
        [_navBar setTitleLabelWithString:NSLocalizedStringFromTable(@"road", [ZZNavBar getStringEnCnJp], nil)];
        
        [TrafficScene loadEffects];
        
    }
    
    return self;
}

+(CGPoint) locationFromTouch:(UITouch*)touch
{
	CGPoint touchLocation = [touch locationInView: [touch view]];
	return [[CCDirector sharedDirector] convertToGL:touchLocation];
}

- (void)onExitTransitionDidStart {
    [[CCTouchDispatcher sharedDispatcher] removeAllDelegates];
}

+ (void)loadEffects {
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_TOWER_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_PYRAMID_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_TIANANMEN_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_LIBERTY_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_OPERA_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_ARCH_EN];
    
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_BUS_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_BICYCLE_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_CAR_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_CAR4_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_CAR5_EN];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_SUN_EN];
    
    switch ([ZZNavBar getNumberEnCnJp]) {
        case 2:
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_TOWER_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_PYRAMID_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_TIANANMEN_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_LIBERTY_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_OPERA_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_ARCH_CN];
            
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_BUS_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_BICYCLE_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_CAR_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_CAR4_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_CAR5_CN];
//            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_SUN_CN];
 
            break;
            
        case 3:
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_TOWER_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_PYRAMID_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_TIANANMEN_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_LIBERTY_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_OPERA_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_ARCH_JP];
            
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_BUS_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_BICYCLE_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_CAR_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_CAR4_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_CAR5_JP];
//            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_SUN_JP];

            break;
            
        default:
            break;
    }

    

    

    
    [[SimpleAudioEngine sharedEngine] preloadEffect:EFFECT_CAR];
    [[SimpleAudioEngine sharedEngine] preloadEffect:EFFECT_BICYCLE];
    [[SimpleAudioEngine sharedEngine] preloadEffect:EFFECT_MOTORBIKE];
}

+ (void)unloadEffects {
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_TOWER_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_PYRAMID_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_TIANANMEN_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_LIBERTY_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_OPERA_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_ARCH_EN];
    
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_BUS_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_BICYCLE_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_CAR_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_CAR4_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_CAR5_EN];
//    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_SUN_EN];
    
    switch ([ZZNavBar getNumberEnCnJp]) {
        case 2:
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_TOWER_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_PYRAMID_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_TIANANMEN_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_LIBERTY_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_OPERA_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_ARCH_CN];
            
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_BUS_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_BICYCLE_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_CAR_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_CAR4_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_CAR5_CN];
//            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_SUN_CN];
            break;
            
        case 3:
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_TOWER_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_PYRAMID_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_TIANANMEN_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_LIBERTY_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_OPERA_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_ARCH_JP];
            
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_BUS_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_BICYCLE_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_CAR_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_CAR4_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_CAR5_JP];
//            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_SUN_JP];
            break;
            
        default:
            break;
    }

    [[SimpleAudioEngine sharedEngine] unloadEffect:EFFECT_BICYCLE];
    [[SimpleAudioEngine sharedEngine] unloadEffect:EFFECT_CAR];
    [[SimpleAudioEngine sharedEngine] unloadEffect:EFFECT_MOTORBIKE];
}


@end
