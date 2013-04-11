//
//  RubbishScene.m
//  Brazil
//
//  Created by zhaozilong on 12-11-29.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "RubbishScene.h"
#import "CCAnimationHelper.h"
#import "Track.h"


@implementation RubbishScene

@synthesize dustbin = _dustbin;
@synthesize rubbish = _rubbish;
@synthesize navBar = _navBar;

static RubbishScene *instanceOfRubbishScene;

- (void)dealloc {
    
    CCLOG(@"RubbishScene dealloc");
    [RubbishScene unloadEffects];
    instanceOfRubbishScene = nil;
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"rubbish.plist"];
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    [super dealloc];
}

+ (RubbishScene *)sharedRubbishScene {
    NSAssert(instanceOfRubbishScene, @"RubbishScene instance not yet initialized!");
    return instanceOfRubbishScene;
}

+ (id)scene {
    CCScene *scene = [CCScene node];
    
    RubbishScene *layer = [RubbishScene node]; 
    
    [scene addChild:layer];
    
    return scene;
}

- (id)init {
    
    if (self = [super init]) {
        instanceOfRubbishScene = self;
        
        isTouchEnabled_ = YES;
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        //加载音效
        [RubbishScene loadEffectMusic];
        
        CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        [frameCache addSpriteFramesWithFile:@"rubbish.plist"];
        CGPoint bgPoint = CGPointMake(screenSize.width / 2, screenSize.height / 2);
        
        CCSprite* background;// = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"rubbishBG.png"]];
        if ([ZZNavBar isiPhone5]) {
            background = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"rubbishBG-568.png"]];
        } else {
            background = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"rubbishBG.png"]];
        }
        
		background.position = bgPoint;
		[self addChild:background];
        
        CCSprite *smokeLeft = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"smokeLeft0.png"]];
        CCSprite *smokeRight = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"smokeRight0.png"]];
        smokeLeft.position = bgPoint;
        smokeRight.position = bgPoint;
        [self addChild:smokeLeft];
        [self addChild:smokeRight];
        CCAnimation *smokeLeftAnim = [CCAnimation animationWithFrame:@"smokeLeft" frameCount:5 delay:0.2];
        CCAnimation *smokeRightAnim = [CCAnimation animationWithFrame:@"smokeRight" frameCount:5 delay:0.2];
        CCRepeatForever *animLeft = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:smokeLeftAnim]];
        CCRepeatForever *animRight = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:smokeRightAnim]];
        [smokeLeft runAction:animLeft];
        [smokeRight runAction:animRight];
        
        CCSprite *stack1 = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"smoke0.png"]];
        CCSprite *stack2 = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"smoke1.png"]];
        CCSprite *stack3 = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"smoke2.png"]];
        stack1.position = bgPoint;
        stack2.position = bgPoint;
        stack3.position = bgPoint;
        [self addChild:stack1];
        [self addChild:stack2];
        [self addChild:stack3];
        
        _dustbin = [Can canWithParentNode:self];
        
        Track *track = [Track node];
        track.tag = 1234;
		[self addChild:track];
        
        //加navgation
        _navBar = [ZZNavBar node];
        [self addChild:_navBar z:3];
        [_navBar setTitleLabelWithString:@"垃圾分类\nRefuse Sorting"];
        
        
        [self scheduleUpdate];
        
    }
    return self;
}

+(CGPoint) locationFromTouch:(UITouch*)touch
{
	CGPoint touchLocation = [touch locationInView: [touch view]];
	return [[CCDirector sharedDirector] convertToGL:touchLocation];
}

//提前加载音效
+(void)loadEffectMusic{
    
    [[SimpleAudioEngine sharedEngine] preloadEffect:EFFECT_RUBBISH_0];
    [[SimpleAudioEngine sharedEngine] preloadEffect:EFFECT_RUBBISH_RIGHT];
    [[SimpleAudioEngine sharedEngine] preloadEffect:EFFECT_RUBBISH_WRONG];
    
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_BANANASKIN_CN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_DISK_CN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_FISHBONE_CN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_KITCHENWASTE_CN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_NEWSPAPER_CN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_OTHERWASTE_CN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_PAPERCUP_CN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_PLASTIC_CN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_RECYCLABLE_CN];
    
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_BANANASKIN_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_DISK_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_FISHBONE_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_KITCHENWASTE_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_NEWSPAPER_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_OTHERWASTE_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_PAPERCUP_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_PLASTIC_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_RECYCLABLE_EN];
}

