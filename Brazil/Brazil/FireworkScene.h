//
//  FireworkScene.h
//  Brazil
//
//  Created by zhaozilong on 13-1-18.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "ZZNavBar.h"
#import "Snake.h"

#define SOUND_NEWYEAR_EN @"happyNewYear-en.caf"
#define SOUND_LANTERN_EN @"lantern-en.caf"
#define SOUND_HOUSE_EN @"house-en.caf"
#define SOUND_SNAKE_EN @"snake-en.caf"
#define SOUND_FIRECRACKER_EN @"firecracker-en.caf"

#define SOUND_NEWYEAR_CN @"happyNewYear-cn.caf"
#define SOUND_LANTERN_CN @"lantern-cn.caf"
#define SOUND_HOUSE_CN @"house-cn.caf"
#define SOUND_SNAKE_CN @"snake-cn.caf"
#define SOUND_FIRECRACKER_CN @"firecracker-cn.caf"

#define SOUND_NEWYEAR_JP @"happyNewYear-jp.caf"
#define SOUND_LANTERN_JP @"lantern-jp.caf"
#define SOUND_HOUSE_JP @"house-jp.caf"
#define SOUND_SNAKE_JP @"snake-jp.caf"
#define SOUND_FIRECRACKER_JP @"firecracker-jp.caf"

#define EFFECT_FIRECRACKER_01 @"firecrackerEffect_01.caf"
#define EFFECT_FIRECRACKER_02 @"firecrackerEffect_02.caf"

@interface FireworkScene : CCLayer {
    CCSpriteBatchNode *lanternSpriteBatch;
    CCSpriteBatchNode *firecrackerSpriteBatch;
    
}

@property (nonatomic, retain) ZZNavBar *navBar;
@property (nonatomic, retain) Snake *snake;

@property (nonatomic, assign) BOOL isFirst;

+ (id)scene;
+(CGPoint) locationFromTouch:(UITouch*)touch;
+ (FireworkScene *)sharedFireworkScene;
- (void)restoreFirecrackers;

@end
