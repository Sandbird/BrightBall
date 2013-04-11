//
//  FireworkScene.m
//  Brazil
//
//  Created by zhaozilong on 13-1-18.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "FireworkScene.h"
#import "Firecracker.h"

#define LANTERN_1 1111
#define LANTERN_2 2222


@implementation FireworkScene

@synthesize navBar = _navBar;
@synthesize snake = _snake;
@synthesize isFirst = _isFirst;

static FireworkScene *instanceOfFireworkScene;

- (void)dealloc {
    
    CCLOG(@"FireworkScene dealloc");
    [FireworkScene unloadEffects];
    instanceOfFireworkScene = nil;
    
//    [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"firework.plist"];
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    [super dealloc];
}

+ (FireworkScene *)sharedFireworkScene {
    NSAssert(instanceOfFireworkScene, @"FireworkScene instance not yet initialized!");
    return instanceOfFireworkScene;
}

+ (id)scene {
    CCScene *scene = [CCScene node];
    
    FireworkScene *layer = [FireworkScene node];
    
    [scene addChild:layer];
    
    return scene;
}

- (id)init {
    
    if (self = [super init]) {
        instanceOfFireworkScene = self;
        
        isTouchEnabled_ = YES;
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        //加载音效
        [FireworkScene preloadEffects];
        
        _isFirst = YES;
        
        //加载图片        
        CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        [frameCache addSpriteFramesWithFile:@"firework.plist"];
        CGPoint bgPoint = ccp(screenSize.width / 2, screenSize.height / 2);
        
        //背景和房子
        CCLayerColor *color = [CCLayerColor layerWithColor:ccc4(163, 231, 223, 255)];
        [self addChild:color z:-15];
        
        CCSprite *ground = [CCSprite spriteWithSpriteFrameName:@"ground.png"];
        CCSprite *house = [CCSprite spriteWithSpriteFrameName:@"house.png"];
        [self addChild:ground z:-10];
        [self addChild:house z:-1];
        ground.position = ccp(screenSize.width / 2, ground.contentSize.height / 2);
        house.position = bgPoint;
        
        CGFloat lantern1X, lantern2X, lanternY;
        CGPoint firecrackerPos[17];
        CGFloat rotate[17];
        CGFloat up;
//        int count = 0;
        if ([ZZNavBar isiPad]) {
            lantern1X = 185;
            lantern2X = 570;
            lanternY = 850;
            
            up = 20;
            firecrackerPos[0] = ccp(425, 480);
            firecrackerPos[1] = ccp(520, 460);
            firecrackerPos[2] = ccp(425, 440);
            firecrackerPos[3] = ccp(520, 420);
            firecrackerPos[4] = ccp(425, 400);
            firecrackerPos[5] = ccp(520 + 2, 380 + up);
            firecrackerPos[6] = ccp(425 + 10, 360 + up);
            firecrackerPos[7] = ccp(520 + 12, 340 + up);
            firecrackerPos[8] = ccp(425 + 20, 320 + up);
            firecrackerPos[9] = ccp(520 + 24, 300 + up);
            firecrackerPos[10] = ccp(425 + 22, 280 + up);
            firecrackerPos[11] = ccp(520 + 30, 260 + up);
            firecrackerPos[12] = ccp(425 + 27, 240 + up);
            firecrackerPos[13] = ccp(520 + 29, 220 + up);
            firecrackerPos[14] = ccp(425 + 25, 200 + up);
            firecrackerPos[15] = ccp(520 + 20, 180 + up);
            firecrackerPos[16] = ccp(425 + 36, 160 + up - 10);
            
            rotate[0] = 45;
            rotate[1] = 315;
            rotate[2] = 45;
            rotate[3] = 315;
            rotate[4] = 45;
            rotate[5] = 315;
            rotate[6] = 45;
            rotate[7] = 315;
            rotate[8] = 45;
            rotate[9] = 315;
            rotate[10] = 45;
            rotate[11] = 315;
            rotate[12] = 45;
            rotate[13] = 315;
            rotate[14] = 45;
            rotate[15] = 315;
            rotate[16] = 10;
            
            
        } else {
            
            CGFloat x = 0.41667;
            CGFloat y = 0.46875;
            
            lantern1X = 185 * x;
            lantern2X = 570 * x;
            
            up = -20;
            
            if ([ZZNavBar isiPhone5]) {
                lanternY = 750 * y + 100;
                
                firecrackerPos[0] = ccp(425 * x, 480 * y + up);
                firecrackerPos[1] = ccp(520 * x, 460 * y + up);
                firecrackerPos[2] = ccp(425 * x, 440 * y + up);
                firecrackerPos[3] = ccp(520 * x, 420 * y + up);
                firecrackerPos[4] = ccp(425 * x, 400 * y + up + 5);
                firecrackerPos[5] = ccp(520 * x + 3, 380 * y + up + 5);
                firecrackerPos[6] = ccp(425 * x + 2, 360 * y + up + 8);
                firecrackerPos[7] = ccp(520 * x + 8, 340 * y + up + 7);
                firecrackerPos[8] = ccp(425 * x + 7, 320 * y + up + 11);
                firecrackerPos[9] = ccp(520 * x + 11, 300 * y + up + 10);
                firecrackerPos[10] = ccp(425 * x + 10, 280 * y + up + 12);
                firecrackerPos[11] = ccp(520 * x + 14, 260 * y + up + 12);
                firecrackerPos[12] = ccp(425 * x + 11, 240 * y + up + 18);
                firecrackerPos[13] = ccp(520 * x + 12, 220 * y + up + 18);
                firecrackerPos[14] = ccp(425 * x + 10, 200 * y + up + 22);
                firecrackerPos[15] = ccp(520 * x + 10, 180 * y + up + 20);
                firecrackerPos[16] = ccp(425 * x + 16, 160 * y + up + 18);
            } else {
                lanternY = 750 * y + 30;
                
                firecrackerPos[0] = ccp(425 * x, 480 * y + up);
                firecrackerPos[1] = ccp(520 * x, 460 * y + up);
                firecrackerPos[2] = ccp(425 * x, 440 * y + up);
                firecrackerPos[3] = ccp(520 * x, 420 * y + up);
                firecrackerPos[4] = ccp(425 * x, 400 * y + up + 5);
                firecrackerPos[5] = ccp(520 * x + 3, 380 * y + up + 5);
                firecrackerPos[6] = ccp(425 * x + 2, 360 * y + up + 8);
                firecrackerPos[7] = ccp(520 * x + 8, 340 * y + up + 7);
                firecrackerPos[8] = ccp(425 * x + 7, 320 * y + up + 11);
                firecrackerPos[9] = ccp(520 * x + 11, 300 * y + up + 10);
                firecrackerPos[10] = ccp(425 * x + 10, 280 * y + up + 12);
                firecrackerPos[11] = ccp(520 * x + 14, 260 * y + up + 12);
                firecrackerPos[12] = ccp(425 * x + 11, 240 * y + up + 18);
                firecrackerPos[13] = ccp(520 * x + 12, 220 * y + up + 18);
                firecrackerPos[14] = ccp(425 * x + 10, 200 * y + up + 22);
                firecrackerPos[15] = ccp(520 * x + 10, 180 * y + up + 20);
                firecrackerPos[16] = ccp(425 * x + 16, 160 * y + up + 18);
            }
            
            
            
            rotate[0] = 45;
            rotate[1] = 315;
            rotate[2] = 45;
            rotate[3] = 315;
            rotate[4] = 45;
            rotate[5] = 315;
            rotate[6] = 45;
            rotate[7] = 315;
            rotate[8] = 45;
            rotate[9] = 315;
            rotate[10] = 45;
            rotate[11] = 315;
            rotate[12] = 45;
            rotate[13] = 315;
            rotate[14] = 45;
            rotate[15] = 315;
            rotate[16] = 10;
        }
        
        //加入纹理
        CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage:@"firework.png"];
        
        //灯笼
        lanternSpriteBatch = [CCSpriteBatchNode batchNodeWithTexture:[[frameCache spriteFrameByName:@"lantern.png"] texture]];
        [self addChild:lanternSpriteBatch];
        CCSprite *lantern = [CCSprite spriteWithSpriteFrameName:@"lantern.png"];
        lantern.anchorPoint = ccp(0.5, 1);
        lantern.position = ccp(lantern1X, lanternY);
        [lanternSpriteBatch addChild:lantern z:-5 tag:LANTERN_1];
        
        lantern = [CCSprite spriteWithSpriteFrameName:@"lantern.png"];
        lantern.anchorPoint = ccp(0.5, 1);
        lantern.position = ccp(lantern2X, lanternY);
        [lanternSpriteBatch addChild:lantern z:-5 tag:LANTERN_2];
        
        //小蛇
        _snake = [Snake snakeWithParentNode:self];
        
        //鞭炮
        firecrackerSpriteBatch = [CCSpriteBatchNode batchNodeWithTexture:texture];
        [_snake addChild:firecrackerSpriteBatch z:-1];
        BOOL isFlip;
        for (int i = 0; i < 17; i++) {
            Firecracker *firecracker;
            if (i % 2 == 0) {
                isFlip = YES;
            } else {
                isFlip = NO;
            }
            firecracker = [Firecracker firecrackerWithPos:firecrackerPos[i] zorder:i rotate:rotate[i] isFlip:isFlip];
            [firecrackerSpriteBatch addChild:firecracker z:i tag:i + 100];
        }
        
        //加navgation
        _navBar = [ZZNavBar node];
        [self addChild:_navBar];
        [_navBar setTitleLabelWithString:NSLocalizedStringFromTable(@"firecracker", [ZZNavBar getStringEnCnJp], nil)];
        
    }
    return self;
}

