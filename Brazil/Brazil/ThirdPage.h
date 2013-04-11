//
//  ThirdPage.h
//  Brazil
//
//  Created by zhaozilong on 13-1-29.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ZZNavBar.h"

@interface ThirdPage : CCLayer {
    CCSprite *redPacketSprite;
    CCSprite *seasideSprite;
    CCSprite *firecrackerSprite;
    
    CCSprite *redPacket2Sprite;
    CCSprite *seaside2Sprite;
    CCSprite *firecracker2Sprite;
    
    CGPoint lastTouchLocation;
}

@end
