//
//  CarSprite.h
//  Brazil
//
//  Created by zhaozilong on 12-12-20.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "TrafficScene.h"
#import "SimpleAudioEngine.h"

typedef enum
{
    CarNoneTag = 10,
    CarBusTag,
    CarBicycleTag,
    CarCarTag,
    Car4Tag,
    Car5Tag,
    
}CarTag;

@interface CarSprite : CCSprite <CCTargetedTouchDelegate> {
    CCSprite *tyreFrontSprite;
    CCSprite *tyreBackSprite;
    CCSprite *tyreMidSprite;
    
    CGSize screenSize;
    
    BOOL isTouchHandled;
    
    CCRepeatForever *frontRepeat;
    CCRepeatForever *backRepeat;
    CCRepeatForever *middleRepeat;
    
    CDSoundSource *soundSource;
}

+ (CarSprite *)carWithParentNode:(CCNode *)parentNode pos:(CGPoint)point zorder:(int)zorder carTag:(int)tag;

@end
