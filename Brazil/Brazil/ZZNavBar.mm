//
//  ZZNavBar.m
//  Brazil
//
//  Created by zhaozilong on 12-11-6.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "ZZNavBar.h"
#import "EatFuritsScene.h"

//判断设备是IPHONE还是IPAD
#define IPAD_DEVICE [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad
#define IPHONE5_DEVICE [[UIScreen mainScreen] bounds].size.height == 568.000000

#define EFFECT_GO @"goEffect.caf"
#define EFFECT_BACK @"backEffect.caf"
#define EFFECT_BARK @"bark.caf"

@implementation ZZNavBar

@synthesize isEnglish = _isEnglish;
//@synthesize EnOrCn = _EnOrCn;

- (void)dealloc {
    
    CCLOG(@"navbar dealloc");
    [super dealloc];
}

- (id)init {
    
    if (self = [super init]) {
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        _isEnglish = YES;
        
        CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        [frameCache addSpriteFramesWithFile:@"navBar.plist"];
        CCSpriteFrame *frame;
        
        CGPoint homePoint, helpPoint, titleSpritePoint, titleLabelUpPoint, titleLabelDownPoint;
        if ([ZZNavBar isiPad]) {
            fontsize = 44;
            homePoint = ccp(0 + 40, size.height - 23);
            helpPoint = ccp(size.width - 40, size.height - 23);
            titleSpritePoint = ccp(size.width / 2, size.height - 10);
            titleLabelUpPoint = ccp(size.width / 2, size.height - 15);
            titleLabelDownPoint = ccp(size.width / 2, size.height - 70);
        } else {
            fontsize = 22;
            homePoint = ccp(0 + 10, size.height - 15);
            helpPoint = ccp(size.width - 10, size.height - 15);
            titleSpritePoint = ccp(size.width / 2, size.height - 10);
            titleLabelUpPoint = ccp(size.width / 2, size.height - 15);
            titleLabelDownPoint = ccp(size.width / 2, size.height - 40);
        }
        
        frame = [frameCache spriteFrameByName:@"titleBarPink.png"];
        titleSprite = [CCSprite spriteWithSpriteFrame:frame];
        titleSprite.anchorPoint = ccp(0.5, 1);
        titleSprite.position = titleSpritePoint;
        [self addChild:titleSprite];
        
        CGSize fontSize = CGSizeMake(titleSprite.boundingBox.size.width * 2, titleSprite.boundingBox.size.height / 2);
        titleLabelUp = [CCLabelTTF labelWithString:@"" dimensions:fontSize alignment:NSTextAlignmentCenter fontName:@"MarkerFelt-Thin" fontSize:fontsize];
        titleLabelDown = [CCLabelTTF labelWithString:@"" dimensions:fontSize alignment:NSTextAlignmentCenter fontName:@"MarkerFelt-Thin" fontSize:fontsize];
//        titleLabel = [CCLabelTTF labelWithString:@"" dimensions:titleSprite.boundingBox.size alignment:NSTextAlignmentCenter fontName:@"MarkerFelt-Thin" fontSize:fontsize];
        titleLabelUp.color = ccBLACK;
        titleLabelUp.anchorPoint = ccp(0.5, 1);
        titleLabelUp.position = titleLabelUpPoint;
        titleLabelDown.color = ccBLACK;
        titleLabelDown.anchorPoint = ccp(0.5, 1);
        titleLabelDown.position = titleLabelDownPoint;
        [self addChild:titleLabelUp];
        [self addChild:titleLabelDown];
        
        
        //加返回按钮和主页按钮
        CCSprite *homeSprite = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"home.png"]];
        CCSprite *home2Sprite = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"home2.png"]];
        CCMenuItem *homeItem = [CCMenuItemImage itemFromNormalSprite:homeSprite selectedSprite:home2Sprite disabledSprite:nil target:self selector:@selector(transToMainScene)];
        
        
        CCSprite *EnglishSprite = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"English.png"]];
        CCSprite *English2Sprite = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"English2.png"]];
        
        CCSprite *OtherLanguageSprite = nil;
        CCSprite *OtherLanguage2Sprite = nil;
        switch ([ZZNavBar getNumberEnCnJp]) {
                
            case 3://日语
                OtherLanguageSprite = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"Japanese.png"]];
                OtherLanguage2Sprite = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"Japanese2.png"]];
                break;
                
            default://其他语言，除了中文，其他语种群补吟唱切换语言按钮
                OtherLanguageSprite = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"Chinese.png"]];
                OtherLanguage2Sprite = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"Chinese2.png"]];
                break;
        }

        CCMenuItem *EnItem = [CCMenuItemImage itemFromNormalSprite:EnglishSprite selectedSprite:English2Sprite];
        
        CCMenuItem *OtherLanguageItem = [CCMenuItemImage itemFromNormalSprite:OtherLanguageSprite selectedSprite:OtherLanguage2Sprite];
        
        CCMenuItemToggle *EnOrCn = [CCMenuItemToggle itemWithTarget:self selector:@selector(transToOtherLanguage) items:EnItem, OtherLanguageItem, nil];
        
        
        
        CCMenu *mainMenu = nil;
        switch ([ZZNavBar getNumberEnCnJp]) {
            case 1://英语
                mainMenu = [CCMenu menuWithItems:homeItem, nil];
                EnOrCn = nil;
                break;
            case 2://汉语
            case 3://日语
                mainMenu = [CCMenu menuWithItems:homeItem, EnOrCn, nil];
                EnOrCn.anchorPoint = ccp(1, 1);
                EnOrCn.position = helpPoint;
                break;
                
            default:
                break;
        }
        
        mainMenu.position = ccp(0, 0);
        homeItem.anchorPoint = ccp(0, 1);
        homeItem.position = homePoint;
        [self addChild:mainMenu];
    }
    
    return self;
 
}

