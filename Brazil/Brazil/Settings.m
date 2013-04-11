//
//  Settings.m
//  Brazil
//
//  Created by zhaozilong on 12-12-26.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "Settings.h"
#import "ZZNavBar.h"


@implementation Settings

- (void)dealloc {

    
    [super dealloc];
}

- (id)init {
    
    if (self = [super init]) {
        
        self.isTouchEnabled = YES;
        
        self.scale = 0;
        
        screenSize = [[CCDirector sharedDirector] winSize];
        
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
        
        //add texture to momery
        CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
//        [frameCache addSpriteFramesWithFile:@"settings.plist"];

        CCSprite *bgSprite = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"settingsBG.png"]];
        [self addChild:bgSprite];
        bgSprite.position = ccp(screenSize.width / 2, screenSize.height / 2);
        
        switch ([ZZNavBar getNumberEnCnJp]) {
            case 1:
                languageSprite = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"languageEN.png"]];
                break;
            case 2:
                languageSprite = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"languageCN.png"]];
                break;
            case 3:
                languageSprite = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"languageJP.png"]];
                break;
                
            default:
                break;
        }
        [self addChild:languageSprite];
        languageSprite.position = bgSprite.position;
        
        
        //加返回按钮和主页按钮
        CCSprite *backSprite = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"close.png"]];
        CCSprite *back2Sprite = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"close2.png"]];
        CCMenuItem *backItem = [CCMenuItemImage itemFromNormalSprite:backSprite selectedSprite:back2Sprite disabledSprite:nil target:self selector:@selector(closeSettings)];
        
        //增加一个更多应用
        CCSprite *moreAppSprite = [CCSprite spriteWithFile:@"moreApp.png"];
        CCMenuItem *moreAppItem = [CCMenuItemImage itemFromNormalSprite:moreAppSprite selectedSprite:nil disabledSprite:nil target:self selector:@selector(openMoreApp)];
        
        
        //背景音乐开关
        CCSprite *openSprite = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"musicOn.png"]];
        CCSprite *closeSprite = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"musicOff.png"]];
        CCMenuItem *openItem = [CCMenuItemImage itemFromNormalSprite:openSprite selectedSprite:nil];
        CCMenuItem *closeItem = [CCMenuItemImage itemFromNormalSprite:closeSprite selectedSprite:nil];
        CCMenuItemToggle *OnOffToggle = [CCMenuItemToggle itemWithTarget:self selector:@selector(openMusic) items:openItem, closeItem, nil];
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        BOOL isPauseMusic = [userDefaults boolForKey:IS_PAUSE_MUSIC];
        if (isPauseMusic == NO) {
            [OnOffToggle setSelectedIndex:0];
        } else{
            [OnOffToggle setSelectedIndex:1];
        }
        
        
        
        //评价按钮
        CCSprite *rateSprite = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"rate.png"]];
        CCMenuItem *rateItem = [CCMenuItemImage itemFromNormalSprite:rateSprite selectedSprite:nil disabledSprite:nil target:self selector:@selector(rateMe)];
        
        //选择语言按钮
        CCSprite *En0 = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"English0.png"]];
        CCSprite *En1 = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"English1.png"]];
        CCSprite *Cn0 = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"Chinese0.png"]];
        CCSprite *Cn1 = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"Chinese1.png"]];
        CCSprite *Jp0 = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"Japanese0.png"]];
        CCSprite *Jp1 = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"Japanese1.png"]];
        CCMenuItem *En0Item = [CCMenuItemImage itemFromNormalSprite:En0 selectedSprite:nil];
        CCMenuItem *En1Item = [CCMenuItemImage itemFromNormalSprite:En1 selectedSprite:nil];
        CCMenuItem *Cn0Item = [CCMenuItemImage itemFromNormalSprite:Cn0 selectedSprite:nil];
        CCMenuItem *Cn1Item = [CCMenuItemImage itemFromNormalSprite:Cn1 selectedSprite:nil];
        CCMenuItem *Jp0Item = [CCMenuItemImage itemFromNormalSprite:Jp0 selectedSprite:nil];
        CCMenuItem *Jp1Item = [CCMenuItemImage itemFromNormalSprite:Jp1 selectedSprite:nil];
        OnOffEn = [CCMenuItemToggle itemWithTarget:self selector:@selector(onOffEnglish) items:En0Item, En1Item, nil];
        OnOffCn = [CCMenuItemToggle itemWithTarget:self selector:@selector(onOffChinese) items:Cn0Item, Cn1Item, nil];
        OnOffJp = [CCMenuItemToggle itemWithTarget:self selector:@selector(onOffJapanese) items:Jp0Item, Jp1Item, nil];
        NSString *name = [[NSUserDefaults standardUserDefaults] stringForKey:LOCALIZED_NAME];
        [OnOffEn setSelectedIndex:0];
        [OnOffCn setSelectedIndex:0];
        [OnOffJp setSelectedIndex:0];
        int language = 0;
        
        if (name == nil) {
            
            language = [ZZNavBar getLocalizedLanguage];
            CCLOG(@"根据系统语言%i", language);
        } else {
            
            language = [ZZNavBar getLocalizedLanguageByStr:name];
            CCLOG(@"根据用户选择语言%i", language);
        }
        switch (language) {
            case 1://English
                [OnOffEn setSelectedIndex:1];
                break;
                
            case 2://Chinese
                [OnOffCn setSelectedIndex:1];
                break;
                
            case 3://Japanese
                [OnOffJp setSelectedIndex:1];
                break;
                
            default:
                break;
        }
        
        
        //菜单
        CCMenu *mainMenu = [CCMenu menuWithItems:backItem, moreAppItem, OnOffToggle, rateItem, OnOffEn, OnOffCn, OnOffJp, nil];
        
        CGPoint backPos, musicPos, ratePos, enPos, cnPos, jpPos, moreAppPoint;
        if ([ZZNavBar isiPad]) {
            backPos = ccp(screenSize.width / 2 + 180, screenSize.height / 2 + 210);
            musicPos = ccp(500, 600);
            ratePos = ccp(screenSize.width / 2 + 105, screenSize.height / 2 + 5);

            cnPos = ccp(screenSize.width / 2 - 20, screenSize.height / 2 - 80);
            jpPos = ccp(screenSize.width / 2 + 70, screenSize.height / 2 - 80);
            enPos = ccp(screenSize.width / 2 + 160, screenSize.height / 2 - 80);
            
            moreAppPoint = ccp(screenSize.width / 2 - 135, screenSize.height / 2 - 225);
            
        } else {
            if ([ZZNavBar isiPhone5]) {
                backPos = ccp(screenSize.width / 2 + 85, screenSize.height / 2 + 105);
                musicPos = ccp(203, 327);
                ratePos = ccp(screenSize.width / 2 + 40, screenSize.height / 2);
                
                cnPos = ccp(screenSize.width / 2, screenSize.height / 2 - 45);
                jpPos = ccp(screenSize.width / 2 + 40, screenSize.height / 2 - 45);
                enPos = ccp(screenSize.width / 2 + 80, screenSize.height / 2 - 45);
                
                moreAppPoint = ccp(screenSize.width / 2 - 60, screenSize.height / 2 - 120);
            } else {
                backPos = ccp(screenSize.width / 2 + 82, screenSize.height / 2 + 100);
                musicPos = ccp(210, 273);
                ratePos = ccp(screenSize.width / 2 + 45, screenSize.height / 2 - 10);
                
                cnPos = ccp(screenSize.width / 2, screenSize.height / 2 - 55);
                jpPos = ccp(screenSize.width / 2 + 40, screenSize.height / 2 - 55);
                enPos = ccp(screenSize.width / 2 + 80, screenSize.height / 2 - 55);
                
                moreAppPoint = ccp(screenSize.width / 2 - 60, screenSize.height / 2 - 100);
            }
        }
        
        mainMenu.position = ccp(0, 0);
        backItem.position = backPos;
        OnOffToggle.position = musicPos;
        rateItem.position = ratePos;
        moreAppItem.position = moreAppPoint;
        
        OnOffEn.position = enPos;
        OnOffCn.position = cnPos;
        OnOffJp.position = jpPos;
        
        [self addChild:mainMenu z:1];
    }

    return self;
}

