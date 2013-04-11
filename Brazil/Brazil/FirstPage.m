//
//  FirstPage.m
//  Brazil
//
//  Created by zhaozilong on 12-12-23.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "FirstPage.h"

//#import "EatFuritsScene.h"
//#import "RubbishScene.h"
//#import "EggsScene.h"
//#import "VegetablesScene.h"
//#import "ZooScene.h"
//#import "NoteScene.h"
//#import "CircusScene.h"
//#import "TrafficScene.h"
#import "ZZNavBar.h"
#import "LoadingScene.h"

#import "FireworkScene.h"
#import "RedPacketScene.h"
#import "SeasideScene.h"


@implementation FirstPage

- (id)init {
    if (self = [super init]) {
        
//        self.isTouchEnabled = YES;
        
        CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
//        backSprite = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"back.png"]];
        fruitNS = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"fruit.png"]];
        if ([ZZNavBar getNumberEnCnJp] == 2) {
            rubbishNS = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"rubbish.png"]];
        } else {
            rubbishNS = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"emotion.png"]];
        }
        eggNS = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"egg.png"]];
        vegetableNS = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"vegetable.png"]];
        zooNS = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"zoo.png"]];
        noteNS = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"note.png"]];
        circusNS = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"circus.png"]];
        trafficNS = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"traffic.png"]];
        
        fruitSS = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"fruit2.png"]];
        if ([ZZNavBar getNumberEnCnJp] == 2) {
            rubbishSS = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"rubbish2.png"]];
        } else {
            rubbishSS = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"emotion2.png"]];
        }
        eggSS = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"egg2.png"]];
        vegetableSS = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"vegetable2.png"]];
        zooSS = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"zoo2.png"]];
        noteSS = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"note2.png"]];
        circusSS = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"circus2.png"]];
        trafficSS = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"traffic2.png"]];
        
        volcanoSprite = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"volcano-11.png"]];
        
        CGPoint fruitPos, rubbishPos, eggPos, vegetablePos, zooPos, notePos, circusPos, trafficPos;
        CGFloat volcanoPosX;
        if ([ZZNavBar isiPad]) {
            fruitPos = ccp(150, 540);
            rubbishPos = ccp(620, 600);
            eggPos = ccp(550, 870);
            vegetablePos = ccp(550, 450);
            zooPos = ccp(200, 700);
            notePos = ccp(250, 860);
            circusPos = ccp(250, 420);
            trafficPos = ccp(400, 660);
            
            volcanoPosX = screenSize.width / 2;
        } else {
            CGFloat x = 0.41667;
            CGFloat y = 0.46875;
            
            if ([ZZNavBar isiPhone5]) {
                fruitPos = ccp(x * 150, y * 540 + 40);
                rubbishPos = ccp(x * 600 + 10, y * 600 + 40);
                eggPos = ccp(x * 530, y * 830 + 70);
                vegetablePos = ccp(x * 600 - 20, y * 450 + 40);
                zooPos = ccp(x * 200 - 10, y * 700 + 40);
                notePos = ccp(x * 250, y * 860 + 40);
                circusPos = ccp(x * 250, y * 420 + 40);
                trafficPos = ccp(x * 400, y * 660 + 40);
            } else {
                fruitPos = ccp(x * 150, y * 540);
                rubbishPos = ccp(x * 600 + 15, y * 600);
                eggPos = ccp(x * 530 + 10, y * 830 + 10);
                vegetablePos = ccp(x * 600 - 20, y * 450);
                zooPos = ccp(x * 200 - 10, y * 700);
                notePos = ccp(x * 250, y * 860 - 10);
                circusPos = ccp(x * 250, y * 420 - 10);
                trafficPos = ccp(x * 400, y * 660);
            }
            
            
            
            volcanoPosX = screenSize.width / 2;
        }
        
        volcanoSprite.position = ccp(volcanoPosX, volcanoSprite.contentSize.height / 2);
        [self addChild:volcanoSprite z:0];
        
        //加返回按钮和主页按钮
        CCMenuItem *fruitItem = [CCMenuItemImage itemFromNormalSprite:fruitNS selectedSprite:fruitSS disabledSprite:nil target:self selector:@selector(transToEatFuritsScene)];
        CCMenuItem *rubbishItem = [CCMenuItemImage itemFromNormalSprite:rubbishNS selectedSprite:rubbishSS disabledSprite:nil target:self selector:@selector(transToRubbishScene)];
        CCMenuItem *eggItem = [CCMenuItemImage itemFromNormalSprite:eggNS selectedSprite:eggSS disabledSprite:nil target:self selector:@selector(transToEggsScene)];
        CCMenuItem *vegetableItem = [CCMenuItemImage itemFromNormalSprite:vegetableNS selectedSprite:vegetableSS disabledSprite:nil target:self selector:@selector(transToVegetablesScene)];
        CCMenuItem *zooItem = [CCMenuItemImage itemFromNormalSprite:zooNS selectedSprite:zooSS disabledSprite:nil target:self selector:@selector(transToZooScene)];
        CCMenuItem *noteItem = [CCMenuItemImage itemFromNormalSprite:noteNS selectedSprite:noteSS disabledSprite:nil target:self selector:@selector(transToNoteScene)];
        CCMenuItem *circusItem = [CCMenuItemImage itemFromNormalSprite:circusNS selectedSprite:circusSS disabledSprite:nil target:self selector:@selector(transToCircusScene)];
        CCMenuItem *trafficItem = [CCMenuItemImage itemFromNormalSprite:trafficNS selectedSprite:trafficSS disabledSprite:nil target:self selector:@selector(transToTrafficScene)];
        
        
        fruitItem.position = fruitPos;
        rubbishItem.position = rubbishPos;
        eggItem.position = eggPos;
        vegetableItem.position = vegetablePos;
        zooItem.position = zooPos;
        noteItem.position = notePos;
        circusItem.position = circusPos;
        trafficItem.position = trafficPos;
        
        CCMenu *mainMenu = [CCMenu menuWithItems:trafficItem, fruitItem, rubbishItem, eggItem, vegetableItem, zooItem, noteItem, circusItem, nil];
        mainMenu.position = ccp(0, 0);
        
        [self addChild:mainMenu];
        
