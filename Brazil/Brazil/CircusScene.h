//
//  CircusScene.h
//  Brazil
//
//  Created by zhaozilong on 12-12-18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Disk.h"
#import "ZZNavBar.h"

#define SOUND_ELEPHANT_CN @"elephant-cn.caf"
#define SOUND_JOKER_CN @"joker-cn.caf"

#define SOUND_ELEPHANT_EN @"elephant-en.caf"
#define SOUND_JOKER_EN @"joker-en.caf"

#define SOUND_ELEPHANT_JP @"elephant-jp.caf"
#define SOUND_JOKER_JP @"joker-jp.caf"

@class Disk;

@interface CircusScene : CCLayer {
    
    CCSprite *elephantSprite;
    CCSprite *jokerSprite;
    
    Disk *disk;
    
}

@property BOOL isAnimLocked;

@property (nonatomic, retain) ZZNavBar *navBar;

+(CGPoint) locationFromTouch:(UITouch*)touch;

+ (CircusScene *)sharedCircusScene;

+ (id)scene;

@end
