//
//  ZZNavBar.h
//  Brazil
//
//  Created by zhaozilong on 12-11-6.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MainScene.h"
#import "ChooseBallLayer.h"
#import "SimpleAudioEngine.h"

// 是否模拟器
#define isSimulator (NSNotFound != [[[UIDevice currentDevice] model] rangeOfString:@"Simulator"].location)

#define LOCALIZED_NAME @"localized"
#define LOCALIZED_ENGLISH @"en"
#define LOCALIZED_CHINESE @"cn"
#define LOCALIZED_JAPANESE @"jp"

@interface ZZNavBar : CCLayer {
    CCSprite *titleSprite;
    CCLabelTTF *titleLabelUp;
    CCLabelTTF *titleLabelDown;
//    CCMenuItem *homeItem;
    
    CCNode *worldScene;
    
    CGFloat fontsize;
}

//@property (nonatomic, retain) CCMenuItemToggle *EnOrCn;

@property BOOL isEnglish;

- (void)setTitleLabelWithString:(NSString *)str;

- (void)setTitleLabelWithString:(NSString *)str line1ScaleTo:(CGFloat)scale1 line2ScaleTo:(CGFloat)scale2;

- (void)transToMainScene;

- (void)transToOtherLanguage;

- (void)stopActionWithScene:(CCNode *)scene;

- (void)playSoundByNameEn:(NSString *)soundEn Cn:(NSString *)soundCn Jp:(NSString *)soundJp;

+ (BOOL)isiPad;

+ (BOOL)isiPhone5;

//+ (BOOL)isiPhoneNormalScreen;

+ (BOOL)isRetina;

//+ (BOOL)isiPhone4Retina;

+ (void)playGoEffect;

+ (void)playBackEffect;

+ (int)getLocalizedLanguage;

+ (int)getLocalizedLanguageByStr:(NSString *)language;

+ (int)getNumberEnCnJp;

+ (NSString *)getStringEnCnJp;

+(CGPoint) locationFromTouch:(UITouch*)touch;

@end
