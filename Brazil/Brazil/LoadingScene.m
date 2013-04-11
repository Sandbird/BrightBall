//
//  LoadingScene.m
//  Brazil
//
//  Created by zhaozilong on 13-1-7.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "LoadingScene.h"

#import "EatFuritsScene.h"
#import "RubbishScene.h"
#import "EggsScene.h"
#import "VegetablesScene.h"
#import "ZooScene.h"
#import "NoteScene.h"
#import "CircusScene.h"
#import "TrafficScene.h"
#import "EmotionScene.h"
#import "RedPacketScene.h"
#import "SeasideScene.h"
#import "FireworkScene.h"


@implementation LoadingScene

+ (id)sceneWithTargetScene:(TargetScenes)targetScene {
    return [[[self alloc] initWithTargetScene:targetScene] autorelease];
}

- (id)initWithTargetScene:(TargetScenes)targetScene {
    if (self = [super init]) {
        targetScene_ = targetScene;
        
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        CCLayerColor *color = [CCLayerColor layerWithColor:ccc4(178, 226, 233, 255)];
        [self addChild:color];
        
        
        NSString *name = nil;
        CGFloat scale, y, font;
        if ([ZZNavBar isiPad]) {
            if ([ZZNavBar isRetina]) {
                name = @"Default-Portrait@2x.png";
                scale = 1;
            } else {
                name = @"Default-Portrait.png";
                scale = 0.5;
            }
            
            y = -240;
            font = 60;
        } else {
            if ([ZZNavBar isiPhone5]) {
                name = @"Default-568h@2x.png";
                scale = 0.4;
                y = -140;
            } else if ([ZZNavBar isRetina]) {
                name = @"Default@2x.png";
                scale = 0.4;
                y = -100;
            } else {
                name = @"Default.png";
                scale = 0.2;
                y = -100;
            }
            font = 30;
        }
        
        CCSprite *bg = [CCSprite spriteWithFile:name];
        [self addChild:bg];
        bg.position = ccp(screenSize.width / 2, screenSize.height / 2);
        
        CCLabelTTF *loadingLabel = nil;
        CGPoint point = ccp(screenSize.width / 2, screenSize.height / 2 + y);
        
        switch ([ZZNavBar getNumberEnCnJp]) {
            case 2:
                loadingSprite = [CCSprite spriteWithFile:@"loading.png"];
                loadingSprite.position = point;
                [self addChild:loadingSprite];
                loadingSprite.scale = scale;
                break;
                
            default:
                loadingLabel = [CCLabelTTF labelWithString:@"Loading..." fontName:@"MarkerFelt-Thin" fontSize:font];
                loadingLabel.position = point;
                [loadingLabel setColor:ccc3(17, 71, 100)];
                [self addChild:loadingLabel];
                break;
        }
        
        
        
//        CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
//        [frameCache addSpriteFramesWithFile:@"loading.plist"];
        
        //加载精灵
//        ballSprite = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"loadingBall.png"]];
//        springSprite = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"loadingSpring.png"]];
//        shadowSprite = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"loadingShadow.png"]];
//        loadingSprite = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"loading.png"]];
        
//        ballSprite.position = ccp(screenSize.width / 2 + 65, screenSize.height / 2 + 100);
//        springSprite.position = ccp(screenSize.width / 2, screenSize.height / 2 - 60);
//        shadowSprite.position = ccp(screenSize.width / 2, screenSize.height / 2 - 160);
//        loadingSprite.position = ccp(screenSize.width / 2, screenSize.height / 2 - 240);
        
//        [self addChild:shadowSprite];
//        [self addChild:springSprite];
//        [self addChild:ballSprite];
//        [self addChild:loadingSprite];
        
        
//        CCRepeatForever *springAnimate = [self getSpringAnimate];
//        CCRepeatForever *shadowAnimate = [self getShadowAnimate];
//        CCRepeatForever *ballAnimate = [self getBallAnimate];
//        [ballSprite runAction:ballAnimate];
//        [springSprite runAction:springAnimate];
//        [shadowSprite runAction:shadowAnimate];
        
        [self scheduleUpdate];
    }
    
    return self;
}


