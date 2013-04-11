//
//  EggsScene.m
//  Brazil
//
//  Created by zhaozilong on 12-12-4.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "EggsScene.h"

@implementation EggsScene

@synthesize navBar = _navBar;

static EggsScene *instanceOfEggsScene;

- (void)dealloc {
    
    CCLOG(@"eggScene dealloc");
    
    [EggsScene unloadEffects];
    instanceOfEggsScene = nil;
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"eggs.plist"];
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    [super dealloc];
}

+ (EggsScene *)sharedEggsScene {
    NSAssert(instanceOfEggsScene != nil, @"EggsScene instance not yet initialized!");
    return instanceOfEggsScene;
}

+ (id)scene {
    CCScene *scene = [CCScene node];
    EggsScene *layer = [EggsScene node];
    [scene addChild:layer];
    
    return scene;
}

- (id)init {
    if (self = [super init]) {
        
        instanceOfEggsScene = self;
        
        frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        [frameCache addSpriteFramesWithFile:@"eggs.plist"];
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        CGPoint bgPoint = CGPointMake(screenSize.width / 2, screenSize.height / 2);
        CCSprite *background, *eggABack, *eggBBack, *eggCBack, *eggDBack, *eggEBack, *eggAFront, *eggBFront, *eggCFront, *eggDFront, *eggEFront;
        
        if ([ZZNavBar isiPhone5]) {
            bgPoint = CGPointMake(screenSize.width / 2, screenSize.height / 2 - 44);
            background = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"eggsBG-568.png"]];
            
        } else {
            bgPoint = CGPointMake(screenSize.width / 2, screenSize.height / 2);
            background = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"eggsBG.png"]];
        }
        
        eggABack = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"eggABack.png"]];
        eggBBack = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"eggBBack.png"]];
        eggCBack = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"eggCBack.png"]];
        eggDBack = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"eggDBack.png"]];
        eggEBack = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"eggEBack.png"]];
        
        eggAFront = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"eggAFront.png"]];
        eggBFront = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"eggBFront.png"]];
        eggCFront = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"eggCFront.png"]];
        eggDFront = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"eggDFront.png"]];
        eggEFront = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"eggEFront.png"]];
        
        //背景和鸟巢后边
		background.position = ccp(screenSize.width / 2, screenSize.height / 2);;
        eggABack.position = bgPoint;
        eggBBack.position = bgPoint;
        eggCBack.position = bgPoint;
        eggDBack.position = bgPoint;
        eggEBack.position = bgPoint;
        
        //鸟巢前边
        eggAFront.position = bgPoint;
        eggBFront.position = bgPoint;
        eggCFront.position = bgPoint;
        eggDFront.position = bgPoint;
        eggEFront.position = bgPoint;
        
        CGPoint eggAPos, eggBPos, eggCPos, eggDPos, eggEPos;
        CGPoint animalAPos, animalBPos, animalCPos, animalDPos, animalEPos;
        CGPoint shellAPos, shellBPos, shellCPos, shellDPos, shellEPos;
        if ([ZZNavBar isiPad]) {
            eggAPos = ccp(300, 310);
            animalAPos = ccp(310, 390);
            shellAPos = ccp(300, 330);
            
            eggBPos = ccp(520, 460);
            animalBPos = ccp(540, 520);
            shellBPos = ccp(518, 479);
            
            eggCPos = ccp(280, 580);
            animalCPos = ccp(267, 640);
            shellCPos = ccp(284, 586);
            
            eggDPos = ccp(455, 650);
            animalDPos = ccp(450, 700);
            shellDPos = ccp(455, 655);
            
            eggEPos = ccp(545, 770);
            animalEPos = ccp(547, 800);
            shellEPos = ccp(545, 780);
        } else {
            eggAPos = ccp(120, 140);
            animalAPos = ccp(120, 185);
            shellAPos = ccp(120, 150);
            
            eggBPos = ccp(230, 215);
            animalBPos = ccp(238, 245);
            shellBPos = ccp(230, 225);
            
            eggCPos = ccp(110, 270);
            animalCPos = ccp(104, 295);
            shellCPos = ccp(113, 273);
            
            eggDPos = ccp(195, 305);
            animalDPos = ccp(192, 332);
            shellDPos = ccp(195, 307);
            
            eggEPos = ccp(238, 360);
            animalEPos = ccp(238, 375);
            shellEPos = ccp(238, 366);
        }
        
        //排版
		[self addChild:background];
        
        [self addChild:eggEBack];
        [Egg eggWithParentNode:self eggPos:eggEPos animalPos:animalEPos shellPos:shellEPos prefix:@"E"];
        [self addChild:eggEFront];
        
        [self addChild:eggDBack];
        [Egg eggWithParentNode:self eggPos:eggDPos animalPos:animalDPos shellPos:shellDPos prefix:@"D"];
        [self addChild:eggDFront];
        
        [self addChild:eggCBack];
        [Egg eggWithParentNode:self eggPos:eggCPos animalPos:animalCPos shellPos:shellCPos prefix:@"C"];
        [self addChild:eggCFront];
        
        [self addChild:eggBBack];
        [Egg eggWithParentNode:self eggPos:eggBPos animalPos:animalBPos shellPos:shellBPos prefix:@"B"];
        [self addChild:eggBFront];
        
        [self addChild:eggABack];
        [Egg eggWithParentNode:self eggPos:eggAPos animalPos:animalAPos shellPos:shellAPos prefix:@"A"];
        [self addChild:eggAFront];
        
        //加NavBar
        _navBar = [ZZNavBar node];
        [self addChild:_navBar];
        [_navBar setTitleLabelWithString:NSLocalizedStringFromTable(@"egg", [ZZNavBar getStringEnCnJp], nil)];
        
        [EggsScene loadEffects];
        
    }
    
    return self;
}

