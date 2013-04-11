//
//  RedPacketScene.m
//  Brazil
//
//  Created by zhaozilong on 13-1-22.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "RedPacketScene.h"
#import "RedPacket.h"


@implementation RedPacketScene

@synthesize navBar = _navBar;

static RedPacketScene *instanceOfRedPacketScene;

- (void)dealloc {
    
    
    CCLOG(@"RedPacketScene is dealloc");
    [self unloadEffects];

    instanceOfRedPacketScene = nil;
    
//    [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"red.plist"];
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    [super dealloc];
}

+ (RedPacketScene *)sharedRedPacketScene {
    
    NSAssert(instanceOfRedPacketScene != nil, @"instanceOfRedPacketScene is not intialize");
    return instanceOfRedPacketScene;
}

+ (id)scene {
    CCScene *scene = [CCScene node];
    RedPacketScene *layer = [RedPacketScene node];
    
    [scene addChild:layer];
    
    return scene;
}

- (id)init {
    
    if (self = [super init]) {
        instanceOfRedPacketScene = self;
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        [frameCache addSpriteFramesWithFile:@"red.plist"];
        
        CCSprite *bgSprite = [CCSprite spriteWithSpriteFrameName:@"bg.png"];
        [self addChild:bgSprite z:-5];
        bgSprite.position = ccp(screenSize.width / 2, screenSize.height / 2);
        
        CGPoint point[6];
        if ([ZZNavBar isiPad]) {
            point[0] = ccp(screenSize.width / 2 - 230, 200);
            point[1] = ccp(screenSize.width / 2, 200);
            point[2] = ccp(screenSize.width / 2 + 230, 200);
            
            point[3] = ccp(screenSize.width / 2 - 230, 625);
            point[4] = ccp(screenSize.width / 2, 625);
            point[5] = ccp(screenSize.width / 2 + 230, 625);
        } else {
            if ([ZZNavBar isiPhone5]) {
                point[0] = ccp(screenSize.width / 2 - 100, 130);
                point[1] = ccp(screenSize.width / 2, 130);
                point[2] = ccp(screenSize.width / 2 + 100, 130);
                
                point[3] = ccp(screenSize.width / 2 - 100, 340);
                point[4] = ccp(screenSize.width / 2, 340);
                point[5] = ccp(screenSize.width / 2 + 100, 340);
            } else {
                point[0] = ccp(screenSize.width / 2 - 100, 90);
                point[1] = ccp(screenSize.width / 2, 90);
                point[2] = ccp(screenSize.width / 2 + 100, 90);
                
                point[3] = ccp(screenSize.width / 2 - 100, 285);
                point[4] = ccp(screenSize.width / 2, 285);
                point[5] = ccp(screenSize.width / 2 + 100, 285);
            }
        }
        
        NSArray *nums = [self getRandomNumArray];
        
        for (int i = 5; i >= 0; i--) {
            [RedPacket redPacketWithParentNode:self pos:point[i] tag:[[nums objectAtIndex:i] intValue]];
        }
        
        
        _navBar = [ZZNavBar node];
        [self addChild:_navBar];
        [_navBar setTitleLabelWithString:NSLocalizedStringFromTable(@"redPacket", [ZZNavBar getStringEnCnJp], nil)];
        
        //预加载音频
        [self preloadEffects];
        
    }
    return self;
}

- (NSArray *) getRandomNumArray {
    //取得4个互不相等的0-5的随机数
//    nums = [[NSMutableArray alloc] initWithCapacity:4];
    NSMutableArray *nums = [NSMutableArray arrayWithCapacity:6];
    for (int i = 0; i <= 5; i++) {
        [nums addObject:[NSNumber numberWithInt:100]];
    }
    int count = 6;
    BOOL isSame = NO;
    do {
        int randNum = arc4random() % 8;
        for (int i = 0; i <= 5; i++) {
            int num = [[nums objectAtIndex:i] intValue];
            if (num == randNum) {
                isSame = YES;
                break;
            }
        }
        
        if (!isSame) {
            [nums replaceObjectAtIndex:--count withObject:[NSNumber numberWithInt:randNum]];
        }
        
        isSame = NO;
        
    } while (count > 0);
    
    return (NSArray *)nums;
}

+ (CGPoint)locationFromTouch:(UITouch*)touch {
    CGPoint touchLocation = [touch locationInView:[touch view]];
    return [[CCDirector sharedDirector] convertToGL:touchLocation];
}

- (void)onExitTransitionDidStart {
    [[CCTouchDispatcher sharedDispatcher] removeAllDelegates];
}

- (void)preloadEffects {
    
    [[SimpleAudioEngine sharedEngine] preloadEffect:EFFECT_REDPACKET_01];
    [[SimpleAudioEngine sharedEngine] preloadEffect:EFFECT_REDPACKET_02];
    
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_REDPACKET_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_ALIEN_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_CAMERA_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_GLASSES_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_GOLDINGOT_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_LOLLIPOP_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_TEDDYBEAR_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_MOUSE_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_PENCIL_EN];
    
    switch ([ZZNavBar getNumberEnCnJp]) {
        case 2:
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_REDPACKET_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_ALIEN_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_CAMERA_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_GLASSES_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_GOLDINGOT_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_LOLLIPOP_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_TEDDYBEAR_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_MOUSE_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_PENCIL_CN];
            break;
            
        case 3:
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_REDPACKET_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_ALIEN_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_CAMERA_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_GLASSES_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_GOLDINGOT_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_LOLLIPOP_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_TEDDYBEAR_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_MOUSE_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_PENCIL_JP];
            break;
            
        default:
            break;
    }
}

- (void)unloadEffects {
    
    [[SimpleAudioEngine sharedEngine] unloadEffect:EFFECT_REDPACKET_01];
    [[SimpleAudioEngine sharedEngine] unloadEffect:EFFECT_REDPACKET_02];
    
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_REDPACKET_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_ALIEN_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_CAMERA_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_GLASSES_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_GOLDINGOT_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_LOLLIPOP_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_TEDDYBEAR_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_MOUSE_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_PENCIL_EN];
    
    switch ([ZZNavBar getNumberEnCnJp]) {
        case 2:
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_REDPACKET_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_ALIEN_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_CAMERA_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_GLASSES_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_GOLDINGOT_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_LOLLIPOP_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_TEDDYBEAR_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_MOUSE_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_PENCIL_CN];
            break;
            
        case 3:
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_REDPACKET_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_ALIEN_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_CAMERA_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_GLASSES_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_GOLDINGOT_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_LOLLIPOP_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_TEDDYBEAR_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_MOUSE_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_PENCIL_JP];
            break;
            
        default:
            break;
    }
}

@end
