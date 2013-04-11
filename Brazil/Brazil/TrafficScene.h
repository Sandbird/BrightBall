//
//  TrafficScene.h
//  Brazil
//
//  Created by zhaozilong on 12-12-20.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ParallaxBackground.h"
#import "ZZNavBar.h"

#define SOUND_TOWER_CN @"EiffelTower-cn.caf"
#define SOUND_PYRAMID_CN @"Pyramid-cn.caf"
#define SOUND_TIANANMEN_CN @"Tiananmen-cn.caf"
#define SOUND_LIBERTY_CN @"liberty-cn.caf"
#define SOUND_OPERA_CN @"opera-cn.caf"
#define SOUND_ARCH_CN @"arch-cn.caf"

#define SOUND_BUS_CN @"bus-cn.caf"
#define SOUND_BICYCLE_CN @"bicycle-cn.caf"
#define SOUND_CAR_CN @"car-cn.caf"
#define SOUND_CAR4_CN @"car4-cn.caf"
#define SOUND_CAR5_CN @"car5-cn.caf"
//#define SOUND_SUN_CN @"sun-cn.caf"

#define SOUND_TOWER_EN @"EiffelTower-en.caf"
#define SOUND_PYRAMID_EN @"Pyramid-en.caf"
#define SOUND_TIANANMEN_EN @"Tiananmen-en.caf"
#define SOUND_LIBERTY_EN @"liberty-en.caf"
#define SOUND_OPERA_EN @"opera-en.caf"
#define SOUND_ARCH_EN @"arch-en.caf"

#define SOUND_BUS_EN @"bus-en.caf"
#define SOUND_BICYCLE_EN @"bicycle-en.caf"
#define SOUND_CAR_EN @"car-en.caf"
#define SOUND_CAR4_EN @"car4-en.caf"
#define SOUND_CAR5_EN @"car5-en.caf"
//#define SOUND_SUN_EN @"sun-en.caf"

#define SOUND_TOWER_JP @"EiffelTower-jp.caf"
#define SOUND_PYRAMID_JP @"Pyramid-jp.caf"
#define SOUND_TIANANMEN_JP @"Tiananmen-jp.caf"
#define SOUND_LIBERTY_JP @"liberty-jp.caf"
#define SOUND_OPERA_JP @"opera-jp.caf"
#define SOUND_ARCH_JP @"arch-jp.caf"

#define SOUND_BUS_JP @"bus-jp.caf"
#define SOUND_BICYCLE_JP @"bicycle-jp.caf"
#define SOUND_CAR_JP @"car-jp.caf"
#define SOUND_CAR4_JP @"car4-jp.caf"
#define SOUND_CAR5_JP @"car5-jp.caf"
//#define SOUND_SUN_JP @"sun-jp.caf"

#define EFFECT_CAR @"carEffect.caf"
#define EFFECT_BICYCLE @"bicycleEffect.caf"
#define EFFECT_MOTORBIKE @"motorbikeEffect.caf"

@class ParallaxBackground;

@interface TrafficScene : CCLayer {
    CCSpriteFrameCache *frameCache;
}

@property int currentCar;

@property (nonatomic, retain) ParallaxBackground* background;

@property (nonatomic, retain) ZZNavBar *navBar;

+ (id)scene;

+(CGPoint) locationFromTouch:(UITouch*)touch;
+ (TrafficScene *)sharedTrafficScene;

@end
