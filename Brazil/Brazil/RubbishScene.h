//
//  RubbishScene.h
//  Brazil
//
//  Created by zhaozilong on 12-11-29.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SimpleAudioEngine.h"

#import "Rubbish.h"
#import "Can.h"
#import "ZZNavBar.h"

#define EFFECT_RUBBISH_0 @"rubbish-0.caf"
#define EFFECT_RUBBISH_RIGHT @"rubbishRight.caf"
#define EFFECT_RUBBISH_WRONG @"rubbishWrong.caf"

#define SOUND_BANANASKIN_CN @"bananaSkin-cn.caf"
#define SOUND_DISK_CN @"disk-cn.caf"
#define SOUND_FISHBONE_CN @"fishbone-cn.caf"
#define SOUND_PAPERCUP_CN @"paperCup-cn.caf"
#define SOUND_NEWSPAPER_CN @"newspaper-cn.caf"
#define SOUND_PLASTIC_CN @"plastic-cn.caf"
#define SOUND_RECYCLABLE_CN @"recyclable-cn.caf"
#define SOUND_KITCHENWASTE_CN @"kitchenWaste-cn.caf"
#define SOUND_OTHERWASTE_CN @"otherWaste-cn.caf"

#define SOUND_BANANASKIN_EN @"bananaSkin-en.caf"
#define SOUND_DISK_EN @"disk-en.caf"
#define SOUND_FISHBONE_EN @"fishbone-en.caf"
#define SOUND_PAPERCUP_EN @"paperCup-en.caf"
#define SOUND_NEWSPAPER_EN @"newspaper-en.caf"
#define SOUND_PLASTIC_EN @"plastic-en.caf"
#define SOUND_RECYCLABLE_EN @"recyclable-en.caf"
#define SOUND_KITCHENWASTE_EN @"kitchenWaste-en.caf"
#define SOUND_OTHERWASTE_EN @"otherWaste-en.caf"


@class Rubbish, Can;

@interface RubbishScene : CCLayer {
    
    
}

//@property (nonatomic, retain) Rubbish *rubbish;
@property (nonatomic, retain) Rubbish *rubbish;
@property (nonatomic, retain) Can *dustbin;
@property (nonatomic, retain) ZZNavBar *navBar;

+ (id)scene;
+(CGPoint) locationFromTouch:(UITouch*)touch;
+ (RubbishScene *)sharedRubbishScene;

@end
