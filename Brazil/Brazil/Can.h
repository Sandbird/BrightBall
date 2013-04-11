//
//  Can.h
//  Brazil
//
//  Created by zhaozilong on 12-11-29.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SimpleAudioEngine.h"
#import "RubbishScene.h"

#define PNG_CAN_RECYCLE @"can0.png"
#define PNG_CAN_HARM @"can1.png"
#define PNG_CAN_KITCHEN @"can2.png"
#define PNG_CAN_RIGHT_1 @"right0.png"
#define PNG_CAN_RIGHT_2 @"right1.png"
#define PNG_CAN_RIGHT_3 @"right2.png"
#define PNG_CAN_WRONG_1 @"wrong0.png"
#define PNG_CAN_WRONG_2 @"wrong1.png"
#define PNG_CAN_WRONG_3 @"wrong2.png"

#define PNG_HEAD_NORMAL @"headNormal.png"
#define PNG_HEAD_OPEN_MOUTH @"openMouth.png"
#define PNG_HEAD_WRONG @"headWrong.png"
#define PNG_HEAD_RIGHT @"headRight.png"

#define PNG_BODY_NORMAL @"bodyNormal.png"
#define PNG_BODY_BIG_0 @"big0.png"
#define PNG_BODY_BIG_1 @"big1.png"
#define PNG_BODY_BIG_2 @"big2.png"
#define PNG_BODY_BIG_3 @"big3.png"
#define PNG_BODY_SHIT @"shit.png"

#define ANIM_HEAD_EAT @"eat"

typedef enum
{
    CanRecycleTag = 0,
    CanHarmTag,
    CanKitchenTag,
    
}CanTags;

@interface Can : NSObject <CCTargetedTouchDelegate> {
//    CCSprite *can1Sprite;
//    CCSprite *can2Sprite;
//    CCSprite *can3Sprite;
    
    CCSpriteFrame *frame;
    CCSpriteFrameCache *frameCache;
    
    int fruitTag;
    
    //已经吃的水果记数
    int fruitCount;
    
    CGSize screenSize;
    
    ALuint sound;
    
    BOOL isCanAnimLocked;
    
    CCSprite *right1Sprite;
    CCSprite *right2Sprite;
    CCSprite *right3Sprite;
    
    CCSprite *wrong1Sprite;
    CCSprite *wrong2Sprite;
    CCSprite *wrong3Sprite;

}

@property (nonatomic, retain) CCSprite *can1Sprite;
@property (nonatomic, retain) CCSprite *can2Sprite;
@property (nonatomic, retain) CCSprite *can3Sprite;

@property BOOL isTouchHandled;

+ (id)canWithParentNode:(CCNode *)parentNode;

//- (void)canSetActionByActionTag:(int)canTagActions fruitTag:(int)canTagFruit;

- (CGRect)getCanSpriteRectByCanTags:(int)canTag;

//- (BOOL)isAnimationLocked;

- (void)setCanScaleAnim:(BOOL)isBig;

- (void)setCanAnimByCanTag:(int)canTag rubbishTag:(int)rubbishTag;

- (BOOL)isCanAnimationLocked;

@end
