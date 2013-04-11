//
//  SeasideScene.m
//  Brazil
//
//  Created by zhaozilong on 13-1-24.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "SeasideScene.h"
#import "FireworkLayer.h"



@implementation SeasideScene

@synthesize navBar = _navBar;

static SeasideScene *instanceOfSeasideScene;

- (void)dealloc {
    
    
    CCLOG(@"SeasideScene is dealloc");
    [self unloadEffects];
    
    instanceOfSeasideScene = nil;
    
//    [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"seaside.plist"];
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    [super dealloc];
}

+ (SeasideScene *)sharedSeasideScene {
    
    NSAssert(instanceOfSeasideScene != nil, @"instanceOfSeasideScene is not intialize");
    return instanceOfSeasideScene;
}

+ (id)scene {
    CCScene *scene = [CCScene node];
    SeasideScene *layer = [SeasideScene node];
    FireworkLayer *layerB = [FireworkLayer node];
    
    [scene addChild:layer];
    [scene addChild:layerB];
    
    return scene;
}

- (id)init {
    
    if (self = [super init]) {
        instanceOfSeasideScene = self;
        
        screenSize = [[CCDirector sharedDirector] winSize];
        
        self.isTouchEnabled = YES;
        
        CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        [frameCache addSpriteFramesWithFile:@"seaside.plist"];
        
        //天空背景
        CCSprite *skyBG = [CCSprite spriteWithSpriteFrameName:@"skyBG.png"];
        [self addChild:skyBG z:-5];
        
        //大海背景
        CCSprite *seaBG = [CCSprite spriteWithSpriteFrameName:@"seaBG.png"];
        [self addChild:seaBG z:-3];
        
        //沙滩背景
        CCSprite *beachBG = [CCSprite spriteWithSpriteFrameName:@"beachBG.png"];
        [self addChild:beachBG z:-1];
        
        //设置位置坐标
        CGPoint starPoint[6], shellPoint[4], umbrellaPoint[3], starfishPoint[3];
        CGPoint skyPoint, beachPoint, seaPoint;
        CGFloat sea0Y, sea1Y, moonY;
        CGFloat smallbig[6] = {1.0, 0.7, 0.6, 0.8, 0.7, 0.9};
        CGFloat umSB[3] = {0.7, 0.6, 0.9};
        
        if ([ZZNavBar isiPad]) {
            skyPoint = ccp(screenSize.width / 2, screenSize.height - skyBG.contentSize.height / 2);
            beachPoint = ccp(screenSize.width / 2, beachBG.contentSize.height / 2);
            seaPoint = ccp(screenSize.width / 2, seaBG.contentSize.height / 2);
            
            sea0Y = -150;
            sea1Y = -200;
            moonY = 0;
            
            starPoint[0] = ccp(60, 780);
            starPoint[1] = ccp(180, 720);
            starPoint[2] = ccp(310, 760);
            starPoint[3] = ccp(470, 745);
            starPoint[4] = ccp(640, 795);
            starPoint[5] = ccp(700, 680);
            
            shellPoint[0] = ccp(40, 30);
            shellPoint[1] = ccp(227, 70);
            shellPoint[2] = ccp(410, 32);
            shellPoint[3] = ccp(730, 30);
            
            umbrellaPoint[0] = ccp(40, 230);
            umbrellaPoint[1] = ccp(640, 260);
            umbrellaPoint[2] = ccp(710, 230);
            
            starfishPoint[0] = ccp(135, 230);
            starfishPoint[1] = ccp(490, 240);
            starfishPoint[2] = ccp(250, 245);
            
        } else {
            if ([ZZNavBar isiPhone5]) {
                skyPoint = ccp(screenSize.width / 2, screenSize.height - skyBG.contentSize.height / 2);
                beachPoint = ccp(screenSize.width / 2, beachBG.contentSize.height / 2);
                seaPoint = ccp(screenSize.width / 2, seaBG.contentSize.height / 2);
                
                sea0Y = -90;
                sea1Y = -115;
                moonY = -40;
                
                starPoint[0] = ccp(30, 430);
                starPoint[1] = ccp(80, 370);
                starPoint[2] = ccp(140, 420);
                starPoint[3] = ccp(220, 395);
                starPoint[4] = ccp(290, 435);
                starPoint[5] = ccp(290, 350);
                
                shellPoint[0] = ccp(20, 10);
                shellPoint[1] = ccp(87, 50);
                shellPoint[2] = ccp(190, 12);
                shellPoint[3] = ccp(290, 10);
                
                umbrellaPoint[0] = ccp(30, 130);
                umbrellaPoint[1] = ccp(260, 135);
                umbrellaPoint[2] = ccp(290, 130);
                
                starfishPoint[0] = ccp(55, 110);
                starfishPoint[1] = ccp(230, 120);
                starfishPoint[2] = ccp(120, 125);
            } else {
                skyPoint = ccp(screenSize.width / 2, screenSize.height - skyBG.contentSize.height / 2);
                beachPoint = ccp(screenSize.width / 2, beachBG.contentSize.height / 2 - 20);
                seaPoint = ccp(screenSize.width / 2, seaBG.contentSize.height / 2 - 20);
                
                sea0Y = -70;
                sea1Y = -95;
                moonY = 0;
                
                starPoint[0] = ccp(30, 350);
                starPoint[1] = ccp(80, 330);
                starPoint[2] = ccp(140, 360);
                starPoint[3] = ccp(220, 345);
                starPoint[4] = ccp(290, 375);
                starPoint[5] = ccp(290, 310);
                
                shellPoint[0] = ccp(20, 10);
                shellPoint[1] = ccp(87, 50);
                shellPoint[2] = ccp(190, 12);
                shellPoint[3] = ccp(290, 10);
                
                umbrellaPoint[0] = ccp(30, 130);
                umbrellaPoint[1] = ccp(260, 135);
                umbrellaPoint[2] = ccp(290, 130);

                starfishPoint[0] = ccp(55, 110);
                starfishPoint[1] = ccp(230, 120);
                starfishPoint[2] = ccp(120, 125);
            }
            
        }
        
        skyBG.position = skyPoint;
        seaBG.position = seaPoint;
        beachBG.position = beachPoint;
        
        //Moon
        CCSprite *moonSprite = [CCSprite spriteWithSpriteFrameName:@"moon.png"];
        [self addChild:moonSprite z:-4 tag:SeasideTagMoon];
        moonSprite.position = ccp(screenSize.width / 2, screenSize.height / 2 + moonY);
        
        //6 stars
        CCTexture2D *texture = [[frameCache spriteFrameByName:@"star.png"] texture];
        starBatch = [CCSpriteBatchNode batchNodeWithTexture:texture];
        [self addChild:starBatch z:0];
        for (int i = SeasideTagStar0; i <= SeasideTagStar5; i++) {
            CCSprite *star = [CCSprite spriteWithSpriteFrameName:@"star.png"];
            [starBatch addChild:star z:0 tag:i];
            star.position = starPoint[i - SeasideTagStar0];
            star.scale = smallbig[i - SeasideTagStar0];
        }
        
        //3 umbrellas
        texture = [[frameCache spriteFrameByName:@"umbrella.png"] texture];
        umBatch = [CCSpriteBatchNode batchNodeWithTexture:texture];
        [self addChild:umBatch z:0];
        for (int i = SeasideTagUmbrella0; i <= SeasideTagUmbrella2; i++) {
            CCSprite *umbrellaSprite = [CCSprite spriteWithSpriteFrameName:@"umbrella.png"];
            [umBatch addChild:umbrellaSprite z:0 tag:i];
            umbrellaSprite.position = umbrellaPoint[i - SeasideTagUmbrella0];
            umbrellaSprite.scale = umSB[i - SeasideTagUmbrella0];
            if (i == SeasideTagUmbrella0) {
                umbrellaSprite.rotation = 40;
            }
        }
        
        //4 sea Sprites
        texture = [[frameCache spriteFrameByName:@"sea0.png"] texture];
        sea0Batch = [CCSpriteBatchNode batchNodeWithTexture:texture];
        [self addChild:sea0Batch z:-2];
        for (int i = SeasideTagSea0; i <= SeasideTagSea1; i++) {
            CCSprite *seaSprite = [CCSprite spriteWithSpriteFrameName:@"sea0.png"];
            [sea0Batch addChild:seaSprite z:0 tag:i];
            seaSprite.anchorPoint = CGPointMake(0, 0.5f);
			seaSprite.position = CGPointMake((i - SeasideTagSea0) * screenSize.width, screenSize.height / 2 + sea0Y);
        }
        
        texture = [[frameCache spriteFrameByName:@"sea1.png"] texture];
        sea1Batch = [CCSpriteBatchNode batchNodeWithTexture:texture];
        [self addChild:sea1Batch z:-2];
        for (int i = SeasideTagSea2; i <= SeasideTagSea3; i++) {
            CCSprite *seaSprite = [CCSprite spriteWithSpriteFrameName:@"sea1.png"];
            [sea1Batch addChild:seaSprite z:0 tag:i];
            seaSprite.anchorPoint = CGPointMake(0, 0.5f);
			seaSprite.position = CGPointMake((i - SeasideTagSea2) * screenSize.width, screenSize.height / 2 + sea1Y);
        }
        
        //4 seashells
        CCSprite *shellSprite = [CCSprite spriteWithSpriteFrameName:@"shell0.png"];
        [self addChild:shellSprite z:0 tag:SeasideTagShell0];
        shellSprite.position = shellPoint[0];
        
        shellSprite = [CCSprite spriteWithSpriteFrameName:@"shell1.png"];
        [self addChild:shellSprite z:0 tag:SeasideTagShell1];
        shellSprite.position = shellPoint[1];
        
        shellSprite = [CCSprite spriteWithSpriteFrameName:@"shell2.png"];
        [self addChild:shellSprite z:0 tag:SeasideTagShell2];
        shellSprite.position = shellPoint[2];
        
        shellSprite = [CCSprite spriteWithSpriteFrameName:@"shell3.png"];
        [self addChild:shellSprite z:0 tag:SeasideTagShell3];
        shellSprite.position = shellPoint[3];
        
        //3 starfishes
        CCSprite *starfishSprite = [CCSprite spriteWithSpriteFrameName:@"starfish0.png"];
        [self addChild:starfishSprite z:0 tag:SeasideTagStarfish0];
        starfishSprite.position = starfishPoint[0];
        
        starfishSprite = [CCSprite spriteWithSpriteFrameName:@"starfish1.png"];
        [self addChild:starfishSprite z:0 tag:SeasideTagStarfish1];
        starfishSprite.position = starfishPoint[1];
        
        starfishSprite = [CCSprite spriteWithSpriteFrameName:@"starfish2.png"];
        [self addChild:starfishSprite z:0 tag:SeasideTagStarfish2];
        starfishSprite.position = starfishPoint[2];
        
        _navBar = [ZZNavBar node];
        [self addChild:_navBar];
        [_navBar setTitleLabelWithString:NSLocalizedStringFromTable(@"fireworks", [ZZNavBar getStringEnCnJp], nil)];
        
        //加载音频
        [self preloadEffects];
        
        [self scheduleUpdate];
    }
    return self;
}

