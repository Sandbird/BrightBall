//
//  ZooScene.m
//  Brazil
//
//  Created by zhaozilong on 12-12-11.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "ZooScene.h"


@implementation ZooScene

@synthesize navBar = _navBar;

static ZooScene *instanceOfZooScene;

- (void)dealloc {
    
    
    CCLOG(@"zoo is dealloc");
    [ZooScene unloadEffects];
    instanceOfZooScene = nil;
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"zoo.plist"];
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    [super dealloc];
}

+ (ZooScene *)sharedZooScene {
    
    NSAssert(instanceOfZooScene != nil, @"instanceOfZooScene is not intialize");
    return instanceOfZooScene;
}

+ (id)scene {
    CCScene *scene = [CCScene node];
    ZooScene *layer = [ZooScene node];
    
    [scene addChild:layer];
    
    return scene;
}

- (id)init {
    
    if (self = [super init]) {
        instanceOfZooScene = self;
        
        //load effects
        audioEngine = [SimpleAudioEngine sharedEngine];
        
        
        CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        [frameCache addSpriteFramesWithFile:@"zoo.plist"];
        
        //screen size
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        //背景
        CCSpriteFrame *frame;// = [frameCache spriteFrameByName:@"BGEatFruits.png"];
        CCSprite* background;
        if ([ZZNavBar isiPad]) {
            background = [CCSprite spriteWithFile:@"zooBG.png"];
        } else {
            frame = [frameCache spriteFrameByName:@"zooBG.png"];
            background = [CCSprite spriteWithSpriteFrame:frame];
        }
        
		background.position = CGPointMake(screenSize.width / 2, screenSize.height / 2);
		[self addChild:background];
        
        animalA = [Animal animalWithParentNode:self pos:ccp(0, 0) prefix:1];
        animalB = [Animal animalWithParentNode:self pos:ccp(0, 0) prefix:2];
        animalC = [Animal animalWithParentNode:self pos:ccp(0, 0) prefix:3];
        
        
        _navBar = [ZZNavBar node];
        [self addChild:_navBar];
        [_navBar setTitleLabelWithString:NSLocalizedStringFromTable(@"zoo", [ZZNavBar getStringEnCnJp], nil)];
        
        animalA.delegate = self;
        animalB.delegate = self;
        animalC.delegate = self;
        
        [ZooScene loadEffects];
        
    }
    return self;
}

+(CGPoint) locationFromTouch:(UITouch*)touch
{
	CGPoint touchLocation = [touch locationInView: [touch view]];
	return [[CCDirector sharedDirector] convertToGL:touchLocation];
}

+ (void)loadEffects {

    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_COW_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_ZOO_ELEPHANT_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_LION_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_GORILLA_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_PANDA_EN];
    
    switch ([ZZNavBar getNumberEnCnJp]) {
        case 2:
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_COW_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_ZOO_ELEPHANT_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_LION_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_GORILLA_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_PANDA_CN];
            
            break;
            
        case 3:
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_COW_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_ZOO_ELEPHANT_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_LION_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_GORILLA_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_PANDA_JP];
            
            break;
            
        default:
            break;
    }
}

+ (void)unloadEffects {
    
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_COW_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_ZOO_ELEPHANT_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_LION_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_GORILLA_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_PANDA_EN];
    
    switch ([ZZNavBar getNumberEnCnJp]) {
        case 2:
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_COW_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_ZOO_ELEPHANT_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_LION_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_GORILLA_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_PANDA_CN];
            
            break;
            
        case 3:
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_COW_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_ZOO_ELEPHANT_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_LION_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_GORILLA_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_PANDA_JP];
            
            break;
            
        default:
            break;
    }

}

//狮子，熊猫，猩猩，奶牛，大象
//大象，猩猩，狮子，熊猫，奶牛
//奶牛，大象，猩猩，狮子，熊猫
// 0    1    2    3    4

