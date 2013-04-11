//
//  MainScene.h
//  Brazil
//
//  Created by zhaozilong on 12-10-29.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ZZNavBar.h"
#import "Settings.h"

#define ABOUT_ON_TAG 11111
#define ABOUT_OFF_TAG 22222

#define SETTINGS_ON_TAG 33333
#define SETTINGS_OFF_TAG 44444

#define ALERT_RATE 1234
#define ALERT_IYUBA 4321

@interface MainScene : CCLayer {
    
    
//    CCSprite *shareSprite;
    CCSprite *settingsSprite;
    CCSprite *startSprite;
    CCSprite *springSprite;
    CCSprite *ballSprite;
    CCSprite *volcanoSprite;
    CCSprite *aboutSprite;
    
    Settings *settingsPage;
    
    CGPoint currentTouchPoint;
    
    CCArray *cloudArray;
    CCArray *speedArray;
    
    CGSize screenSize; 
}

@property (nonatomic, retain) CCSprite *titleSprite;
@property (nonatomic, retain) CCSprite *aboutPageSprite;
@property (nonatomic, retain) CCSprite *rateCloudSprite;;

+ (CCScene *)scene;

+ (MainScene *)sharedMainScene;

@end
