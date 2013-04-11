//
//  EatFuritsScene.h
//  Brazil
//
//  Created by zhaozilong on 12-10-30.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Boy.h"
#import "Furit.h"
#import "ZZNavBar.h"
//#import "SimpleAudioEngine.h"

typedef enum
{
    EatFuritsSceneNodeTagBoy = 1,
    EatFuritsSceneNodeTagApple,
} EatFuritsSceneNodeTags;

@class Boy, Furit;

@interface EatFuritsScene : CCLayer /*<CCTargetedTouchDelegate>*/{
    
    Furit *apple;
    Furit *grape;
    Furit *banana;
    Furit *cherry;
    Furit *orange;
    Furit *watermelon;
    Furit *durian;
    
//    SimpleAudioEngine *audioEngine;
}

//@property BOOL isAnimLocked;
@property (nonatomic, retain) Furit *fruit;
@property (nonatomic, retain) Boy *boy;
@property (nonatomic, retain) ZZNavBar *navBar;

+ (CCScene *)scene;
+(CGPoint) locationFromTouch:(UITouch*)touch;
+ (EatFuritsScene *)sharedEatFurits;
- (void)setFruitVisible:(BOOL)isVisible;

@end
