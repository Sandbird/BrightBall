//
//  Boy.m
//  Brazil
//
//  Created by zhaozilong on 12-10-30.
//
//

#import "Boy.h"


@implementation Boy

#define TALK_TAG 1234

//@synthesize delegate = _delegate;
@synthesize isTouchHandled = _isTouchHandled;
@synthesize isSpeakAnimLocked = _isSpeakAnimLocked;

BOOL BoyIsAnimLocked;

- (void)dealloc {
    
    //    [_delegate release], _delegate = nil;
    
    CCLOG(@"Boy dealloc");
    
    [Boy unloadEffectMusic];
    
    [[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
    
    [super dealloc];
}

+ (id)boyWithParentNode:(CCNode *)parentNode {
    return [[[self alloc] initWithParentNode:parentNode] autorelease];
}

- (id)initWithParentNode:(CCNode *)parentNode {
    
    if (self = [super init]) {
        //说话动画锁
        _isSpeakAnimLocked = NO;
        
        BoyIsAnimLocked = NO;
        
        //获取屏幕大小
        screenSize = [[CCDirector sharedDirector] winSize];
        
        //touch is enabled
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:-1 swallowsTouches:YES];
        
        //帧缓存
        frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        
        CGPoint point, talkPoint;
        CGFloat fontSize;
        if ([ZZNavBar isiPad]) {
            point = ccp(screenSize.width / 3, screenSize.height * 2 / 13);
            talkPoint = ccp(screenSize.width * 9 / 17, screenSize.height * 7 / 11);
            if ([ZZNavBar getNumberEnCnJp] == 3) {
                fontSize = 36;
            } else {
                fontSize = 44;
            }
            
        } else {
            point = ccp(screenSize.width / 4, screenSize.height / 9);
            talkPoint = ccp(screenSize.width * 9 / 17, screenSize.height * 3 / 5);
            if ([ZZNavBar getNumberEnCnJp] == 3) {
                fontSize = 18;
            } else {
                fontSize = 22;
            }
        }
        
        //创建boy精灵
        frame = [frameCache spriteFrameByName:PNG_HEAD_NORMAL];
        headSprite = [CCSprite spriteWithSpriteFrame:frame];
        headSprite.anchorPoint = ccp(0, 0);//CGPointMake(0, 1);
        headSprite.position = point;
        
        frame = [frameCache spriteFrameByName:PNG_BODY_NORMAL];
        bodySprite = [CCSprite spriteWithSpriteFrame:frame];
        bodySprite.anchorPoint = ccp(0, 0);
        bodySprite.position = point;
        
        frame = [frameCache spriteFrameByName:PNG_BODY_SHIT];
        shitSprite = [CCSprite spriteWithSpriteFrame:frame];
        shitSprite.anchorPoint = ccp(0, 0);
        shitSprite.position = point;
        shitSprite.visible = NO;
        
        //创建对话框
        frame = [frameCache spriteFrameByName:PNG_HEAD_TALK];
        talkSprite = [CCSprite spriteWithSpriteFrame:frame];
        talkSprite.anchorPoint = ccp(0, 0);
        talkSprite.position = talkPoint;
        CCLabelTTF *talkLabel = [CCLabelTTF labelWithString:@"" dimensions:talkSprite.boundingBox.size alignment:NSTextAlignmentCenter fontName:@"MarkerFelt-Thin" fontSize:fontSize];
        talkLabel.color = ccBLACK;
        talkLabel.anchorPoint = ccp(0, 0);
        
        if ([ZZNavBar getNumberEnCnJp] == 1) {
            talkLabel.position = ccp(0, -5);
        } else {
            talkLabel.position = ccp(0, -15);
        }
        
        [talkSprite addChild:talkLabel z:0 tag:TALK_TAG];
        
        [parentNode addChild:headSprite z:1];
        [parentNode addChild:shitSprite z:0];
        [parentNode addChild:bodySprite z:0];
        [parentNode addChild:talkSprite z:0];
        
        //初始化已经吃的水果个数
        fruitCount = 0;
        
        [Boy loadEffectMusic];
        //set boy's favor
        fruitTag = 0;
        [self setCurrentFruitFavor];
        sound = 0;
        [self sayLikeFruit];
        
    }
    
    return self;
}

- (CGRect)getBoyHeadSpriteRect {
    
    CGRect rect;
    
    if ([ZZNavBar isiPad]) {
        rect.origin = CGPointMake(380, 470);
        rect.size = CGSizeMake(180, 50);
    } else {
        rect.origin = CGPointMake(143, 205);
        rect.size = CGSizeMake(90, 30);
    }
    
    return rect;
}

- (void)setCurrentFruitFavor {
    int newTag = 0;
    do {
//        fruitTag = arc4random() % 7 + 10;
        newTag = arc4random() % 7 + 10;
    } while (newTag == fruitTag);
    
    fruitTag = newTag;
}

- (void)sayLikeFruit {
    //吃东西的动画
    _isSpeakAnimLocked = YES;
    
    CCCallBlock *openLock = [CCCallBlock actionWithBlock:^{
        _isSpeakAnimLocked = NO;
    }];
    CCAnimation *speak = [CCAnimation animationWithFrame:@"speak" frameCount:2 delay:0.2];
    CCRepeat *speakRepeat = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:speak] times:5];
    [headSprite runAction:[CCSequence actionOne:speakRepeat two:openLock]];
    
    [[SimpleAudioEngine sharedEngine] stopEffect:sound];
    
    //得到label
    CCLabelTTF *talkLabel = (CCLabelTTF *)[talkSprite getChildByTag:TALK_TAG];
    
    NSString *name = nil;
    NSString *titleStr = nil;
    BOOL isEn = [[[EatFuritsScene sharedEatFurits] navBar] isEnglish];
    switch (fruitTag) {
        case FruitAppleTag:
            CCLOG(@"我想吃Apple");
            
            if (isEn == NO) {
                if ([ZZNavBar getNumberEnCnJp] == 2) {
                    name = SOUND_EAT_APPLE_CN;
                } else {
                    name = SOUND_EAT_APPLE_JP;
                }
            
            } else {
                name = SOUND_EAT_APPLE_EN;
            }
            titleStr = NSLocalizedStringFromTable(@"eatApple", [ZZNavBar getStringEnCnJp], nil);
            break;
            
        case FruitGrapeTag:
            CCLOG(@"我想吃Grape");
            
            if (isEn == NO) {
                
                if ([ZZNavBar getNumberEnCnJp] == 2) {
                    name = SOUND_EAT_GRAPE_CN;
                } else {
                    name = SOUND_EAT_GRAPE_JP;
                }
            } else {
                name = SOUND_EAT_GRAPE_EN;
            }
            titleStr = NSLocalizedStringFromTable(@"eatGrape", [ZZNavBar getStringEnCnJp], nil);
            break;
            
        case FruitBananaTag:
            CCLOG(@"我想吃Banana");
            
            if (isEn == NO) {
                
                if ([ZZNavBar getNumberEnCnJp] == 2) {
                    name = SOUND_EAT_BANANA_CN;
                } else {
                    name = SOUND_EAT_BANANA_JP;
                }
            } else {
                name = SOUND_EAT_BANANA_EN;
            }
            titleStr = NSLocalizedStringFromTable(@"eatBanana", [ZZNavBar getStringEnCnJp], nil);
            break;
            
        case FruitCherryTag:
            CCLOG(@"我想吃Cherry");
            
            if (isEn == NO) {
                
                if ([ZZNavBar getNumberEnCnJp] == 2) {
                    name = SOUND_EAT_CHERRY_CN;
                } else {
                    name = SOUND_EAT_CHERRY_JP;
                }
            } else {
                name = SOUND_EAT_CHERRY_EN;
            }
            titleStr = NSLocalizedStringFromTable(@"eatCherry", [ZZNavBar getStringEnCnJp], nil);
            break;
            
        case FruitOrangeTag:
            CCLOG(@"我想吃Orange");
            
            if (isEn == NO) {
                
                if ([ZZNavBar getNumberEnCnJp] == 2) {
                    name = SOUND_EAT_ORANGE_CN;
                } else {
                    name = SOUND_EAT_ORANGE_JP;
                }
            } else {
                name = SOUND_EAT_ORANGE_EN;
            }
            titleStr = NSLocalizedStringFromTable(@"eatOrange", [ZZNavBar getStringEnCnJp], nil);
            break;
            
        case FruitWatermelonTag:
            CCLOG(@"我想吃Watermelon");
            
            if (isEn == NO) {
                
                if ([ZZNavBar getNumberEnCnJp] == 2) {
                    name = SOUND_EAT_WATERMELON_CN;
                } else {
                    name = SOUND_EAT_WATERMELON_JP;
                }
            } else {
                name = SOUND_EAT_WATERMELON_EN;
            }
            titleStr = NSLocalizedStringFromTable(@"eatWatermelon", [ZZNavBar getStringEnCnJp], nil);
            break;
            
        case FruitDurianTag:
            CCLOG(@"我想吃Durian");
            
            if (isEn == NO) {
                
                if ([ZZNavBar getNumberEnCnJp] == 2) {
                    name = SOUND_EAT_DURIAN_CN;
                } else {
                    name = SOUND_EAT_DURIAN_JP;
                }
            } else {
                name = SOUND_EAT_DURIAN_EN;
            }
            titleStr = NSLocalizedStringFromTable(@"eatDurian", [ZZNavBar getStringEnCnJp], nil);
            break;
            
        default:
            CCLOG(@"ERROR，我啥也不想吃。%d", fruitTag);
            break;
    }
    [talkLabel setString:titleStr];
    sound = [[SimpleAudioEngine sharedEngine] playEffect:name];
    
    
}