-(void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:-1 swallowsTouches:YES];
}

-(void) update:(ccTime)delta
{
	CCSprite* sprite;
	CCARRAY_FOREACH([sea0Batch children], sprite)
	{
		//CCLOG(@"tag: %i", sprite.tag);
//		NSNumber* factor = [speedFactors objectAtIndex:sprite.zOrder];
        NSNumber* factor = [NSNumber numberWithFloat:1.0];
		
		CGPoint pos = sprite.position;
		pos.x -= 1.0 * [factor floatValue];
		
		// Reposition stripes when they're out of bounds
		if (pos.x < -screenSize.width)
		{
			pos.x += (screenSize.width * 2) - 2;
		}
		
		sprite.position = pos;
	}
    
    CCARRAY_FOREACH([sea1Batch children], sprite)
	{
		//CCLOG(@"tag: %i", sprite.tag);
        //		NSNumber* factor = [speedFactors objectAtIndex:sprite.zOrder];
        NSNumber* factor = [NSNumber numberWithFloat:1.0];
		
		CGPoint pos = sprite.position;
		pos.x += 1.0 * [factor floatValue];
		
		// Reposition stripes when they're out of bounds
		if (pos.x > screenSize.width)
		{
			pos.x -= (screenSize.width * 2) - 2;
		}
		
		sprite.position = pos;
	}
}

