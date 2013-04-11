//
//  Track.h
//  Brazil
//
//  Created by zhaozilong on 12-11-29.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Rubbish.h"

@interface Track : CCNode {
    CCSpriteBatchNode* spriteBatch;
    
	int numStripes;
    
	CCArray* speedFactors;
	float scrollSpeed;
    
	CGSize screenSize;
    
    Rubbish *rubbishSprite;
    
    Rubbish *diskSprite;
    Rubbish *plasticSprite;
    Rubbish *cokeSprite;
    Rubbish *bottleSprite;
    Rubbish *batterySprite;
    Rubbish *newspaperSprite;
    
}

@end