-(void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:-1 swallowsTouches:YES];
}

- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint currentTouchPoint = [FireworkScene locationFromTouch:touch];
    CCSprite *lanternSprite1 = (CCSprite *)[lanternSpriteBatch getChildByTag:LANTERN_1];
    CCSprite *lanternSprite2 = (CCSprite *)[lanternSpriteBatch getChildByTag:LANTERN_2];
    isTouchEnabled_ = (CGRectContainsPoint(lanternSprite1.boundingBox, currentTouchPoint) || CGRectContainsPoint(lanternSprite2.boundingBox, currentTouchPoint));
    
    if (isTouchEnabled_) {
        if (CGRectContainsPoint(lanternSprite1.boundingBox, currentTouchPoint)) {
            [lanternSprite1 runAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1 scale:1.1], [CCScaleTo actionWithDuration:0.1 scale:1.0], nil]];
            [self playLanternAnimateWithSprite:lanternSprite1];
            [_navBar setTitleLabelWithString:NSLocalizedStringFromTable(@"lantern", [ZZNavBar getStringEnCnJp], nil)];
            
            [_navBar playSoundByNameEn:SOUND_LANTERN_EN Cn:SOUND_LANTERN_CN Jp:SOUND_LANTERN_JP];
            
        } else if (CGRectContainsPoint(lanternSprite2.boundingBox, currentTouchPoint)) {
            [lanternSprite2 runAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1 scale:1.1], [CCScaleTo actionWithDuration:0.1 scale:1.0], nil]];
            [self playLanternAnimateWithSprite:lanternSprite2];
            [_navBar setTitleLabelWithString:NSLocalizedStringFromTable(@"lantern", [ZZNavBar getStringEnCnJp], nil)];
            
            [_navBar playSoundByNameEn:SOUND_LANTERN_EN Cn:SOUND_LANTERN_CN Jp:SOUND_LANTERN_JP];
        } else {
            
        }
    }
    
    return isTouchEnabled_;
}

