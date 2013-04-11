//
//  LoadingScene.h
//  Brazil
//
//  Created by zhaozilong on 13-1-7.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

typedef enum {
    TargetSceneINVALID = 0,
    TargetSceneFruit,
    TargetSceneRubbish,
    TargetSceneEgg,
    TargetSceneVegetable,
    TargetSceneZoo,
    TargetSceneNote,
    TargetSceneCircus,
    TargetSceneTraffic,
    TargetSceneEmotion,
    TargetSceneRedPacket,
    TargetSceneSeaside,
    TargetSceneFirecracker,
    TargetSceneMAX,
} TargetScenes;

@interface LoadingScene : CCScene {
    TargetScenes targetScene_;
    
    CCSprite *shadowSprite;
    CCSprite *springSprite;
    CCSprite *ballSprite;
    CCSprite *loadingSprite;
    
}

+ (id)sceneWithTargetScene:(TargetScenes)targetScene;



@end
