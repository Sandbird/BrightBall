//
//  VegetablesScene.h
//  Brazil
//
//  Created by zhaozilong on 12-12-7.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "NewBoy.h"
#import "Vegetable.h"
#import "ZZNavBar.h"

//typedef enum
//{
//    EatFuritsSceneNodeTagBoy = 1,
//    EatFuritsSceneNodeTagApple,
////    VegetablesSceneNodeTagNewBoy,
//} EatFuritsSceneNodeTags;

@class NewBoy, Vegetable;

@interface VegetablesScene : CCLayer {
    
    Vegetable *carrot;
    Vegetable *corn;
    Vegetable *pumpkin;
    Vegetable *mushroom;
    Vegetable *tomato;
    Vegetable *potato;
    
    //    Furit *fruit;
    
    //    Boy *boy;
    
    //    BOOL isAnimLocked;
}

//@property BOOL isAnimLocked;
@property (nonatomic, retain) Vegetable *fruit;
@property (nonatomic, retain) NewBoy *boy;
@property (nonatomic, retain) ZZNavBar *navBar;

+ (CCScene *)scene;
+(CGPoint) locationFromTouch:(UITouch*)touch;
+ (VegetablesScene *)sharedEatFurits;
- (void)setFruitVisible:(BOOL)isVisible;

@end
