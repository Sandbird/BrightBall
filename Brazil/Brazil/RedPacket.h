//
//  RedPacket.h
//  Brazil
//
//  Created by zhaozilong on 13-1-22.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ZZNavBar.h"
#import "RedPacketScene.h"

typedef enum
{
    RedPacketTagAlien,
    RedPacketTagCamera,
    RedPacketTagCandy,
    RedPacketTagDoll,
    RedPacketTagGlass,
    RedPacketTagIngot,
    RedPacketTagRat,
    RedPacketTagPencil,
    
} RedPacketTags;

@interface RedPacket : CCSprite <CCTargetedTouchDelegate> {
    CCSprite *giftSprite;
    
    CCSprite *coverSprite;
    
    CGSize screenSize;
    
    CCSpriteFrameCache *frameCache;
    
    int count;
    
    int giftTag;
}

+ (id)redPacketWithParentNode:(CCNode *)parentNode pos:(CGPoint)point tag:(int)tag;

@end