- (void)animalIsMatch {
    
    NSString *name = nil;
    BOOL isEn = [[[ZooScene sharedZooScene] navBar] isEnglish];
    if ([animalA getCurrentAnimalTag] == 0 && [animalB getCurrentAnimalTag] == 2 && [animalC getCurrentAnimalTag] == 3) {
        [_navBar setTitleLabelWithString:NSLocalizedStringFromTable(@"lion", [ZZNavBar getStringEnCnJp], nil)];
        
        if (isEn) {
            name = SOUND_LION_EN;
        } else {
            
            if ([ZZNavBar getNumberEnCnJp] == 2) {
                name = SOUND_LION_CN;
            } else {
                name = SOUND_LION_JP;
            }
        }
        [audioEngine playEffect:name];
        
        [animalA setAnimalRightAnim];
        [animalB setAnimalRightAnim];
        [animalC setAnimalRightAnim];
        
        //配音：模拟动物叫声，说出动物单词
    } else if ([animalA getCurrentAnimalTag] == 1 && [animalB getCurrentAnimalTag] == 3 && [animalC getCurrentAnimalTag] == 4) {
        [_navBar setTitleLabelWithString:NSLocalizedStringFromTable(@"panda", [ZZNavBar getStringEnCnJp], nil)];
        if (isEn) {
            name = SOUND_PANDA_EN;
        } else {
            
            if ([ZZNavBar getNumberEnCnJp] == 2) {
                name = SOUND_PANDA_CN;
            } else {
                name = SOUND_PANDA_JP;
            }
        }
        [audioEngine playEffect:name];
        [animalA setAnimalRightAnim];
        [animalB setAnimalRightAnim];
        [animalC setAnimalRightAnim];
        
    } else if ([animalA getCurrentAnimalTag] == 2 && [animalB getCurrentAnimalTag] == 1 && [animalC getCurrentAnimalTag] == 2) {
        [_navBar setTitleLabelWithString:NSLocalizedStringFromTable(@"gorilla", [ZZNavBar getStringEnCnJp], nil)];
        
        if (isEn) {
            name = SOUND_GORILLA_EN;
        } else {
            
            if ([ZZNavBar getNumberEnCnJp] == 2) {
                name = SOUND_GORILLA_CN;
            } else {
                name = SOUND_GORILLA_JP;
            }
        }
        [audioEngine playEffect:name];
        
        [animalA setAnimalRightAnim];
        [animalB setAnimalRightAnim];
        [animalC setAnimalRightAnim];
    } else if ([animalA getCurrentAnimalTag] == 3 && [animalB getCurrentAnimalTag] == 4 && [animalC getCurrentAnimalTag] == 0) {
        [_navBar setTitleLabelWithString:NSLocalizedStringFromTable(@"cow", [ZZNavBar getStringEnCnJp], nil)];
        if (isEn) {
            name = SOUND_COW_EN;
        } else {
            
            if ([ZZNavBar getNumberEnCnJp] == 2) {
                name = SOUND_COW_CN;
            } else {
                name = SOUND_COW_JP;
            }
        }
        [audioEngine playEffect:name];
        
        [animalA setAnimalRightAnim];
        [animalB setAnimalRightAnim];
        [animalC setAnimalRightAnim];
    } else if ([animalA getCurrentAnimalTag] == 4 && [animalB getCurrentAnimalTag] == 0 && [animalC getCurrentAnimalTag] == 1) {
        [_navBar setTitleLabelWithString:NSLocalizedStringFromTable(@"elephant", [ZZNavBar getStringEnCnJp], nil)];
        if (isEn) {
            name = SOUND_ZOO_ELEPHANT_EN;
        } else {
            
            if ([ZZNavBar getNumberEnCnJp] == 2) {
                name = SOUND_ZOO_ELEPHANT_CN;
            } else {
                name = SOUND_ZOO_ELEPHANT_JP;
            }
        }
        [audioEngine playEffect:name];
        
        [animalA setAnimalRightAnim];
        [animalB setAnimalRightAnim];
        [animalC setAnimalRightAnim];
    } else {
        [_navBar setTitleLabelWithString:NSLocalizedStringFromTable(@"zoo", [ZZNavBar getStringEnCnJp], nil)];
    }
    
}

- (void)onExitTransitionDidStart {
    
    [[CCTouchDispatcher sharedDispatcher] removeAllDelegates];
}




@end
