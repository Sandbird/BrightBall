//
//  Snake.h
//  Brazil
//
//  Created by zhaozilong on 13-1-18.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Snake : CCSprite <CCTargetedTouchDelegate> {
    
    CCSprite *eyeSprite;
    
    CCSprite *blessSprite;
    
    CCSpriteFrameCache *frameCache;
    
    CGSize screenSize;
    
    CCSprite *bombSprite;
    
}

+ (Snake *)snakeWithParentNode:(CCNode *)parentNode;

- (void)playFirecrackerAnimation;

@end
