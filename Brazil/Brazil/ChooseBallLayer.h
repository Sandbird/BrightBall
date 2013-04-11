//
//  ChooseBallLayer.h
//  Brazil
//
//  Created by zhaozilong on 12-10-29.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "FirstPage.h"
#import "SecondPage.h"
#import "ThirdPage.h"

@class FirstPage, SecondPage, ThirdPage;

@interface ChooseBallLayer : CCLayer {
    
    CGPoint defaultPosition;
	CGPoint lastTouchLocation;
    
    FirstPage *firstPage;
    SecondPage *secondPage;
    ThirdPage *thirdPage;
    
    CCLayer *currLayer;
    CCLayer *lastLayer;
    CCLayer *nextLayer;
    
    CGPoint currPoint;
    CGPoint lastPoint;
    CGPoint nextPoint;
    
    CCSprite *backSprite;
    
    CGSize screenSize;
    
    int page;
    
    CGPoint currentTouchPoint;
    
    CCArray *cloudArray;
    CCArray *speedArray;
    CCSprite *rateCloudSprite;
    
    CCSprite *pageControl;
    CCAnimation *animation;
}

+ (CCScene *)scene;

+ (CGPoint) locationFromTouch:(UITouch*)touch;

+ (ChooseBallLayer *)sharedChooseBall;

@end
