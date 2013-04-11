//
//  ParallaxBackground.h
//  ScrollingWithJoy
//
//  Created by Steffen Itterheim on 11.08.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ZZNavBar.h"
#import "TrafficScene.h"
#import "CarSprite.h"

@interface ParallaxBackground : CCNode <CCTargetedTouchDelegate>
{
    
	CCSpriteBatchNode* spriteBatch;

	int numStripes;

	CCArray* speedFactors;
	

	CGSize screenSize;
    
    CCArray *layerArray;
    
    BOOL isTouchHandled;
}

@property float scrollSpeed;

- (void)brakeOrMove:(BOOL)isMove;

@end