- (NSString *)getCurrentFruitName {
    switch (fruitTag) {
        case FruitAppleTag:
            return @"Apple";
            break;
            
        case FruitGrapeTag:
            return @"Grape";
            break;
            
        case FruitBananaTag:
            return @"Banana";
            break;
            
        case FruitCherryTag:
            return @"Cherry";
            break;
            
        case FruitOrangeTag:
            return @"Orange";
            break;
            
        case FruitWatermelonTag:
            return @"Watermelon";
            break;
            
        case FruitDurianTag:
            return @"Durian";
            break;
            
        default:
            CCLOG(@"ERROR, 错误的水果名称。%d", fruitTag);
            return @"ERROR";
            break;
    }
    
}

#pragma mark -
#pragma mark SetAction
#if 1
- (void)boySetActionByActionTag:(int)boyTagActions fruitTag:(int)boyTagFruit {
    switch (boyTagActions) {
        case HeadNormalTagAction:
            frame = [frameCache spriteFrameByName:PNG_HEAD_NORMAL];
            [headSprite setDisplayFrame:frame];
            break;
            
        case HeadOpenMouthTagAction:
            frame = [frameCache spriteFrameByName:PNG_HEAD_OPEN_MOUTH];
            [headSprite setDisplayFrame:frame];
            break;
            
        case HeadEatTagAction:
            //            frame = [frameCache spriteFrameByName:PNG_HEAD_EAT];
            //            [headSprite setDisplayFrame:frame];
            [self headAnimationEatWithFruitTag:boyTagFruit];
            break;
            
        case HeadRightTagAction:
            frame = [frameCache spriteFrameByName:PNG_HEAD_RIGHT];
            [headSprite setDisplayFrame:frame];
            break;
            
        case HeadWrongTagAction:
            frame = [frameCache spriteFrameByName:PNG_HEAD_WRONG];
            [headSprite setDisplayFrame:frame];
            break;
            
        case BodyNormalTgAction:
            frame = [frameCache spriteFrameByName:PNG_BODY_NORMAL];
            [bodySprite setDisplayFrame:frame];
            break;
            
        case BodyBig0TagAction:
            frame = [frameCache spriteFrameByName:PNG_BODY_BIG_0];
            [bodySprite setDisplayFrame:frame];
            break;
            
        case BodyBig1TagAction:
            frame = [frameCache spriteFrameByName:PNG_BODY_BIG_1];
            [bodySprite setDisplayFrame:frame];
            break;
            
        case BodyBig2TagAction:
            frame = [frameCache spriteFrameByName:PNG_BODY_BIG_2];
            [bodySprite setDisplayFrame:frame];
            break;
            
        case BodyBig3TagAction:
            frame = [frameCache spriteFrameByName:PNG_BODY_BIG_3];
            [bodySprite setDisplayFrame:frame];
            break;
            
        case BodyShitTagAction:
            frame = [frameCache spriteFrameByName:PNG_BODY_SHIT];
            [bodySprite setDisplayFrame:frame];
            break;
            
        default:
            CCLOGERROR(@"Boy gets wrong actionTag.%d", boyTagActions);
            break;
    }
    
    
}
#endif