- (void)setTitleLabelWithString:(NSString *)str {
    [self setStringForTwoLines:str];
}

- (void)setTitleLabelWithString:(NSString *)str line1ScaleTo:(CGFloat)scale1 line2ScaleTo:(CGFloat)scale2 {
    [self setStringForTwoLines:str];
    
    [titleLabelUp setScale:scale1];
    [titleLabelDown setScale:scale2];
}

- (void)setStringForTwoLines:(NSString *)str {
    NSArray *strArray = [str componentsSeparatedByString:@"\n"];
    int count = [strArray count];
    switch (count) {
        case 0:
            NSAssert(NO, @"ERROR, count == 0");
            break;
            
        case 1:
            [titleLabelUp setString:str];
            [titleLabelDown setString:nil];
            break;
            
        case 2:
        default:
            
            [titleLabelUp setString:[strArray objectAtIndex:0]];
            NSString *tempStr = [strArray objectAtIndex:1];
            [titleLabelDown setString:tempStr];
            [self setStringFitToLabel:tempStr isUp:NO];
            break;
    }
}

- (void)setStringFitToLabel:(NSString *)str isUp:(BOOL)isUp {
    CCLabelTTF *strLabel = [CCLabelTTF labelWithString:str fontName:@"MarkerFelt-Thin" fontSize:fontsize];
    if (strLabel.contentSize.width > titleSprite.boundingBox.size.width) {
        if (isUp) {
            titleLabelUp.scale = titleSprite.boundingBox.size.width / strLabel.boundingBox.size.width;
        } else {
            titleLabelDown.scale = titleSprite.boundingBox.size.width / strLabel.contentSize.width;
        }
    } else {
        [titleLabelUp setScale:1.0];
        [titleLabelDown setScale:1.0];
    }
}

- (void)transToMainScene {

    [ZZNavBar playBackEffect];
    [ZZNavBar resumeBackgroundMusicPlay];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[ChooseBallLayer scene] withColor:ccWHITE]];

}

