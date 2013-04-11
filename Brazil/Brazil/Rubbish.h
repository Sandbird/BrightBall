//
//  Rubbish.h
//  Brazil
//
//  Created by zhaozilong on 12-11-29.
//
//

#import <Foundation/Foundation.h>
#import "RubbishScene.h"
#import "SimpleAudioEngine.h"

static NSString *rubbishDiskName = @"disk";
static NSString *rubbishPlasticName = @"plastic";
static NSString *rubbishCokeName = @"coke";//coke == 香蕉皮bananaSkin
static NSString *rubbishBottleName = @"bottle";
static NSString *rubbishBatteryName = @"battery";// battery == 鱼刺fishbone
static NSString *rubbishNewspaperName = @"newspaper";


typedef enum
{
    RubbishDiskTag = 10,
    RubbishPlasticTag,
    RubbishCokeTag,
    RubbishBottleTag,
    RubbishBatteryTag,
    RubbishNewspaperTag,
    
}RubbishNameTag;

@interface Rubbish : NSObject <CCTargetedTouchDelegate> {
    
    CCSprite *rubbishSprite;
    
    CGPoint defaultPosition;
	CGPoint lastTouchLocation;
    
    NSString *soundRubbishName;
    NSString *soundRubbishNameCN;
    
}

@property (nonatomic, retain) NSString *pngRubbishName;
@property BOOL isTouchHandled;
@property int currentRubbishTag;
@property CGPoint lastTouchPoint;

+ (id)rubbishWithParentNode:(CCNode *)parentNode rubbishTag:(int)rubbishNameTag position:(CGPoint)point;

- (void)setSpritePostion:(CGPoint)point;

- (CGRect)getRubbishSpriteRect;

- (void)setRubbishSpriteVisible:(BOOL)isVisible;

- (void)setRubbishSpriteAppearEffect;

//+ (id)furitWithParentNode:(CCNode *)parentNode fruitTag:(int)fruitNameTag position:(CGPoint)point;
//- (CGRect)getFruitSpriteRect;
//- (void)setFruitSpriteVisible:(BOOL)isVisible;
//- (void)setFruitSpriteAppearEffect;

@end