- (void)headAnimationEatWithFruitTag:(int)boyTagFruit {
    
    //锁上动画锁
    BoyIsAnimLocked = YES;
    
    //吃的水果数+1
    fruitCount ++;
    
    //播放动画
    switch (fruitCount) {
        case 1:
            [self boyAnimationPlayWithFruitTag:boyTagFruit bodyTag:BodyBig0TagAction];
            break;
            
        case 2:
            [self boyAnimationPlayWithFruitTag:boyTagFruit bodyTag:BodyBig1TagAction];
            break;
            
        case 3:
            [self boyAnimationPlayWithFruitTag:boyTagFruit bodyTag:BodyBig2TagAction];
            break;
            
        case 4:
            [self boyAnimationPlayWithFruitTag:boyTagFruit bodyTag:BodyBig3TagAction];
            break;
            
        case 5:
            [self boyUtimateAnimationPlayWithFruitTag:boyTagFruit bodyTag:BodyNormalTgAction];
            CCLOG(@"shit");
            
            //拉屎之后肚子变小
            fruitCount = 0;
            break;
            
        default:
            CCLOG(@"ERROR,肚子没有正确的动作输入");
            break;
    }
}

- (void)boyAnimationPlayWithFruitTag:(int)boyTagFruit bodyTag:(int)boyTagBody {
    
    //吃东西的动画
    CCAnimate *eatAct = [CCAnimate actionWithAnimation:[CCAnimation animationWithFrame:ANIM_HEAD_EAT frameCount:2 delay:0.2]];
    CCRepeat *eatRepeat = [CCRepeat actionWithAction:eatAct times:3];
    
    //吃对了的表情
    CCAnimate *rightAct = [CCAnimate actionWithAnimation:[CCAnimation animationWithFrame:@"headRight" frameCount:1 delay:1]];
    
    //吃错了的表情
    CCAnimate *wrongAct = [CCAnimate actionWithAnimation:[CCAnimation animationWithFrame:@"headWrong" frameCount:1 delay:1]];
    
    //吃完之后打开动画锁
    id openLock = [CCCallFunc actionWithTarget:self selector:@selector(openAnimationLock)];
    
    //播放吃东西的音效
    [Boy playEffectMusic];
    
    CCCallBlock *eatEffect = [CCCallBlock actionWithBlock:^{
        [self sayLikeFruit];
    }];
    
    //    CCDelayTime *delay = [CCDelayTime actionWithDuration:0.1];
    
    //之后判断是否吃的是想吃的水果，如果是则随机生成另一个想吃的水果，如果不是则还是想吃这个水果。
    NSString *fruitName = nil;
    if (fruitTag == boyTagFruit) {
        
        //播放音效，你真棒，什么什么真好吃
        fruitName = [self getCurrentFruitName];
        CCLOG(@"答对了，你真棒");
        
        CCCallBlock *eatRight = [CCCallBlock actionWithBlock:^{
            [[SimpleAudioEngine sharedEngine] playEffect:EFFECT_EAT_RIGHT];
        }];
        
        //播放吃对了的动画
        [headSprite runAction:[CCSequence actions:eatRepeat, eatRight, rightAct, eatEffect, openLock, nil]];
        
        //再次设置随机水果
        [self setCurrentFruitFavor];
        
    } else {
        
        CCCallBlock *eatWrong = [CCCallBlock actionWithBlock:^{
            [[SimpleAudioEngine sharedEngine] playEffect:EFFECT_EAT_WRONG];
        }];
        
        //播放吃错了的动画
        [headSprite runAction:[CCSequence actions:eatRepeat, eatWrong, wrongAct, eatEffect, openLock, nil]];
        
        //播放音效，什么什么虽然很好吃。但是。。。
        CCLOG(@"虽然很好吃，但是");
    }
    
    //肚子变化
    [self boySetActionByActionTag:boyTagBody fruitTag:0];
    
}