- (void)rateMe {
    //Jump to appstore to rate me
    [ZZNavBar playBackEffect];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=590220714"]];
}

- (void)openMoreApp {
    //Jump to more apps
    [ZZNavBar playBackEffect];
    
    UIAlertView * alert = nil;
    switch ([ZZNavBar getNumberEnCnJp]) {
            
        case 1:
            alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Jump to More Apps page?" delegate:self cancelButtonTitle:@"Later" otherButtonTitles:@"Yes", nil];
            break;
        case 2:
            alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定访问更多应用网站吗?" delegate:self cancelButtonTitle:@"以后再说" otherButtonTitles:@"现在就去", nil];
            break;
        case 3:
            alert = [[UIAlertView alloc] initWithTitle:@"メセッジ" message:@"More Appsへ?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
            break;
            
        default:
            break;
    }
    
    alert.tag = 1234;
    [alert show];
    [alert release];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag == 1234) {
        if (buttonIndex == 1) {
            
            switch ([ZZNavBar getNumberEnCnJp]) {
                case 2:
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://app.iyuba.com/ios/"]];
                    break;
                    
                default:
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://app.iyuba.com/ios/indexjp.jsp"]];
                    break;
            }
            
            
        }
    }
    
}


- (void)openMusic {
    
    [ZZNavBar playBackEffect];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL isPauseMusic = [userDefaults boolForKey:IS_PAUSE_MUSIC];
    if (isPauseMusic == NO) {
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        [userDefaults setBool:YES forKey:IS_PAUSE_MUSIC];
    } else{
        [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:BACKGROUND_MUSIC];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:BACKGROUND_MUSIC loop:YES];
        [userDefaults setBool:NO forKey:IS_PAUSE_MUSIC];
    }
    

}

