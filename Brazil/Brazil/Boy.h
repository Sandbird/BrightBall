//
//  Boy.h
//  Brazil
//
//  Created by zhaozilong on 12-10-30.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "CCAnimationHelper.h"
#import "EatFuritsScene.h"
#import "Furit.h"

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

#define SOUND_EAT_APPLE_EN @"eatApple-en.caf"
#define SOUND_EAT_GRAPE_EN @"eatGrape-en.caf"
#define SOUND_EAT_BANANA_EN @"eatBanana-en.caf"
#define SOUND_EAT_CHERRY_EN @"eatCherry-en.caf"
#define SOUND_EAT_DURIAN_EN @"eatDurian-en.caf"
#define SOUND_EAT_WATERMELON_EN @"eatWatermelon-en.caf"
#define SOUND_EAT_ORANGE_EN @"eatOrange-en.caf"

#define SOUND_EAT_APPLE_CN @"eatApple-cn.caf"
#define SOUND_EAT_GRAPE_CN @"eatGrape-cn.caf"
#define SOUND_EAT_BANANA_CN @"eatBanana-cn.caf"
#define SOUND_EAT_CHERRY_CN @"eatCherry-cn.caf"
#define SOUND_EAT_DURIAN_CN @"eatDurian-cn.caf"
#define SOUND_EAT_WATERMELON_CN @"eatWatermelon-cn.caf"
#define SOUND_EAT_ORANGE_CN @"eatOrange-cn.caf"

#define SOUND_EAT_APPLE_JP @"eatApple-jp.caf"
#define SOUND_EAT_GRAPE_JP @"eatGrape-jp.caf"
#define SOUND_EAT_BANANA_JP @"eatBanana-jp.caf"
#define SOUND_EAT_CHERRY_JP @"eatCherry-jp.caf"
#define SOUND_EAT_DURIAN_JP @"eatDurian-jp.caf"
#define SOUND_EAT_WATERMELON_JP @"eatWatermelon-jp.caf"
#define SOUND_EAT_ORANGE_JP @"eatOrange-jp.caf"

#define EFFECT_EAT_RIGHT @"eatRight.caf"
#define EFFECT_EAT_WRONG @"eatWrong.caf"
#define EFFECT_SHIT_0 @"shit0.caf"
#define EFFECT_SHIT_1 @"shit1.caf"
#define EFFECT_SHIT_2 @"shit2.caf"

#define ANIM_HEAD_EAT @"eat"

typedef enum
{
    HeadNormalTagAction = 0,
    HeadOpenMouthTagAction,
    HeadEatTagAction,
    HeadWrongTagAction,
    HeadRightTagAction,
    BodyNormalTgAction,
    BodyBig0TagAction,
    BodyBig1TagAction,
    BodyBig2TagAction,
    BodyBig3TagAction,
    BodyShitTagAction,
    
}BoyActionTags;

@interface Boy : NSObject<CCTargetedTouchDelegate> {
    
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
    
    GLuint sound;
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