- (void)playLanternAnimateWithSprite:(CCSprite *)lantern {
    CCRotateTo *leftR = [CCRotateTo actionWithDuration:0.2 angle:45];
    CCRotateTo *rightR = [CCRotateTo actionWithDuration:0.4 angle:-45];
    CCRotateTo *normalR = [CCRotateTo actionWithDuration:0.2 angle:0];
    
    CCSequence *leftRight = [CCSequence actions:leftR, rightR, normalR, nil];
    [lantern runAction:leftRight];
    
}

+(CGPoint) locationFromTouch:(UITouch*)touch
{
	CGPoint touchLocation = [touch locationInView: [touch view]];
	return [[CCDirector sharedDirector] convertToGL:touchLocation];
}

- (void)restoreFirecrackers {
    Firecracker *sprite;
	CCARRAY_FOREACH([firecrackerSpriteBatch children], sprite) {
        [sprite runAction:[CCShow action]];
    }
}

- (void)onExitTransitionDidStart {
    [[CCTouchDispatcher sharedDispatcher] removeAllDelegates];
}

//提前加载音效
+ (void)preloadEffects {
    
    [[SimpleAudioEngine sharedEngine] preloadEffect:EFFECT_FIRECRACKER_01];
    [[SimpleAudioEngine sharedEngine] preloadEffect:EFFECT_FIRECRACKER_02];
    
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_FIRECRACKER_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_HOUSE_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_LANTERN_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_NEWYEAR_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_SNAKE_EN];
    
    switch ([ZZNavBar getNumberEnCnJp]) {
        case 2:
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_FIRECRACKER_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_HOUSE_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_LANTERN_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_NEWYEAR_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_SNAKE_CN];
            break;
            
        case 3:
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_FIRECRACKER_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_HOUSE_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_LANTERN_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_NEWYEAR_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_SNAKE_JP];
            break;
            
        default:
            break;
    }
}

+ (void)unloadEffects {
    
    [[SimpleAudioEngine sharedEngine] unloadEffect:EFFECT_FIRECRACKER_01];
    [[SimpleAudioEngine sharedEngine] unloadEffect:EFFECT_FIRECRACKER_02];
    
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_FIRECRACKER_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_HOUSE_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_LANTERN_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_NEWYEAR_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_SNAKE_EN];
    
    switch ([ZZNavBar getNumberEnCnJp]) {
        case 2:
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_FIRECRACKER_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_HOUSE_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_LANTERN_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_NEWYEAR_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_SNAKE_CN];
            break;
            
        case 3:
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_FIRECRACKER_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_HOUSE_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_LANTERN_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_NEWYEAR_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_SNAKE_JP];
            break;
            
        default:
            break;
    }
}


@end
