//
//  EmotionScene.h
//  Brazil
//
//  Created by zhaozilong on 13-1-6.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ZZNavBar.h"
#import "SimpleAudioEngine.h"
#import "Face.h"


@interface EmotionScene : CCLayer {
    
@private
    NSMutableArray *nums;
    NSMutableArray *faces;
}

@property (nonatomic, retain) ZZNavBar *navBar;

+(CGPoint) locationFromTouch:(UITouch*)touch;

+ (id)scene;

+(CGPoint) locationFromTouch:(UITouch*)touch;

+ (EmotionScene *)sharedEmotionScene;

- (void)setFaceZOrderByFaceTag:(int)tag;

@end