+ (CGPoint)locationFromTouch:(UITouch*)touch {
    CGPoint touchLocation = [touch locationInView:[touch view]];
    return [[CCDirector sharedDirector] convertToGL:touchLocation];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint location = [SeasideScene locationFromTouch:touch];
    CCSprite *moon = (CCSprite *)[self getChildByTag:SeasideTagMoon];
    CCSprite *star0 = (CCSprite *)[starBatch getChildByTag:SeasideTagStar0];
    CCSprite *star1 = (CCSprite *)[starBatch getChildByTag:SeasideTagStar1];
    CCSprite *star2 = (CCSprite *)[starBatch getChildByTag:SeasideTagStar2];
    CCSprite *star3 = (CCSprite *)[starBatch getChildByTag:SeasideTagStar3];
    CCSprite *star4 = (CCSprite *)[starBatch getChildByTag:SeasideTagStar4];
    CCSprite *star5 = (CCSprite *)[starBatch getChildByTag:SeasideTagStar5];
    CCSprite *umbrella0 = (CCSprite *)[umBatch getChildByTag:SeasideTagUmbrella0];
    CCSprite *umbrella1 = (CCSprite *)[umBatch getChildByTag:SeasideTagUmbrella1];
    CCSprite *umbrella2 = (CCSprite *)[umBatch getChildByTag:SeasideTagUmbrella2];
    CCSprite *starfish0 = (CCSprite *)[self getChildByTag:SeasideTagStarfish0];
    CCSprite *starfish1 = (CCSprite *)[self getChildByTag:SeasideTagStarfish1];
    CCSprite *starfish2 = (CCSprite *)[self getChildByTag:SeasideTagStarfish2];
    CCSprite *shell0 = (CCSprite *)[self getChildByTag:SeasideTagShell0];
    CCSprite *shell1 = (CCSprite *)[self getChildByTag:SeasideTagShell1];
    CCSprite *shell2 = (CCSprite *)[self getChildByTag:SeasideTagShell2];
    CCSprite *shell3 = (CCSprite *)[self getChildByTag:SeasideTagShell3];
    CCSprite *sea0 = (CCSprite *)[sea0Batch getChildByTag:SeasideTagSea0];
    CCSprite *sea1 = (CCSprite *)[sea0Batch getChildByTag:SeasideTagSea1];
    CCSprite *sea2 = (CCSprite *)[sea1Batch getChildByTag:SeasideTagSea2];
    CCSprite *sea3 = (CCSprite *)[sea1Batch getChildByTag:SeasideTagSea3];
    
    NSString *titleName = nil;
    isTouchEnabled_ = CGRectContainsPoint(moon.boundingBox, location) || CGRectContainsPoint(star0.boundingBox, location) || CGRectContainsPoint(star1.boundingBox, location) || CGRectContainsPoint(star2.boundingBox, location) || CGRectContainsPoint(star3.boundingBox, location) || CGRectContainsPoint(star4.boundingBox, location) || CGRectContainsPoint(star5.boundingBox, location) || CGRectContainsPoint(umbrella0.boundingBox, location) || CGRectContainsPoint(umbrella1.boundingBox, location) || CGRectContainsPoint(umbrella2.boundingBox, location) || CGRectContainsPoint(starfish0.boundingBox, location) || CGRectContainsPoint(starfish1.boundingBox, location) || CGRectContainsPoint(starfish2.boundingBox, location) || CGRectContainsPoint(shell0.boundingBox, location) || CGRectContainsPoint(shell1.boundingBox, location) || CGRectContainsPoint(shell2.boundingBox, location) || CGRectContainsPoint(shell3.boundingBox, location) || CGRectContainsPoint(sea0.boundingBox, location) || CGRectContainsPoint(sea1.boundingBox, location) || CGRectContainsPoint(sea2.boundingBox, location) || CGRectContainsPoint(sea3.boundingBox, location);
    if (isTouchEnabled_) {
        if (CGRectContainsPoint(star0.boundingBox, location)) {
            titleName = @"star";
            [star0 runAction:[self getSequenceBiSmallByScale:1.0]];
            [_navBar playSoundByNameEn:SOUND_STAR_EN Cn:SOUND_STAR_CN Jp:SOUND_STAR_JP];

        } else if (CGRectContainsPoint(star1.boundingBox, location)) {
            titleName = @"star";
            [star1 runAction:[self getSequenceBiSmallByScale:0.7]];
            [_navBar playSoundByNameEn:SOUND_STAR_EN Cn:SOUND_STAR_CN Jp:SOUND_STAR_JP];
        } else if (CGRectContainsPoint(star2.boundingBox, location)) {
            titleName = @"star";
            [star2 runAction:[self getSequenceBiSmallByScale:0.6]];
            [_navBar playSoundByNameEn:SOUND_STAR_EN Cn:SOUND_STAR_CN Jp:SOUND_STAR_JP];
        } else if (CGRectContainsPoint(star3.boundingBox, location)) {
            titleName = @"star";
            [star3 runAction:[self getSequenceBiSmallByScale:0.8]];
            [_navBar playSoundByNameEn:SOUND_STAR_EN Cn:SOUND_STAR_CN Jp:SOUND_STAR_JP];
        } else if (CGRectContainsPoint(star4.boundingBox, location)) {
            titleName = @"star";
            [star4 runAction:[self getSequenceBiSmallByScale:0.7]];
            [_navBar playSoundByNameEn:SOUND_STAR_EN Cn:SOUND_STAR_CN Jp:SOUND_STAR_JP];
        } else if (CGRectContainsPoint(star5.boundingBox, location)) {
            titleName = @"star";
            [star5 runAction:[self getSequenceBiSmallByScale:0.9]];
            [_navBar playSoundByNameEn:SOUND_STAR_EN Cn:SOUND_STAR_CN Jp:SOUND_STAR_JP];
        } else if (CGRectContainsPoint(umbrella0.boundingBox, location)) {
            titleName = @"umbrella";
            [umbrella0 runAction:[self getSequenceBiSmallByScale:0.7]];
            [_navBar playSoundByNameEn:SOUND_UMBRELLA_EN Cn:SOUND_UMBRELLA_CN Jp:SOUND_UMBRELLA_JP];
        } else if (CGRectContainsPoint(umbrella1.boundingBox, location)) {
            titleName = @"umbrella";
            [umbrella1 runAction:[self getSequenceBiSmallByScale:0.6]];
            [_navBar playSoundByNameEn:SOUND_UMBRELLA_EN Cn:SOUND_UMBRELLA_CN Jp:SOUND_UMBRELLA_JP];
        } else if (CGRectContainsPoint(umbrella2.boundingBox, location)) {
            titleName = @"umbrella";
            [umbrella2 runAction:[self getSequenceBiSmallByScale:0.9]];
            [_navBar playSoundByNameEn:SOUND_UMBRELLA_EN Cn:SOUND_UMBRELLA_CN Jp:SOUND_UMBRELLA_JP];
        } else if (CGRectContainsPoint(starfish0.boundingBox, location)) {
            titleName = @"starfish";
            [starfish0 runAction:[self getSequenceBigSmall]];
            [_navBar playSoundByNameEn:SOUND_STARFISH_EN Cn:SOUND_STARFISH_CN Jp:SOUND_STARFISH_JP];
        } else if (CGRectContainsPoint(starfish1.boundingBox, location)) {
            titleName = @"starfish";
            [starfish1 runAction:[self getSequenceBigSmall]];
            [_navBar playSoundByNameEn:SOUND_STARFISH_EN Cn:SOUND_STARFISH_CN Jp:SOUND_STARFISH_JP];
        } else if (CGRectContainsPoint(starfish2.boundingBox, location)) {
            titleName = @"starfish";
            [starfish2 runAction:[self getSequenceBigSmall]];
            [_navBar playSoundByNameEn:SOUND_STARFISH_EN Cn:SOUND_STARFISH_CN Jp:SOUND_STARFISH_JP];
        } else if (CGRectContainsPoint(shell0.boundingBox, location)) {
            titleName = @"seashell";
            [shell0 runAction:[self getSequenceBigSmall]];
            [_navBar playSoundByNameEn:SOUND_SEASHELL_EN Cn:SOUND_SEASHELL_CN Jp:SOUND_SEASHELL_JP];
        } else if (CGRectContainsPoint(shell1.boundingBox, location)) {
            titleName = @"seashell";
            [shell1 runAction:[self getSequenceBigSmall]];
            [_navBar playSoundByNameEn:SOUND_SEASHELL_EN Cn:SOUND_SEASHELL_CN Jp:SOUND_SEASHELL_JP];
        } else if (CGRectContainsPoint(shell2.boundingBox, location)) {
            titleName = @"seashell";
            [shell2 runAction:[self getSequenceBigSmall]];
            [_navBar playSoundByNameEn:SOUND_SEASHELL_EN Cn:SOUND_SEASHELL_CN Jp:SOUND_SEASHELL_JP];
        } else if (CGRectContainsPoint(shell3.boundingBox, location)) {
            titleName = @"seashell";
            [shell3 runAction:[self getSequenceBigSmall]];
            [_navBar playSoundByNameEn:SOUND_SEASHELL_EN Cn:SOUND_SEASHELL_CN Jp:SOUND_SEASHELL_JP];
        } else if (CGRectContainsPoint(sea0.boundingBox, location) || CGRectContainsPoint(sea1.boundingBox, location) || CGRectContainsPoint(sea2.boundingBox, location) || CGRectContainsPoint(sea3.boundingBox, location)) {
            titleName = @"sea";
            [_navBar playSoundByNameEn:SOUND_SEA_EN Cn:SOUND_SEA_CN Jp:SOUND_SEA_JP];
        } else {
            titleName = @"moon";
            [moon runAction:[self getSequenceBigSmall]];
            [_navBar playSoundByNameEn:SOUND_MOON_EN Cn:SOUND_MOON_CN Jp:SOUND_MOON_JP];
        }
        
        [_navBar setTitleLabelWithString:NSLocalizedStringFromTable(titleName, [ZZNavBar getStringEnCnJp], nil)];
    
    }
    
    return isTouchEnabled_;
}