- (void)transToOtherLanguage {
    
    [ZZNavBar playBarkEffect];
    if (_isEnglish) {
        _isEnglish = NO;
        
    } else {
        _isEnglish = YES;
    }
}

- (void)stopActionWithScene:(CCNode *)scene {
    worldScene = scene;
}

+ (BOOL)isiPad {
    
    return ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad);
}

+ (BOOL)isiPhone5 {
    return ([[UIScreen mainScreen] bounds].size.height == 568.000000);
}

+ (BOOL)isiPhoneNormalScreen {
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] currentMode].size) : NO);
}

+ (BOOL)isRetina {
    
    return ([[CCDirector sharedDirector] contentScaleFactor] == 2);
}

+ (BOOL)isiPhone4Retina {
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO);
}

+ (void)resumeBackgroundMusicPlay {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL isPauseMusic = [userDefaults boolForKey:IS_PAUSE_MUSIC];
    if (isPauseMusic == NO) {
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:BACKGROUND_MUSIC];
    }
}

+ (void)playGoEffect {
    [[SimpleAudioEngine sharedEngine] playEffect:EFFECT_GO];
}

+ (void)playBarkEffect {
    [[SimpleAudioEngine sharedEngine] playEffect:EFFECT_BARK];
}

+ (void)playBackEffect {
    [[SimpleAudioEngine sharedEngine] playEffect:EFFECT_BACK];
}

//1:En 2:Cn 3:Jp 4:CnHK
+ (int)getLocalizedLanguage {
    if ([NSLocalizedString(@"localized", nil) isEqualToString:@"cn"] || [NSLocalizedString(@"localized", nil) isEqualToString:@"cnHK"]) {
        return 2;
    } else if ([NSLocalizedString(@"localized", nil) isEqualToString:@"jp"]) {
        return 3;
    } else {
        return 1;
    }
}

+ (int)getLocalizedLanguageByStr:(NSString *)language {
    if ([language isEqualToString:@"cn"]) {
        return 2;
    } else if ([language isEqualToString:@"jp"]) {
        return 3;
    } else {
        return 1;
    }
}

+ (int)getNumberEnCnJp {
    NSString *name = [[NSUserDefaults standardUserDefaults] stringForKey:LOCALIZED_NAME];
    
    int language = 0;
    if (name == nil) {
        
        language = [ZZNavBar getLocalizedLanguage];
//        CCLOG(@"根据系统语言%i", language);
    } else {
        
        language = [ZZNavBar getLocalizedLanguageByStr:name];
//        CCLOG(@"根据用户选择语言%i", language);
    }
    
    return language;

}

+ (NSString *)getStringEnCnJp {
    NSString *name = [[NSUserDefaults standardUserDefaults] stringForKey:LOCALIZED_NAME];
    
    if (name == nil) {
        
        switch ([ZZNavBar getLocalizedLanguage]) {
            case 1:
                name = LOCALIZED_ENGLISH;
                break;
            case 2:
                name = LOCALIZED_CHINESE;
                break;
            case 3:
                name = LOCALIZED_JAPANESE;
                break;
                
            default:
                CCLOG(@"");
                break;
        }
        
    }
    
    return name;
    
}

- (void)playSoundByNameEn:(NSString *)soundEn Cn:(NSString *)soundCn Jp:(NSString *)soundJp {
    if (_isEnglish) {
        [[SimpleAudioEngine sharedEngine] playEffect:soundEn];
    } else {
        if ([ZZNavBar getNumberEnCnJp] == 2) {
            [[SimpleAudioEngine sharedEngine] playEffect:soundCn];
        } else {
            [[SimpleAudioEngine sharedEngine] playEffect:soundJp];
        }
    }
}

+(CGPoint) locationFromTouch:(UITouch*)touch
{
	CGPoint touchLocation = [touch locationInView: [touch view]];
	return [[CCDirector sharedDirector] convertToGL:touchLocation];
}


@end