+ (void)unloadEffects {
    [[SimpleAudioEngine sharedEngine] unloadEffect:EFFECT_RUBBISH_0];
    [[SimpleAudioEngine sharedEngine] unloadEffect:EFFECT_RUBBISH_RIGHT];
    [[SimpleAudioEngine sharedEngine] unloadEffect:EFFECT_RUBBISH_WRONG];
    
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_BANANASKIN_CN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_DISK_CN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_FISHBONE_CN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_KITCHENWASTE_CN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_NEWSPAPER_CN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_OTHERWASTE_CN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_PAPERCUP_CN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_PLASTIC_CN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_RECYCLABLE_CN];
    
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_BANANASKIN_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_DISK_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_FISHBONE_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_KITCHENWASTE_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_NEWSPAPER_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_OTHERWASTE_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_PAPERCUP_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_PLASTIC_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_RECYCLABLE_EN];
}


- (void)update:(ccTime)delta {
    
    if (!_rubbish.isTouchHandled) {
#if 0
        
        //用来测试男孩嘴的位置
        CCSprite *test = [CCSprite spriteWithFile:@"Default@2x.png" rect:[_dustbin getCanSpriteRectByCanTags:CanRecycleTag]];
        test.anchorPoint = ccp(0, 0);
        test.position = [_dustbin getCanSpriteRectByCanTags:CanRecycleTag].origin;
        [self addChild:test z:10];
#endif
        
        if (CGRectIntersectsRect([_rubbish getRubbishSpriteRect], [_dustbin getCanSpriteRectByCanTags:CanRecycleTag])) {
            //播放音效
            [[SimpleAudioEngine sharedEngine] playEffect:EFFECT_RUBBISH_0];
            
            CCLOG(@"可回收垃圾");
            _rubbish.lastTouchPoint = ccp(0, 0);
            
            //fruit dispeared
            [_rubbish setRubbishSpriteVisible:NO];
            
            //Action of head
            [_dustbin setCanAnimByCanTag:CanRecycleTag rubbishTag:_rubbish.currentRubbishTag];
            
        } else if (CGRectIntersectsRect([_dustbin getCanSpriteRectByCanTags:CanHarmTag], [_rubbish getRubbishSpriteRect])) {
            //播放音效
            [[SimpleAudioEngine sharedEngine] playEffect:EFFECT_RUBBISH_0];
            
            CCLOG(@"有害垃圾");
            _rubbish.lastTouchPoint = ccp(0, 0);
            
            //fruit dispeared
            [_rubbish setRubbishSpriteVisible:NO];
            
            //Action of head
            [_dustbin setCanAnimByCanTag:CanHarmTag rubbishTag:_rubbish.currentRubbishTag];
            
            
        } else if (CGRectIntersectsRect([_dustbin getCanSpriteRectByCanTags:CanKitchenTag], [_rubbish getRubbishSpriteRect])) {
            //播放音效
            [[SimpleAudioEngine sharedEngine] playEffect:EFFECT_RUBBISH_0];
            
            CCLOG(@"厨余垃圾");
            _rubbish.lastTouchPoint = ccp(0, 0);
            
            //fruit dispeared
            [_rubbish setRubbishSpriteVisible:NO];
            
            //Action of head
            [_dustbin setCanAnimByCanTag:CanKitchenTag rubbishTag:_rubbish.currentRubbishTag];
        } else {
            
        }
    }
    
}

- (void)onExitTransitionDidStart {

    Track *track = (Track *)[self getChildByTag:1234];
    [track unscheduleUpdate];
    [[CCTouchDispatcher sharedDispatcher] removeAllDelegates];
    [self unscheduleUpdate];
}



@end