#if 1
        
        float angle = 2;

        CCMoveBy *move1 = [CCRotateTo actionWithDuration:0.7 angle:angle];
        CCMoveBy *move2 = [CCRotateTo actionWithDuration:0.7 angle:-1 * angle];
        CCSequence *move = [CCSequence actionOne:move1 two:move2];
        [fruitItem runAction:[CCRepeatForever actionWithAction:move]];
        
        move1 = [CCRotateTo actionWithDuration:1 angle:angle];
        move2 = [CCRotateTo actionWithDuration:1 angle:-angle];
        move = [CCSequence actionOne:move1 two:move2];
        [rubbishItem runAction:[CCRepeatForever actionWithAction:move]];
        
        move1 = [CCRotateTo actionWithDuration:0.9 angle:angle];
        move2 = [CCRotateTo actionWithDuration:0.9 angle:-angle];
        move = [CCSequence actionOne:move1 two:move2];
        [eggItem runAction:[CCRepeatForever actionWithAction:move]];
        
        move1 = [CCRotateTo actionWithDuration:0.8 angle:angle];
        move2 = [CCRotateTo actionWithDuration:0.8 angle:-angle];
        move = [CCSequence actionOne:move1 two:move2];
        [vegetableItem runAction:[CCRepeatForever actionWithAction:move]];
        
        move1 = [CCRotateTo actionWithDuration:0.9 angle:angle];
        move2 = [CCRotateTo actionWithDuration:0.9 angle:-angle];
        move = [CCSequence actionOne:move1 two:move2];
        [zooItem runAction:[CCRepeatForever actionWithAction:move]];
        
        move1 = [CCRotateTo actionWithDuration:0.6 angle:angle];
        move2 = [CCRotateTo actionWithDuration:0.6 angle:-angle];
        move = [CCSequence actionOne:move1 two:move2];
        [noteItem runAction:[CCRepeatForever actionWithAction:move]];
        
        move1 = [CCRotateTo actionWithDuration:0.7 angle:angle];
        move2 = [CCRotateTo actionWithDuration:0.7 angle:-angle];
        move = [CCSequence actionOne:move1 two:move2];
        [circusItem runAction:[CCRepeatForever actionWithAction:move]];
        
        move1 = [CCRotateTo actionWithDuration:0.5 angle:angle];
        move2 = [CCRotateTo actionWithDuration:0.5 angle:-angle];
        move = [CCSequence actionOne:move1 two:move2];
        [trafficItem runAction:[CCRepeatForever actionWithAction:move]];
        
#endif
        
    }
    
    return self;
}

+ (void)backgroundMusicPlay {
    
    [ZZNavBar playGoEffect];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL isPauseMusic = [userDefaults boolForKey:IS_PAUSE_MUSIC];
    if (isPauseMusic == NO) {
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    }
}

- (void)transToEatFuritsScene {
    //暂停背景音乐
    [FirstPage backgroundMusicPlay];
    
    [[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:TargetSceneFruit]];
}

- (void)transToRubbishScene {
    
    
    //暂停背景音乐
    [FirstPage backgroundMusicPlay];
    
    switch ([ZZNavBar getNumberEnCnJp]) {
        case 2:
            [[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:TargetSceneRubbish]];
            break;
            
        default:
            [[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:TargetSceneEmotion]];
            break;
    }
    
}

- (void)transToEggsScene {
    
    //暂停背景音乐
    [FirstPage backgroundMusicPlay];
    
    [[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:TargetSceneEgg]];
    
}

- (void)transToVegetablesScene {
    
    
    //暂停背景音乐
    [FirstPage backgroundMusicPlay];
    
    [[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:TargetSceneVegetable]];
}

- (void)transToZooScene {
    
    //暂停背景音乐
    [FirstPage backgroundMusicPlay];
    
    [[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:TargetSceneZoo]];
    
}

- (void)transToNoteScene {
    
    //暂停背景音乐
    [FirstPage backgroundMusicPlay];
    
    [[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:TargetSceneNote]];
}

- (void)transToCircusScene {
    
    //暂停背景音乐
    [FirstPage backgroundMusicPlay];
    
    [[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:TargetSceneCircus]];
}

- (void)transToTrafficScene {

    //暂停背景音乐
    [FirstPage backgroundMusicPlay];
    
    [[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:TargetSceneTraffic]];

}

@end
