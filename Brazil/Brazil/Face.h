//
//  Face.h
//  Brazil
//
//  Created by zhaozilong on 13-1-6.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "EmotionScene.h"

//#define SOUND_EXPRESSION_EN @"expression-en.caf"
#define SOUND_ANGRY_EN      @"angry-en.caf"
#define SOUND_HAPPY_EN      @"happy-en.caf"
#define SOUND_SMILE_EN      @"smile-en.caf"
#define SOUND_SAD_EN        @"sad-en.caf"
#define SOUND_SURPRISE_EN   @"surprise-en.caf"
#define SOUND_SCARE_EN      @"scare-en.caf"

//#define SOUND_EXPRESSION_JP @"expression-jp.caf"
#define SOUND_ANGRY_JP      @"angry-jp.caf"
#define SOUND_HAPPY_JP      @"happy-jp.caf"
#define SOUND_SMILE_JP      @"smile-jp.caf"
#define SOUND_SAD_JP        @"sad-jp.caf"
#define SOUND_SURPRISE_JP   @"surprise-jp.caf"
#define SOUND_SCARE_JP      @"scare-jp.caf"

//#define SOUND_EXPRESSION_CN @"expression-cn.caf"
#define SOUND_ANGRY_CN      @"angry-cn.caf"
#define SOUND_HAPPY_CN      @"happy-cn.caf"
#define SOUND_SMILE_CN      @"smile-cn.caf"
#define SOUND_SAD_CN        @"sad-cn.caf"
#define SOUND_SURPRISE_CN   @"surprise-cn.caf"
#define SOUND_SCARE_CN      @"scare-cn.caf"

typedef enum
{
    FaceSpriteTagAngry,
    FaceSpriteTagSmile,
    FaceSpriteTagHappy,
    FaceSpriteTagSad,
    FaceSpriteTagSurprise,
    FaceSpriteTagScare,
    
} FaceSpriteTags;


@interface Face : CCSprite <CCTargetedTouchDelegate> {
    
}

+ (Face *)faceWithParentNode:(CCNode *)parentNode pos:(CGPoint)point zorder:(int)zorder faceTag:(int)tag;


@end