- (void)closeSettings {
    [ZZNavBar playBackEffect];
    
    [[CCTouchDispatcher sharedDispatcher] setPriority:1 forDelegate:self];
    
    [self runAction:[CCSequence actionOne:[CCScaleTo actionWithDuration:0.2 scale:0] two:[CCHide action]]];
}

- (void)onOffEnglish {
    [ZZNavBar playBackEffect];
//    if (OnOffEn.selectedIndex == 1) {
//        return;
//    }
    [OnOffEn setSelectedIndex:1];
    [OnOffCn setSelectedIndex:0];
    [OnOffJp setSelectedIndex:0];
    [[NSUserDefaults standardUserDefaults] setValue:LOCALIZED_ENGLISH forKey:LOCALIZED_NAME];
    
    //本地化
    CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    MainScene *main = [MainScene sharedMainScene];
    [[main titleSprite] setDisplayFrame:[frameCache spriteFrameByName:@"titleEN.png"]];
    [[main titleSprite] setPosition:ccp([main titleSprite].contentSize.width / 2, screenSize.height - [main titleSprite].contentSize.height / 2)];
    [[main rateCloudSprite] setDisplayFrame:[frameCache spriteFrameByName:@"cloud-3EN.png"]];
    [[main aboutPageSprite] setDisplayFrame:[frameCache spriteFrameByName:@"aboutBGEN.png"]];
    [languageSprite setDisplayFrame:[frameCache spriteFrameByName:@"languageEN.png"]];
    
    
}

- (void)onOffChinese {
    [ZZNavBar playBackEffect];
//    if (OnOffCn.selectedIndex == 1) {
//        return;
//    }
    [OnOffEn setSelectedIndex:0];
    [OnOffCn setSelectedIndex:1];
    [OnOffJp setSelectedIndex:0];
    [[NSUserDefaults standardUserDefaults] setValue:LOCALIZED_CHINESE forKey:LOCALIZED_NAME];
    
    //本地化
    CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    MainScene *main = [MainScene sharedMainScene];
    [[main titleSprite] setDisplayFrame:[frameCache spriteFrameByName:@"titleCN.png"]];
    [[main titleSprite] setPosition:ccp([main titleSprite].contentSize.width / 2, screenSize.height - [main titleSprite].contentSize.height / 2)];
    [[main rateCloudSprite] setDisplayFrame:[frameCache spriteFrameByName:@"cloud-3CN.png"]];
    [[main aboutPageSprite] setDisplayFrame:[frameCache spriteFrameByName:@"aboutBG.png"]];
    [languageSprite setDisplayFrame:[frameCache spriteFrameByName:@"languageCN.png"]];
}

- (void)onOffJapanese {
    [ZZNavBar playBackEffect];
//    if (OnOffJp.selectedIndex == 1) {
//        return;
//    }
    [OnOffEn setSelectedIndex:0];
    [OnOffCn setSelectedIndex:0];
    [OnOffJp setSelectedIndex:1];
    [[NSUserDefaults standardUserDefaults] setValue:LOCALIZED_JAPANESE forKey:LOCALIZED_NAME];
    
    //本地化
    CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    MainScene *main = [MainScene sharedMainScene];
    [[main titleSprite] setDisplayFrame:[frameCache spriteFrameByName:@"titleJP.png"]];
    [[main titleSprite] setPosition:ccp([main titleSprite].contentSize.width / 2, screenSize.height - [main titleSprite].contentSize.height / 2)];
    [[main rateCloudSprite] setDisplayFrame:[frameCache spriteFrameByName:@"cloud-3JP.png"]];
    [[main aboutPageSprite] setDisplayFrame:[frameCache spriteFrameByName:@"aboutBGJP.png"]];
    [languageSprite setDisplayFrame:[frameCache spriteFrameByName:@"languageJP.png"]];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}


@end