- (CCRepeatForever *)getBallAnimate {
    CCMoveBy *down1 = [CCMoveBy actionWithDuration:0.6 position:ccp(0, -85)];
    CCMoveBy *up1 = [CCMoveBy actionWithDuration:0.6 position:ccp(0, 85)];
    CCSequence *downUp = [CCSequence actionOne:down1 two:up1];
    
    CCRepeatForever *repeatFor = [CCRepeatForever actionWithAction:downUp];
    
    return repeatFor;
//    CCMoveBy *down2 = [CCMoveBy actionWithDuration:0.3 position:ccp(0, -20)];
//    CCMoveBy *up2 = [CCMoveBy actionWithDuration:0.3 position:ccp(0, 20)];
}

- (CCRepeatForever *)getSpringAnimate {
    CCMoveBy *down1 = [CCMoveBy actionWithDuration:0.4 position:ccp(0, -60)];
    CCMoveBy *up1 = [CCMoveBy actionWithDuration:0.4 position:ccp(0, 60)];
    CCMoveBy *down2 = [CCMoveBy actionWithDuration:0.2 position:ccp(0, -20)];
    CCMoveBy *up2 = [CCMoveBy actionWithDuration:0.2 position:ccp(0, 20)];
    CCScaleTo *thick = [CCScaleTo actionWithDuration:0.2 scaleX:0.9 scaleY:1.1];
    CCScaleTo *thin = [CCScaleTo actionWithDuration:0.2 scaleX:1.1 scaleY:0.5];
    
    CCSpawn *downThin = [CCSpawn actionOne:down2 two:thin];
    CCSpawn *upThick = [CCSpawn actionOne:up2 two:thick];
    
    CCSequence *down = [CCSequence actionOne:down1 two:downThin];
    CCSequence *up = [CCSequence actionOne:upThick two:up1];
    
    CCSequence *downUp = [CCSequence actionOne:down two:up];

    CCRepeatForever *repeatFor = [CCRepeatForever  actionWithAction:downUp];
    
    
    return repeatFor;
//    [springSprite runAction:repeatFor];
}

- (CCRepeatForever *)getShadowAnimate {
    CCScaleTo *big = [CCScaleTo actionWithDuration:0.6 scale:1.1];
    CCScaleTo *small = [CCScaleTo actionWithDuration:0.6 scale:0.9];
    CCSequence *bigSmall = [CCSequence actionOne:big two:small];
    CCRepeatForever *repeatFor = [CCRepeatForever actionWithAction:bigSmall];
    
    return repeatFor;
}
- (void)update:(ccTime)delta {
    
//    return;
    [self unscheduleAllSelectors];
    
    switch (targetScene_) {
        case TargetSceneFruit:
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[EatFuritsScene scene] withColor:ccWHITE]];
            break;
            
        case TargetSceneRubbish:
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[RubbishScene scene] withColor:ccWHITE]];
            break;
            
        case TargetSceneEgg:
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[EggsScene scene] withColor:ccWHITE]];
            break;
            
        case TargetSceneVegetable:
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[VegetablesScene scene] withColor:ccWHITE]];
            break;
            
        case TargetSceneZoo:
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[ZooScene scene] withColor:ccWHITE]];
            break;
            
        case TargetSceneNote:
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[NoteScene scene] withColor:ccWHITE]];
            break;
            
        case TargetSceneCircus:
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[CircusScene scene] withColor:ccWHITE]];
            break;
            
        case TargetSceneTraffic:
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[TrafficScene scene] withColor:ccWHITE]];
            break;
            
        case TargetSceneEmotion:
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[EmotionScene scene] withColor:ccWHITE]];
            break;
            
        case TargetSceneRedPacket:
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[RedPacketScene scene] withColor:ccWHITE]];
            break;
            
        case TargetSceneSeaside:
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[SeasideScene scene] withColor:ccWHITE]];
            break;
            
        case TargetSceneFirecracker:
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[FireworkScene scene] withColor:ccWHITE]];
            break;
            
        default:
            NSAssert2(nil, @"%@:unsupported TargetScene %i", NSStringFromSelector(_cmd), targetScene_);
            break;
    }
}


@end
