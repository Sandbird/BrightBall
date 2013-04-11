//
//  Animal.h
//  Brazil
//
//  Created by zhaozilong on 12-12-11.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SimpleAudioEngine.h"


@protocol AnimalDelegate <NSObject>

- (void)animalIsMatch;

@end

@interface Animal : NSObject <CCTargetedTouchDelegate> {
    CGPoint defaultPosition;
	CGPoint lastTouchLocation;
    
    CGFloat halfScreenPosX;
    CGPoint postion;
    CGPoint lastPostion;
    CGPoint nextPostion;
    
    BOOL isTouchHandled;
    
    CCSprite *animalSprite_0;
    CCSprite *animalSprite_1;
    CCSprite *animalSprite_2;
    CCSprite *animalSprite_3;
    CCSprite *animalSprite_4;
    
    CCSprite *currentSprite;
    CCSprite *lastSprite;
    CCSprite *nextSprite;
    
    CCSpriteFrameCache *frameCache;
    
    CCSpriteFrame *frame;
    
    CCNode *node;
    
    BOOL isAnimLocked;
    
    int interval;
    
    CGSize screenSize;
}

@property (nonatomic, retain) id<AnimalDelegate> delegate;

+ (id)animalWithParentNode:(CCNode *)parentNode pos:(CGPoint)point prefix:(int)animalSuffix;

- (int)getCurrentAnimalTag;
- (void)setAnimalRightAnim;

@end
