//
//  ZooScene.h
//  Brazil
//
//  Created by zhaozilong on 12-12-11.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Animal.h"
#import "ZZNavBar.h"
#import "SimpleAudioEngine.h"

//#define EFFECT_LION_0 @"zoo-lion-0.caf"
//#define EFFECT_ORANGUTAN_0 @"zoo-orangutan-0.caf"
//#define EFFECT_ELEPHANT_0 @"zoo-elephant-0.caf"
//#define EFFECT_COW_0 @"zoo-cow-0.caf"

#define SOUND_LION_CN @"zoo-lion-cn.caf"
#define SOUND_ZOO_ELEPHANT_CN @"zoo-elephant-cn.caf"
#define SOUND_COW_CN @"zoo-cow-cn.caf"
#define SOUND_GORILLA_CN @"zoo-gorilla-cn.caf"
#define SOUND_PANDA_CN @"zoo-panda-cn.caf"

#define SOUND_LION_EN @"zoo-lion-en.caf"
#define SOUND_ZOO_ELEPHANT_EN @"zoo-elephant-en.caf"
#define SOUND_COW_EN @"zoo-cow-en.caf"
#define SOUND_GORILLA_EN @"zoo-gorilla-en.caf"
#define SOUND_PANDA_EN @"zoo-panda-en.caf"

#define SOUND_LION_JP @"zoo-lion-jp.caf"
#define SOUND_ZOO_ELEPHANT_JP @"zoo-elephant-jp.caf"
#define SOUND_COW_JP @"zoo-cow-jp.caf"
#define SOUND_GORILLA_JP @"zoo-gorilla-jp.caf"
#define SOUND_PANDA_JP @"zoo-panda-jp.caf"



@class Animal;

@interface ZooScene : CCLayer <AnimalDelegate> {
    
    Animal *animalA;// = [Animal animalWithParentNode:self pos:ccp(0, 0) prefix:1];
    Animal *animalB;// = [Animal animalWithParentNode:self pos:ccp(0, 0) prefix:2];
    Animal *animalC;// = [Animal animalWithParentNode:self pos:ccp(0, 0) prefix:3];
    
    SimpleAudioEngine *audioEngine;
    
}

@property (nonatomic, retain) ZZNavBar *navBar;

+(CGPoint) locationFromTouch:(UITouch*)touch;

+ (id)scene;

@end
