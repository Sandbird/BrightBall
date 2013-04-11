//
//  Egg.m
//  Brazil
//
//  Created by zhaozilong on 12-12-4.
//
//

#import "Egg.h"

@implementation Egg

- (void)dealloc {
    
    CCLOG(@"egg dealloc");
    
    [super dealloc];
}

+ (id)eggWithParentNode:(CCNode *)parentNode eggPos:(CGPoint)eggPos animalPos:(CGPoint)animalPos shellPos:(CGPoint)shellPos prefix:(NSString *)eggSuffix  {
    return [[[self alloc] initWithParentNode:parentNode eggPos:eggPos animalPos:animalPos shellPos:shellPos prefix:eggSuffix] autorelease];
}

- (id)initWithParentNode:(CCNode *)parentNode eggPos:(CGPoint)eggPos animalPos:(CGPoint)animalPos shellPos:(CGPoint)shellPos prefix:(NSString *)eggSuffix {
    if (self = [super init]) {
        
        //打开动画锁
        isAnimLocked = NO;
        
        //touch is enabled
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:-1 swallowsTouches:YES];
        
        //screen size
        //        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        //Reset tapCount
        tapCount = 0;
        
        //鸡蛋前缀
        suffix = eggSuffix;
        
        //effect
        audioEngine = [SimpleAudioEngine sharedEngine];
        
        
        //initialize egg sprite
        frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        
        //蛋壳背后
        frame = [frameCache spriteFrameByName:[NSString stringWithFormat:@"egg%@5.png", suffix]];
        shellSprite = [CCSprite spriteWithSpriteFrame:frame];
        [parentNode addChild:shellSprite];
        shellSprite.position = shellPos;
        shellSprite.visible = NO;
        
        //蛋壳里的动物
        frame = [frameCache spriteFrameByName:[NSString stringWithFormat:@"egg%@6.png", suffix]];
        animalSprite = [CCSprite spriteWithSpriteFrame:frame];
        [parentNode addChild:animalSprite];
        animalSprite.position = animalPos;
        animalSprite.visible = NO;
        
        //蛋壳前
        frame = [frameCache spriteFrameByName:[NSString stringWithFormat:@"egg%@0.png", suffix]];
        eggSprite = [CCSprite spriteWithSpriteFrame:frame];
        [parentNode addChild:eggSprite];
        eggSprite.position = eggPos;
        
    }
    
    return self;
}

- (void)setAnimateBySuffix:(NSString *)str {
    
    frame = [frameCache spriteFrameByName:[NSString stringWithFormat:@"egg%@7.png", suffix]];
    [animalSprite setDisplayFrame:frame];
    
    CCCallBlock *openLock = [CCCallBlock actionWithBlock:^{
        isAnimLocked = NO;
        
        frame = [frameCache spriteFrameByName:[NSString stringWithFormat:@"egg%@6.png", suffix]];
        [animalSprite setDisplayFrame:frame];
    }];
    
    
    CCAnimation *animation;
    CCRepeat *repeat;
    CCSequence *anim;
    CCMoveTo *start = [CCMoveTo actionWithDuration:0.35 position:ccp(animalSprite.position.x, animalSprite.position.y + 30)];
    CCMoveTo *end = [CCMoveTo actionWithDuration:0.3 position:ccp(animalSprite.position.x, animalSprite.position.y)];
    CCRepeat *upDownRepeat = [CCRepeat actionWithAction:[CCSequence actionOne:start two:end] times:2];
    CCSpawn *togetherRepeat;
    
    if ([str isEqualToString:@"A"]) {
        animation = [self animationWithSuffix:@"A"];
    } else if ([str isEqualToString:@"B"]) {
        animation = [self animationWithSuffix:@"B"];
    } else if ([str isEqualToString:@"C"]) {
        animation = [self animationWithSuffix:@"C"];
    } else if ([str isEqualToString:@"D"]) {
        animation = [self animationWithSuffix:@"D"];
    } else {
        animation = [self animationWithSuffix:@"E"];
    }
    repeat = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:animation] times:2];
    togetherRepeat = [CCSpawn actionOne:repeat two:upDownRepeat];
    anim = [CCSequence actions:togetherRepeat, openLock, nil];
    [animalSprite runAction:anim];
}

