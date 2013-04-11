//
//  Egg.h
//  Brazil
//
//  Created by zhaozilong on 12-12-4.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "EggsScene.h"
#import "SimpleAudioEngine.h"

@interface Egg : NSObject <CCTargetedTouchDelegate> {
    int tapCount;
    
    CGPoint defaultPosition;
	CGPoint lastTouchLocation;
    
    BOOL isTouchHandled;
    
    CCSprite *eggSprite;
    CCSprite *shellSprite;
    CCSprite *animalSprite;
    
    CCSpriteFrameCache *frameCache;
    
    CCSpriteFrame *frame;
    
    NSString *suffix;
    
    BOOL isAnimLocked;
    
    SimpleAudioEngine *audioEngine;
}

+ (id)eggWithParentNode:(CCNode *)parentNode eggPos:(CGPoint)eggPos animalPos:(CGPoint)animalPos shellPos:(CGPoint)shellPos prefix:(NSString *)eggSuffix;

@end
