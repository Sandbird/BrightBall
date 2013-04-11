//
//  Settings.h
//  Brazil
//
//  Created by zhaozilong on 12-12-26.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#define IS_PAUSE_MUSIC @"isPauseBackgroundMusic"

#define BACKGROUND_MUSIC @"Bluegrass.caf"

@interface Settings : CCLayer {
    CCMenuItemToggle *OnOffEn;
    CCMenuItemToggle *OnOffCn;
    CCMenuItemToggle *OnOffJp;
    
    CCSprite *languageSprite;
    
    CGSize screenSize;
}

//+ (CCScene *)scene;

@end