// Creates an animation from sprite frames.
-(CCAnimation*) animationWithSuffix:(NSString*)str
{
	// load the ship's animation frames as textures and create a sprite frame
	NSMutableArray* frames = [NSMutableArray arrayWithCapacity:2];
    
    frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    frame = [frameCache spriteFrameByName:[NSString stringWithFormat:@"egg%@6.png", str]];
    [frames addObject:frame];
    frame = [frameCache spriteFrameByName:[NSString stringWithFormat:@"egg%@7.png", str]];
    [frames addObject:frame];
    
	// return an animation object from all the sprite animation frames
    //	return [CCAnimation animationWithName:frame delay:delay frames:frames];
    return [CCAnimation animationWithFrames:frames delay:0.29];
}

- (void)setEggStatusByTapCount:(int)count {
    if (count > 0 && count < 3) {
        //第1道裂纹
        frame = [frameCache spriteFrameByName:[NSString stringWithFormat:@"egg%@1.png", suffix]];
        [eggSprite setDisplayFrame:frame];
        
        //播放敲蛋声音
        [[SimpleAudioEngine sharedEngine] playEffect:@"egg-0.caf"];
    } else if (count > 2 && count < 6) {
        //第2道裂纹
        frame = [frameCache spriteFrameByName:[NSString stringWithFormat:@"egg%@2.png", suffix]];
        [eggSprite setDisplayFrame:frame];
        
        //播放敲蛋声音
        [[SimpleAudioEngine sharedEngine] playEffect:@"egg-0.caf"];
    } else if (count > 5 && count < 9) {
        //第3道裂纹
        frame = [frameCache spriteFrameByName:[NSString stringWithFormat:@"egg%@3.png", suffix]];
        [eggSprite setDisplayFrame:frame];
        
        //播放敲蛋声音
        [[SimpleAudioEngine sharedEngine] playEffect:@"egg-0.caf"];
    } else if (count == 9) {
        //小鸡孵化，动画，蛋壳脱落
        frame = [frameCache spriteFrameByName:[NSString stringWithFormat:@"egg%@4.png", suffix]];
        [eggSprite setDisplayFrame:frame];
        
        shellSprite.visible = YES;
        animalSprite.visible = YES;
        
        //小鸡
        frame = [frameCache spriteFrameByName:[NSString stringWithFormat:@"egg%@6.png", suffix]];
        [animalSprite setDisplayFrame:frame];
        
        CCCallBlock *eggBreakSound = [CCCallBlock actionWithBlock:^{
            [[SimpleAudioEngine sharedEngine] playEffect:@"egg-1.caf"];
        }];
        
        CCCallBlock *animalSound = [CCCallBlock actionWithBlock:^{
            [self sayWhichAnimalByEggSuffix:suffix];
        }];
        //播放敲蛋声音
        [eggSprite runAction:[CCSequence actions:eggBreakSound, [CCDelayTime actionWithDuration:0.6], animalSound, nil]];
    } else {
        
        
        if (isAnimLocked == NO) {
            
            isAnimLocked = YES;
            
            //播放动画
            [self setAnimateBySuffix:suffix];
            
            //播放声音
            [self sayAnimalNameByEggSuffix:suffix];
            
        }
        
    }
}

- (void)sayWhichAnimalByEggSuffix:(NSString *)eggSuffix {
    if ([eggSuffix isEqualToString:@"A"]) {
        [audioEngine playEffect:EFFECT_DINOSAUR_0];
    } else if ([eggSuffix isEqualToString:@"B"]) {
        [audioEngine playEffect:EFFECT_GOOSE_0];
    } else if ([eggSuffix isEqualToString:@"C"]) {
        [audioEngine playEffect:EFFECT_PENGUIN_0];
    } else if ([eggSuffix isEqualToString:@"D"]) {
        [audioEngine playEffect:EFFECT_DUCK_0];
    } else if ([eggSuffix isEqualToString:@"E"]) {
        [audioEngine playEffect:EFFECT_CHICKEN_0];
    } else {
        NSAssert(0, @"没有正确的动物");
    }
}

