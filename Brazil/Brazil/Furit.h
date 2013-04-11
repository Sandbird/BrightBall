//
//  Furit.h
//  Brazil
//
//  Created by zhaozilong on 12-10-31.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "EatFuritsScene.h"


static NSString *fruitAppleName = @"apple";
static NSString *fruitGrapeName = @"grape";
static NSString *fruitBananaName = @"banana";
static NSString *fruitCherryName = @"cherry";
static NSString *fruitOrangeName = @"orange";
static NSString *fruitWatermelonName = @"watermelon";
static NSString *fruitDurianName = @"durian";

#define SOUND_APPLE_EN @"apple-en.caf"
#define SOUND_GRAPE_EN @"grape-en.caf"
#define SOUND_BANANA_EN @"banana-en.caf"
#define SOUND_CHERRY_EN @"cherry-en.caf"
#define SOUND_DURIAN_EN @"durian-en.caf"
#define SOUND_WATERMELON_EN @"watermelon-en.caf"
#define SOUND_ORANGE_EN @"orange-en.caf"

#define SOUND_APPLE_CN @"apple-cn.caf"
#define SOUND_GRAPE_CN @"grape-cn.caf"
#define SOUND_BANANA_CN @"banana-cn.caf"
#define SOUND_CHERRY_CN @"cherry-cn.caf"
#define SOUND_DURIAN_CN @"durian-cn.caf"
#define SOUND_WATERMELON_CN @"watermelon-cn.caf"
#define SOUND_ORANGE_CN @"orange-cn.caf"

#define SOUND_APPLE_JP @"apple-jp.caf"
#define SOUND_GRAPE_JP @"grape-jp.caf"
#define SOUND_BANANA_JP @"banana-jp.caf"
#define SOUND_CHERRY_JP @"cherry-jp.caf"
#define SOUND_DURIAN_JP @"durian-jp.caf"
#define SOUND_WATERMELON_JP @"watermelon-jp.caf"
#define SOUND_ORANGE_JP @"orange-jp.caf"

typedef enum
{
    FruitAppleTag = 10,
    FruitGrapeTag,
    FruitBananaTag,
    FruitCherryTag,
    FruitOrangeTag,
    FruitWatermelonTag,
    FruitDurianTag,
    
}FruitNameTag;

@interface Furit : NSObject <CCTargetedTouchDelegate> {
    
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