+(CGPoint) locationFromTouch:(UITouch*)touch
{
	CGPoint touchLocation = [touch locationInView: [touch view]];
	return [[CCDirector sharedDirector] convertToGL:touchLocation];
}

- (void)onExitTransitionDidStart {
    
    [[CCTouchDispatcher sharedDispatcher] removeAllDelegates];
}

+ (void)loadEffects {
    
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_CHICKEN_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_DINOSAUR_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_GOOSE_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_PENGUIN_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_DUCK_EN];
    
    switch ([ZZNavBar getNumberEnCnJp]) {
        case 2:
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_CHICKEN_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_DINOSAUR_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_GOOSE_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_PENGUIN_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_DUCK_CN];

            break;
            
        case 3:
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_CHICKEN_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_DINOSAUR_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_GOOSE_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_PENGUIN_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_DUCK_JP];

            break;
            
        default:
            break;
    }
    
    [[SimpleAudioEngine sharedEngine] preloadEffect:EFFECT_CHICKEN_0];
    [[SimpleAudioEngine sharedEngine] preloadEffect:EFFECT_DUCK_0];
    [[SimpleAudioEngine sharedEngine] preloadEffect:EFFECT_DINOSAUR_0];
    [[SimpleAudioEngine sharedEngine] preloadEffect:EFFECT_PENGUIN_0];
    [[SimpleAudioEngine sharedEngine] preloadEffect:EFFECT_EGG_0];
    [[SimpleAudioEngine sharedEngine] preloadEffect:EFFECT_EGG_1];
 
}

+ (void)unloadEffects {
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_CHICKEN_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_DINOSAUR_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_GOOSE_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_PENGUIN_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_DUCK_EN];
    
    switch ([ZZNavBar getNumberEnCnJp]) {
        case 2:
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_CHICKEN_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_DINOSAUR_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_GOOSE_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_PENGUIN_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_DUCK_CN];
            
            break;
            
        case 3:
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_CHICKEN_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_DINOSAUR_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_GOOSE_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_PENGUIN_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_DUCK_JP];
            
            break;
            
        default:
            break;
    }
    
    [[SimpleAudioEngine sharedEngine] unloadEffect:EFFECT_CHICKEN_0];
    [[SimpleAudioEngine sharedEngine] unloadEffect:EFFECT_DUCK_0];
    [[SimpleAudioEngine sharedEngine] unloadEffect:EFFECT_DINOSAUR_0];
    [[SimpleAudioEngine sharedEngine] unloadEffect:EFFECT_PENGUIN_0];
    [[SimpleAudioEngine sharedEngine] unloadEffect:EFFECT_EGG_0];
    [[SimpleAudioEngine sharedEngine] unloadEffect:EFFECT_EGG_1];

    
}

@end