- (void)preloadEffects {
    
    [[SimpleAudioEngine sharedEngine] preloadEffect:EFFECT_FIREWORK_01];
    [[SimpleAudioEngine sharedEngine] preloadEffect:EFFECT_FIREWORK_02];
    
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_FIREWORKS_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_MOON_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_SEA_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_SEASHELL_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_STAR_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_STARFISH_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_UMBRELLA_EN];
    
    switch ([ZZNavBar getNumberEnCnJp]) {
        case 2:
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_FIREWORKS_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_MOON_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_SEA_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_SEASHELL_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_STAR_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_STARFISH_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_UMBRELLA_CN];
            break;
            
        case 3:
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_FIREWORKS_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_MOON_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_SEA_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_SEASHELL_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_STAR_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_STARFISH_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_UMBRELLA_JP];
            break;
            
        default:
            break;
    }
}

- (void)unloadEffects {
    
    [[SimpleAudioEngine sharedEngine] unloadEffect:EFFECT_FIREWORK_01];
    [[SimpleAudioEngine sharedEngine] unloadEffect:EFFECT_FIREWORK_02];
    
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_FIREWORKS_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_MOON_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_SEA_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_SEASHELL_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_STAR_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_STARFISH_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_UMBRELLA_EN];
    
    switch ([ZZNavBar getNumberEnCnJp]) {
        case 2:
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_FIREWORKS_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_MOON_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_SEA_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_SEASHELL_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_STAR_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_STARFISH_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_UMBRELLA_CN];
            break;
            
        case 3:
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_FIREWORKS_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_MOON_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_SEA_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_SEASHELL_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_STAR_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_STARFISH_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_UMBRELLA_JP];
            break;
            
        default:
            break;
    }
}

- (CCSequence *)getSequenceBigSmall {
    return [CCSequence actions:[CCScaleTo actionWithDuration:0.1 scale:1.1], [CCScaleTo actionWithDuration:0.1 scale:1.0], nil];
}

- (CCSequence *)getSequenceBiSmallByScale:(CGFloat)scale {
    return [CCSequence actions:[CCScaleBy actionWithDuration:0.1 scale:1.1], [CCScaleTo actionWithDuration:0.1 scale:scale], nil];
}

- (void)onExitTransitionDidStart {
    [[CCTouchDispatcher sharedDispatcher] removeAllDelegates];
}

@end
