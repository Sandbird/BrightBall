//
//  CircusScene.m
//  Brazil
//
//  Created by zhaozilong on 12-12-18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CircusScene.h"


@implementation CircusScene

@synthesize navBar = _navBar;
@synthesize isAnimLocked = _isAnimLocked;

static CircusScene *instanceOfCircusScene;

- (void)dealloc {
    
    CCLOG(@"circusScene dealloc");
    [CircusScene unloadEffects];
    instanceOfCircusScene = nil;
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"circus.plist"];
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    [super dealloc];
}

+ (CircusScene *)sharedCircusScene {
    NSAssert(instanceOfCircusScene != nil, @"CircusScene is not yet initialize");
    return instanceOfCircusScene;
}

+ (id)scene {
    CCScene *scene = [CCScene node];
    CircusScene *layer = [CircusScene node];
    [scene addChild:layer];
    return scene;
}

- (id)init {
    if (self = [super init]) {
        instanceOfCircusScene = self;
        
//        CGPoint
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        [frameCache addSpriteFramesWithFile:@"circus.plist"];
        
        CCSpriteFrame *frame;

        if ([ZZNavBar isiPhone5]) {
            frame = [frameCache spriteFrameByName:@"circusBG-568.png"];
        } else {
            frame = [frameCache spriteFrameByName:@"circusBG.png"];
        }
        
        CCSprite *bgSprite = [CCSprite spriteWithSpriteFrame:frame];
        [self addChild:bgSprite];
        bgSprite.position = ccp(screenSize.width / 2, screenSize.height / 2);
        
        disk = [Disk diskWithParentNode:self];
        
        frame = [frameCache spriteFrameByName:@"elephantC.png"];
        elephantSprite = [CCSprite spriteWithSpriteFrame:frame];
        
        frame = [frameCache spriteFrameByName:@"jokerC.png"];
        jokerSprite = [CCSprite spriteWithSpriteFrame:frame];
        
        //加返回按钮和主页按钮
        CCMenuItem *elephantItem = [CCMenuItemImage itemFromNormalSprite:elephantSprite selectedSprite:nil disabledSprite:nil target:self selector:@selector(startElephantAnim)];
        
        CCMenuItem *jokerItem = [CCMenuItemImage itemFromNormalSprite:jokerSprite selectedSprite:nil disabledSprite:nil target:self selector:@selector(startJokerAnim)];

        CCMenu *menu = [CCMenu menuWithItems:elephantItem, jokerItem, nil];
        
        CGPoint elephantItemPos, jokerItemPos;
        if ([ZZNavBar isiPad]) {
            elephantItemPos = ccp(80, 80);
            jokerItemPos = ccp(700, 80);
        } else {
            if ([ZZNavBar isiPhone5]) {
                elephantItemPos = ccp(40, 40);
                jokerItemPos = ccp(280, 40);
            } else {
                elephantItemPos = ccp(40, 40);
                jokerItemPos = ccp(280, 40);
            }
            
        }
        menu.position = ccp(0, 0);
        elephantItem.position = elephantItemPos;
        jokerItem.position = jokerItemPos;
        [self addChild:menu];
        
        _navBar = [ZZNavBar node];
        [self addChild:_navBar];
        [_navBar setTitleLabelWithString:NSLocalizedStringFromTable(@"circus", [ZZNavBar getStringEnCnJp], nil)];
        
        [CircusScene loadEffects];
        
    }
    return self;
}

+(CGPoint) locationFromTouch:(UITouch*)touch
{
	CGPoint touchLocation = [touch locationInView: [touch view]];
	return [[CCDirector sharedDirector] convertToGL:touchLocation];
}

- (void)startElephantAnim {
    if (_isAnimLocked) {
        return;
    }
    
    _isAnimLocked = YES;
    [disk setElephantAnim];
    [disk sayEnglishByStr:CIRCUS_ELEPHANT];
}

- (void)startJokerAnim {
    if (_isAnimLocked) {
        return;
    }
    
    _isAnimLocked = YES;
    [disk setJokerAnim];
    [disk sayEnglishByStr:CIRCUS_JOKER];
}

- (void)onExitTransitionDidStart {
    [[CCTouchDispatcher sharedDispatcher] removeAllDelegates];
}

+ (void)loadEffects {
    
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_ELEPHANT_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_JOKER_EN];
    
    switch ([ZZNavBar getNumberEnCnJp]) {
        case 2:
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_ELEPHANT_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_JOKER_CN];
            
            break;
            
        case 3:
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_ELEPHANT_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_JOKER_JP];
            
            break;
            
        default:
            break;
    }
}

+ (void)unloadEffects {

    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_ELEPHANT_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_JOKER_EN];
    
    switch ([ZZNavBar getNumberEnCnJp]) {
        case 2:
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_ELEPHANT_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_JOKER_CN];
            
            break;
            
        case 3:
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_ELEPHANT_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_JOKER_JP];
            
            break;
            
        default:
            break;
    }
    
}

@end
