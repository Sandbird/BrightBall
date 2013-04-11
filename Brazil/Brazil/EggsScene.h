//
//  EggsScene.h
//  Brazil
//
//  Created by zhaozilong on 12-12-4.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Egg.h"
#import "ZZNavBar.h"

#define EFFECT_CHICKEN_0 @"egg-chicken-0.caf"
#define EFFECT_DUCK_0 @"egg-duck-0.caf"
#define EFFECT_GOOSE_0 @"egg-goose-0.caf"
#define EFFECT_DINOSAUR_0 @"egg-dinosaur-0.caf"
#define EFFECT_PENGUIN_0 @"egg-penguin-0.caf"
#define EFFECT_EGG_0 @"egg-0.caf"
#define EFFECT_EGG_1 @"egg-1.caf"

#define SOUND_GOOSE_CN @"goose-cn.caf"
#define SOUND_PENGUIN_CN @"penguin-cn.caf"
#define SOUND_CHICKEN_CN @"chicken-cn.caf"
#define SOUND_DINOSAUR_CN @"dinosaur-cn.caf"
#define SOUND_DUCK_CN @"duck-cn.caf"

#define SOUND_GOOSE_EN @"goose-en.caf"
#define SOUND_PENGUIN_EN @"penguin-en.caf"
#define SOUND_CHICKEN_EN @"chicken-en.caf"
#define SOUND_DINOSAUR_EN @"dinosaur-en.caf"
#define SOUND_DUCK_EN @"duck-en.caf"

#define SOUND_GOOSE_JP @"goose-jp.caf"
#define SOUND_PENGUIN_JP @"penguin-jp.caf"
#define SOUND_CHICKEN_JP @"chicken-jp.caf"
#define SOUND_DINOSAUR_JP @"dinosaur-jp.caf"
#define SOUND_DUCK_JP @"duck-jp.caf"




@interface EggsScene : CCLayer {
    
    CCSpriteFrameCache *frameCache;
    
}
@property (nonatomic, retain) ZZNavBar *navBar;

+ (id)scene;
+(CGPoint) locationFromTouch:(UITouch*)touch;
+ (EggsScene *)sharedEggsScene;

@end