- (void)boyUtimateAnimationPlayWithFruitTag:(int)boyTagFruit bodyTag:(int)boyTagBody {
    
    //吃东西的动画
    CCAnimate *eatAct = [CCAnimate actionWithAnimation:[CCAnimation animationWithFrame:ANIM_HEAD_EAT frameCount:2 delay:0.2]];
    CCRepeat *eatRepeat = [CCRepeat actionWithAction:eatAct times:3];
    
    //拉屎ing表情动画
    CCAnimate *headShitingAct = [CCAnimate actionWithAnimation:[CCAnimation animationWithSingleFrame:@"headShit0" delay:1]];
    
    //拉完屎害羞的表情
    CCAnimate *headShitAfterAct = [CCAnimate actionWithAnimation:[CCAnimation animationWithSingleFrame:@"headShit1" delay:2]];
    
    //肚子小了
    CCCallFunc *bodyNormalAct = [CCCallFunc actionWithTarget:self selector:@selector(bodyAnimationBodyNormal)];
    
    //吃完之后打开动画锁
    id openLock = [CCCallFunc actionWithTarget:self selector:@selector(openAnimationLock)];
    
    CCCallBlock *eatEffect = [CCCallBlock actionWithBlock:^{
        [self sayLikeFruit];
    }];
    
    //播放吃东西的音效
    [Boy playEffectMusic];
    
    CCCallBlock *shiting = [CCCallBlock actionWithBlock:^{
        [[SimpleAudioEngine sharedEngine] playEffect:EFFECT_SHIT_0];
    }];
    
    //    CCCallBlock *shitAfter = [CCCallBlock actionWithBlock:^{
    //        [[SimpleAudioEngine sharedEngine] playEffect:EFFECT_SHIT_2];
    //    }];
    //之后判断是否吃的是想吃的水果，如果是则随机生成另一个想吃的水果，如果不是则还是想吃这个水果。
    NSString *fruitName = nil;
    if (fruitTag == boyTagFruit) {
        
        //播放音效，你真棒，什么什么真好吃
        fruitName = [self getCurrentFruitName];
        CCLOG(@"你真棒，%@真好吃", fruitName);
        
        
        
        //播放吃对了的动画
        [headSprite runAction:[CCSequence actions:eatRepeat, shiting, headShitingAct, bodyNormalAct, /*shitAfter, */headShitAfterAct, eatEffect, /*rightAct, */openLock, nil]];
        
        //再次设置随机水果
        [self setCurrentFruitFavor];
        
    } else {
        
        //        CCCallBlock *eatWrong = [CCCallBlock actionWithBlock:^{
        //            [[SimpleAudioEngine sharedEngine] playEffect:EFFECT_EAT_WRONG];
        //        }];
        
        //播放吃错了的动画
        [headSprite runAction:[CCSequence actions:eatRepeat, shiting, headShitingAct, bodyNormalAct, headShitAfterAct, /*shitAfter, */eatEffect, /*wrongAct, */openLock, nil]];
        
        //播放音效，什么什么虽然很好吃。但是。。。
        CCLOG(@"虽然很好吃，但是");
    }
    
}

