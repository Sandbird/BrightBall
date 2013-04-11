//
//  ThirdPage.m
//  Brazil
//
//  Created by zhaozilong on 13-1-29.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "ThirdPage.h"
#import "LoadingScene.h"


@implementation ThirdPage

- (id)init {
    if (self = [super init]) {
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        //背景火山
//        CCSprite *bgSprite = [CCSprite spriteWithSpriteFrameName:@"volcano_year.png"];
        CCSprite *bgSprite = [CCSprite spriteWithSpriteFrameName:@"volcano_year.png"];
        [self addChild:bgSprite];
        bgSprite.position = ccp(screenSize.width / 2, screenSize.height / 2);
        
        //精灵
        redPacketSprite = [CCSprite spriteWithSpriteFrameName:@"redPacketIcon.png"];
        seasideSprite = [CCSprite spriteWithSpriteFrameName:@"seasideIcon.png"];
        firecrackerSprite = [CCSprite spriteWithSpriteFrameName:@"firecrackerIcon.png"];
        
        redPacket2Sprite = [CCSprite spriteWithSpriteFrameName:@"redPacketIcon2.png"];
        seaside2Sprite = [CCSprite spriteWithSpriteFrameName:@"seasideIcon2.png"];
        firecracker2Sprite = [CCSprite spriteWithSpriteFrameName:@"firecrackerIcon2.png"];
        
        CGPoint redPacketPos, seasidePos, firecrackerPos;
        if ([ZZNavBar isiPad]) {
            
            redPacketPos = ccp(screenSize.width / 2, 750);
            seasidePos = ccp(screenSize.width / 2 - 120, 550);
            firecrackerPos = ccp(screenSize.width / 2 + 100, 450);

            
        } else {
            
            if ([ZZNavBar isiPhone5]) {
                redPacketPos = ccp(screenSize.width / 2, 380);
                seasidePos = ccp(screenSize.width / 2 - 45, 220);
                firecrackerPos = ccp(screenSize.width / 2 + 50, 280);

            } else {
                redPacketPos = ccp(screenSize.width / 2, 330);
                seasidePos = ccp(screenSize.width / 2 - 45, 200);
                firecrackerPos = ccp(screenSize.width / 2 + 50, 240);

            }
            
        }
        
        //加返回按钮和主页按钮
        CCMenuItem *redPacketItem = [CCMenuItemImage itemFromNormalSprite:redPacketSprite selectedSprite:redPacket2Sprite disabledSprite:nil target:self selector:@selector(transToRedPacketScene)];
        CCMenuItem *seasideItem = [CCMenuItemImage itemFromNormalSprite:seasideSprite selectedSprite:seaside2Sprite disabledSprite:nil target:self selector:@selector(transToSeasideScene)];
        CCMenuItem *firecrackerItem = [CCMenuItemImage itemFromNormalSprite:firecrackerSprite selectedSprite:firecracker2Sprite disabledSprite:nil target:self selector:@selector(transToFirecrackerScene)];
        
        redPacketItem.position = redPacketPos;
        seasideItem.position = seasidePos;
        firecrackerItem.position = firecrackerPos;
        
        CCMenu *mainMenu = [CCMenu menuWithItems:redPacketItem, seasideItem, firecrackerItem, nil];
        mainMenu.position = ccp(0, 0);
        
        [self addChild:mainMenu];
        
        float angle = 2;
        CCMoveBy *move1 = [CCRotateTo actionWithDuration:0.7 angle:angle];
        CCMoveBy *move2 = [CCRotateTo actionWithDuration:0.7 angle:-1 * angle];
        CCSequence *move = [CCSequence actionOne:move1 two:move2];
        [redPacketItem runAction:[CCRepeatForever actionWithAction:move]];
        
        move1 = [CCRotateTo actionWithDuration:1 angle:angle];
        move2 = [CCRotateTo actionWithDuration:1 angle:-angle];
        move = [CCSequence actionOne:move1 two:move2];
        [seasideItem runAction:[CCRepeatForever actionWithAction:move]];
        
        move1 = [CCRotateTo actionWithDuration:0.9 angle:angle];
        move2 = [CCRotateTo actionWithDuration:0.9 angle:-angle];
        move = [CCSequence actionOne:move1 two:move2];
        [firecrackerItem runAction:[CCRepeatForever actionWithAction:move]];
        
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

- (void)transToRedPacketScene {
    
    //暂停背景音乐
    [ThirdPage backgroundMusicPlay];
    
    [[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:TargetSceneRedPacket]];
}

- (void)transToSeasideScene {
    
    //暂停背景音乐
    [ThirdPage backgroundMusicPlay];
    
    
    [[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:TargetSceneSeaside]];
    
}

- (void)transToFirecrackerScene {
    
    //暂停背景音乐
    [ThirdPage backgroundMusicPlay];
    
    
    [[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:TargetSceneFirecracker]];
    
}



@end
