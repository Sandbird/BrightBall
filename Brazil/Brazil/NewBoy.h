//
//  Boy.h
//  Brazil
//
//  Created by zhaozilong on 12-10-30.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SimpleAudioEngine.h"

#import "CCAnimationHelper.h"
#import "VegetablesScene.h"
#import "Vegetable.h"

#define PNG_HEAD_NORMAL @"headNormal.png"
#define PNG_HEAD_OPEN_MOUTH @"openMouth.png"
#define PNG_HEAD_WRONG @"headWrong.png"
#define PNG_HEAD_RIGHT @"headRight.png"
#define PNG_HEAD_TALK @"talk.png"

#define PNG_BODY_NORMAL @"bodyNormal.png"
#define PNG_BODY_BIG_0 @"big0.png"
#define PNG_BODY_BIG_1 @"big1.png"
#define PNG_BODY_BIG_2 @"big2.png"
#define PNG_BODY_BIG_3 @"big3.png"
#define PNG_BODY_SHIT @"shit.png"

#define ANIM_HEAD_EAT @"eat"

#define SOUND_EAT_PUMPKIN_EN @"eatPumpkin-en.caf"
#define SOUND_EAT_TOMATO_EN @"eatTomato-en.caf"
#define SOUND_EAT_POTATO_EN @"eatPotato-en.caf"
#define SOUND_EAT_MUSHROOM_EN @"eatMushroom-en.caf"
#define SOUND_EAT_CARROT_EN @"eatCarrot-en.caf"
#define SOUND_EAT_CORN_EN @"eatCorn-en.caf"

#define SOUND_EAT_PUMPKIN_CN @"eatPumpkin-cn.caf"
#define SOUND_EAT_TOMATO_CN @"eatTomato-cn.caf"
#define SOUND_EAT_POTATO_CN @"eatPotato-cn.caf"
#define SOUND_EAT_MUSHROOM_CN @"eatMushroom-cn.caf"
#define SOUND_EAT_CARROT_CN @"eatCarrot-cn.caf"
#define SOUND_EAT_CORN_CN @"eatCorn-cn.caf"

#define SOUND_EAT_PUMPKIN_JP @"eatPumpkin-jp.caf"
#define SOUND_EAT_TOMATO_JP @"eatTomato-jp.caf"
#define SOUND_EAT_POTATO_JP @"eatPotato-jp.caf"
#define SOUND_EAT_MUSHROOM_JP @"eatMushroom-jp.caf"
#define SOUND_EAT_CARROT_JP @"eatCarrot-jp.caf"
#define SOUND_EAT_CORN_JP @"eatCorn-jp.caf"

#define EFFECT_RIGHT @"eatRight.caf"
#define EFFECT_WRONG @"eatWrong.caf"
//#define EFFECT_EAT_SHIT @"shit.caf"
#define EFFECT_EAT_SHIT_0 @"shit0.caf"
#define EFFECT_EAT_SHIT_1 @"shit1.caf"
#define EFFECT_EAT_SHIT_2 @"shit2.caf"

typedef enum
{
    NBHeadNormalTagAction = 0,
    NBHeadOpenMouthTagAction,
    NBHeadEatTagAction,
    NBHeadWrongTagAction,
    NBHeadRightTagAction,
    NBBodyNormalTgAction,
    NBBodyBig0TagAction,
    NBBodyBig1TagAction,
    NBBodyBig2TagAction,
    NBBodyBig3TagAction,
    NBBodyShitTagAction,
    
}NewBoyActionTags;

@interface NewBoy : NSObject<CCTargetedTouchDelegate> {
    
    CCSprite *headSprite;
    CCSprite *bodySprite;
    CCSprite *shitSprite;
    CCSprite *talkSprite;
    
    CCSpriteFrame *frame;
    CCSpriteFrameCache *frameCache;
    
    int fruitTag;
    
    //已经吃的水果记数
    int fruitCount;
    
    CGSize screenSize;
    
    ALuint sound;
}

@property BOOL isTouchHandled;

@property BOOL isSpeakAnimLocked;

//@property (nonatomic, retain) id<boyBusyDelegate> delegate;

+ (id)boyWithParentNode:(CCNode *)parentNode;

- (void)boySetActionByActionTag:(int)boyTagActions fruitTag:(int)boyTagFruit;

- (CGRect)getBoyHeadSpriteRect;

- (BOOL)isAnimationLocked;

//- (BOOL)isBoyFavoritesWithFruitTag:(int)tag;

@end