- (CCAnimation *)getAnimationBodyBackToNormalWithDelay:(float)delay {
    
    CCSpriteFrame *bodyFrame;
    NSMutableArray *frames = [NSMutableArray arrayWithCapacity:5];
    
    for (int i = 3; i > -1; i--) {
        NSString *frameName = [NSString stringWithFormat:@"big%d.png", i];
        
        bodyFrame = [frameCache spriteFrameByName:frameName];
        [frames addObject:bodyFrame];
    }
    
    bodyFrame = [frameCache spriteFrameByName:@"bodyNormal.png"];
    [frames addObject:bodyFrame];
    
    return [CCAnimation animationWithFrames:frames delay:delay];
}

- (void)bodyAnimationBodyNormal {
    
    [bodySprite runAction:[CCAnimate actionWithAnimation:[self getAnimationBodyBackToNormalWithDelay:0.03]]];
    
    CCMoveTo *moveToHide = [CCMoveTo actionWithDuration:0.003 position:ccp(shitSprite.position.x, shitSprite.position.y + 40)];
    
    
    CCMoveTo *moveToShow = [CCMoveTo actionWithDuration:0.08 position:ccp(shitSprite.position.x, shitSprite.position.y)];
    
    CCCallBlock *shitEffect = [CCCallBlock actionWithBlock:^{
        [[SimpleAudioEngine sharedEngine] playEffect:EFFECT_SHIT_1];
    }];
    
    
    [shitSprite runAction:[CCSequence actions:moveToHide, shitEffect, [CCShow action], moveToShow, /*[CCScaleTo actionWithDuration:0.1 scale:1.2], [CCScaleTo actionWithDuration:0.1 scale:0.8], [CCScaleTo actionWithDuration:0.1 scale:1.0], *//*[CCDelayTime actionWithDuration:2], [CCHide action], */nil]];
    
}