- (void)sayAnimalNameByEggSuffix:(NSString *)eggSuffix {
    
    BOOL isEn = [[[EggsScene sharedEggsScene] navBar] isEnglish];
    if ([eggSuffix isEqualToString:@"A"]) {
        [[[EggsScene sharedEggsScene] navBar] setTitleLabelWithString:NSLocalizedStringFromTable(@"dinosaur", [ZZNavBar getStringEnCnJp], nil)];
        if (isEn) {
            [audioEngine playEffect:SOUND_DINOSAUR_EN];
        } else {
            if ([ZZNavBar getNumberEnCnJp] == 2) {
                [audioEngine playEffect:SOUND_DINOSAUR_CN];
            } else {
                [audioEngine playEffect:SOUND_DINOSAUR_JP];
            }
            
        }
        
    } else if ([eggSuffix isEqualToString:@"B"]) {
        [[[EggsScene sharedEggsScene] navBar] setTitleLabelWithString:NSLocalizedStringFromTable(@"goose", [ZZNavBar getStringEnCnJp], nil)];
        if (isEn) {
            [audioEngine playEffect:SOUND_GOOSE_EN];
        } else {
            if ([ZZNavBar getNumberEnCnJp] == 2) {
                [audioEngine playEffect:SOUND_GOOSE_CN];
            } else {
                [audioEngine playEffect:SOUND_GOOSE_JP];
            }
            
        }
    } else if ([eggSuffix isEqualToString:@"C"]) {
        [[[EggsScene sharedEggsScene] navBar] setTitleLabelWithString:NSLocalizedStringFromTable(@"penguin", [ZZNavBar getStringEnCnJp], nil)];
        if (isEn) {
            [audioEngine playEffect:SOUND_PENGUIN_EN];
        } else {
            if ([ZZNavBar getNumberEnCnJp] == 2) {
                [audioEngine playEffect:SOUND_PENGUIN_CN];
            } else {
                [audioEngine playEffect:SOUND_PENGUIN_JP];
            }
            
        }
    } else if ([eggSuffix isEqualToString:@"D"]) {
        [[[EggsScene sharedEggsScene] navBar] setTitleLabelWithString:NSLocalizedStringFromTable(@"duck", [ZZNavBar getStringEnCnJp], nil)];
        if (isEn) {
            [audioEngine playEffect:SOUND_DUCK_EN];
        } else {
            if ([ZZNavBar getNumberEnCnJp] == 2) {
                [audioEngine playEffect:SOUND_DUCK_CN];
            } else {
                [audioEngine playEffect:SOUND_DUCK_JP];
            }
            
        }
    } else if ([eggSuffix isEqualToString:@"E"]) {
        [[[EggsScene sharedEggsScene] navBar] setTitleLabelWithString:NSLocalizedStringFromTable(@"chicken", [ZZNavBar getStringEnCnJp], nil)];
        if (isEn) {
            [audioEngine playEffect:SOUND_CHICKEN_EN];
        } else {
            if ([ZZNavBar getNumberEnCnJp] == 2) {
                [audioEngine playEffect:SOUND_CHICKEN_CN];
            } else {
                [audioEngine playEffect:SOUND_CHICKEN_JP];
            }
            
        }
    } else {
        NSAssert(0, @"没有正确的动物");
    }
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    lastTouchLocation = [EggsScene locationFromTouch:touch];
    isTouchHandled = CGRectContainsPoint([eggSprite boundingBox], lastTouchLocation);
    
    if (isTouchHandled) {
        [self setEggStatusByTapCount:++tapCount];
        
        [eggSprite runAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1 scale:1.1], [CCScaleTo actionWithDuration:0.1 scale:1.0], nil]];
        
        [shellSprite runAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1 scale:1.1], [CCScaleTo actionWithDuration:0.1 scale:1.0], nil]];
    }
    
    return isTouchHandled;
}

@end
