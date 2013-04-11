//
//  Vegetable.h
//  Brazil
//
//  Cred by zhaozilong on 12-12-7.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "VegetablesScene.h"
#import "SimpleAudioEngine.h"
//#import "Boy.h"

static NSString *NBfruitAppleName = @"carrot";
static NSString *NBfruitGrapeName = @"corn";
static NSString *NBfruitBananaName = @"mushroom";
static NSString *NBfruitCherryName = @"pumpkin";
static NSString *NBfruitOrangeName = @"tomato";
static NSString *NBfruitWatermelonName = @"potato";

#define SOUND_PUMPKIN_EN @"pumpkin-en.caf"
#define SOUND_TOMATO_EN @"tomato-en.caf"
#define SOUND_POTATO_EN @"potato-en.caf"
#define SOUND_MUSHROOM_EN @"mushroom-en.caf"
#define SOUND_CARROT_EN @"carrot-en.caf"
#define SOUND_CORN_EN @"corn-en.caf"

#define SOUND_PUMPKIN_CN @"pumpkin-cn.caf"
#define SOUND_TOMATO_CN @"tomato-cn.caf"
#define SOUND_POTATO_CN @"potato-cn.caf"
#define SOUND_MUSHROOM_CN @"mushroom-cn.caf"
#define SOUND_CARROT_CN @"carrot-cn.caf"
#define SOUND_CORN_CN @"corn-cn.caf"

#define SOUND_PUMPKIN_JP @"pumpkin-jp.caf"
#define SOUND_TOMATO_JP @"tomato-jp.caf"
#define SOUND_POTATO_JP @"potato-jp.caf"
#define SOUND_MUSHROOM_JP @"mushroom-jp.caf"
#define SOUND_CARROT_JP @"carrot-jp.caf"
#define SOUND_CORN_JP @"corn-jp.caf"


typedef enum
{
    NBFruitAppleTag = 10,
    NBFruitGrapeTag,
    NBFruitBananaTag,
    NBFruitCherryTag,
    NBFruitOrangeTag,
    NBFruitWatermelonTag,
//    FruitDurianTag,
    
}NBFruitNameTag;

@interface Vegetable : NSObject <CCTargetedTouchDelegate> {
    
    CCSprite *fruitSprite;
    
    //    int currentFruitTag;
    
    CGPoint defaultPosition;
	CGPoint lastTouchLocation;
    
    NSString *soundFruitName;
    NSString *soundFruitNameCN;
    
}

@property (nonatomic, retain) NSString *pngFruitName;
@property BOOL isTouchHandled;
@property int currentFruitTag;
//@property (nonatomic, retain) CCSprite *fruitSprite;
//@property CGPoint currentTouchLocation;

+ (id)furitWithParentNode:(CCNode *)parentNode fruitTag:(int)fruitNameTag position:(CGPoint)point;
- (CGRect)getFruitSpriteRect;
- (void)setFruitSpriteVisible:(BOOL)isVisible;
- (void)setFruitSpriteAppearEffect;
//- (BOOL)isAnimationLocked;

@end