- (void)openAnimationLock {
    
    //打开动画锁
    BoyIsAnimLocked = NO;
    
    //头的表情恢复正常
    [self boySetActionByActionTag:HeadNormalTagAction fruitTag:0];
    
    //屎消失
    [shitSprite runAction:[CCSequence actions:[CCDelayTime actionWithDuration:2], [CCHide action], nil]];
    
    //设置水果显示
    [[EatFuritsScene sharedEatFurits] setFruitVisible:YES];
}

- (BOOL)isAnimationLocked {
    return BoyIsAnimLocked;
}

//提前加载音效
+(void)loadEffectMusic{
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"eat.caf"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:EFFECT_EAT_RIGHT];
    [[SimpleAudioEngine sharedEngine] preloadEffect:EFFECT_EAT_WRONG];
    [[SimpleAudioEngine sharedEngine] preloadEffect:EFFECT_SHIT_0];
    [[SimpleAudioEngine sharedEngine] preloadEffect:EFFECT_SHIT_1];
    //    [[SimpleAudioEngine sharedEngine] preloadEffect:EFFECT_SHIT_2];
    
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_EAT_APPLE_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_EAT_GRAPE_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_EAT_BANANA_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_EAT_CHERRY_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_EAT_ORANGE_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_EAT_WATERMELON_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_EAT_DURIAN_EN];
    
    switch ([ZZNavBar getNumberEnCnJp]) {
        case 2:
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_EAT_APPLE_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_EAT_GRAPE_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_EAT_BANANA_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_EAT_CHERRY_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_EAT_ORANGE_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_EAT_WATERMELON_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_EAT_DURIAN_CN];
            break;
            
        case 3:
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_EAT_APPLE_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_EAT_GRAPE_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_EAT_BANANA_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_EAT_CHERRY_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_EAT_ORANGE_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_EAT_WATERMELON_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_EAT_DURIAN_JP];
            break;
            
        default:
            break;
    }
    
    
    
}

+(void)unloadEffectMusic {
    [[SimpleAudioEngine sharedEngine] unloadEffect:@"eat.caf"];
    [[SimpleAudioEngine sharedEngine] unloadEffect:EFFECT_EAT_RIGHT];
    [[SimpleAudioEngine sharedEngine] unloadEffect:EFFECT_EAT_WRONG];
    [[SimpleAudioEngine sharedEngine] unloadEffect:EFFECT_SHIT_0];
    [[SimpleAudioEngine sharedEngine] unloadEffect:EFFECT_SHIT_1];
    //    [[SimpleAudioEngine sharedEngine] unloadEffect:EFFECT_SHIT_2];
    
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_EAT_APPLE_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_EAT_GRAPE_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_EAT_BANANA_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_EAT_CHERRY_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_EAT_ORANGE_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_EAT_WATERMELON_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_EAT_DURIAN_EN];
    
    switch ([ZZNavBar getNumberEnCnJp]) {
        case 2:
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_EAT_APPLE_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_EAT_GRAPE_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_EAT_BANANA_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_EAT_CHERRY_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_EAT_ORANGE_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_EAT_WATERMELON_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_EAT_DURIAN_CN];
            break;
            
        case 3:
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_EAT_APPLE_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_EAT_GRAPE_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_EAT_BANANA_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_EAT_CHERRY_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_EAT_ORANGE_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_EAT_WATERMELON_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_EAT_DURIAN_JP];
            break;
            
        default:
            break;
    }

}

//播放背景音效
+(void)playEffectMusic {
    [[SimpleAudioEngine sharedEngine] playEffect:@"eat.caf"];
    //    [[SimpleAudioEngine sharedEngine] playEffect:@"eatApple.m4a"];
}


#pragma mark -
#pragma mark TouchEvent
- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLocation = [EatFuritsScene locationFromTouch:touch];
    
    _isTouchHandled = CGRectContainsPoint([headSprite boundingBox], touchLocation);
    if (_isTouchHandled)
	{
        
        //如果动画上锁，则不再设置当前喜欢的水果
        if (BoyIsAnimLocked == NO) {
            //说吃当前喜欢吃的水果
            [self sayLikeFruit];
        }
        
        [headSprite runAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1 scale:1.1], [CCScaleTo actionWithDuration:0.1 scale:1.0], nil]];
        [bodySprite runAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1 scale:1.1], [CCScaleTo actionWithDuration:0.1 scale:1.0], nil]];
	}
    
    return _isTouchHandled;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    
    _isTouchHandled = NO;
    
    //    [headSprite runAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1 scale:1.0], nil]];
    //    [bodySprite runAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1 scale:1.0], nil]];
    
}

@end
