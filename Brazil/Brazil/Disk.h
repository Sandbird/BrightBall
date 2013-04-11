//
//  Disk.h
//  Brazil
//
//  Created by zhaozilong on 12-12-18.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CircusScene.h"

#define CIRCUS_JOKER @"joker"
#define CIRCUS_ELEPHANT @"elephant"

@interface Disk : NSObject <CCTargetedTouchDelegate> {
    
    CGPoint defaultPosition;
	CGPoint lastTouchLocation;
    
    CGFloat halfScreenPosX;
    CGPoint postion;
    CGPoint lastPostion;
    CGPoint nextPostion;
    
    BOOL isTouchHandled;
    
    CCSprite *diskSprite;
    CCSprite *jokerSprite;
    CCSprite *elephantSprite;
    
    CCSpriteFrameCache *frameCache;
    
    CCSpriteFrame *frame;
    
    CCNode *node;
    
//    BOOL isAnimLocked;
    
    int interval;
    
    CGSize screenSize;
    
    CCRepeatForever *rotateForever;
    CCRepeatForever *jokerRotForever;
    CCRepeatForever *elephantRotForever;
    
    CGPoint pointZero;
    
//    CGImageRef inImage;
    
    int loop;

}

+ (id)diskWithParentNode:(CCNode *)parentNode;

- (void)setElephantAnim;
- (void)setJokerAnim;
- (void)sayEnglishByStr:(NSString *)name;

@end
