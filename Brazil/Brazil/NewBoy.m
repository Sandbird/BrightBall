//
//  NewBoy.m
//  Brazil
//
//  Created by zhaozilong on 12-12-7.
//
//

#import "NewBoy.h"

@implementation NewBoy

#define TALK_TAG 1234

//@synthesize delegate = _delegate;
@synthesize isTouchHandled = _isTouchHandled;
@synthesize isSpeakAnimLocked = _isSpeakAnimLocked;

BOOL NewBoyIsAnimLocked;

- (void)dealloc {
    
    //    [_delegate release], _delegate = nil;
    
    CCLOG(@"Boy dealloc");
    
    [NewBoy unloadEffectMusic];
    
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
        
        NewBoyIsAnimLocked = NO;
        
        //获取屏幕大小
        screenSize = [[CCDirector sharedDirector] winSize];
        
        //touch is enabled
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:-1 swallowsTouches:YES];
        
        //帧缓存
        frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        
        CGPoint point, talkPoint;
        CGFloat fontSize;
        if ([ZZNavBar isiPad]) {
            point = ccp(300, screenSize.height * 2 / 13);
            talkPoint = ccp(10, 400);
            if ([ZZNavBar getNumberEnCnJp] == 3) {
                fontSize = 36;
            } else {
                fontSize = 44;
            }
        } else {
            point = ccp(115, screenSize.height / 9);
            talkPoint = ccp(0, screenSize.height / 3);
            
            if ([ZZNavBar getNumberEnCnJp] == 3) {
                fontSize = 18;
            } else {
                fontSize = 20;
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
        //        talkSprite = [CCSprite spriteWithFile:@"talk.png"];
        talkSprite.anchorPoint = ccp(0, 0);
        talkSprite.position = talkPoint;
        CCLabelTTF *talkLabel = [CCLabelTTF labelWithString:@"" dimensions:talkSprite.boundingBox.size alignment:NSTextAlignmentCenter fontName:@"MarkerFelt-Thin" fontSize:fontSize];
        talkLabel.color = ccBLACK;
        talkLabel.anchorPoint = ccp(0, 0);
        if ([ZZNavBar isiPad]) {
            if ([ZZNavBar getNumberEnCnJp] == 1) {
                talkLabel.position = ccp(-25, 0);
            } else {
                talkLabel.position = ccp(-25, -15);
            }
            
        } else {
            if ([ZZNavBar getNumberEnCnJp] == 3) {
                talkLabel.position = ccp(-10, -10);
            } else if ([ZZNavBar getNumberEnCnJp] == 1){
                talkLabel.position = ccp(-10, -5);
            } else {
                talkLabel.position = ccp(-10, -15);
            }
            
        }
        
        [talkSprite addChild:talkLabel z:0 tag:TALK_TAG];
        //        talkLabel.position = ccp(size.width / 2, size.height);
        //        [self addChild:talkLabel];
        
        
        [parentNode addChild:headSprite z:1];
        [parentNode addChild:shitSprite z:0];
        [parentNode addChild:bodySprite z:0];
        [parentNode addChild:talkSprite z:0];
        
        //初始化已经吃的水果个数
        fruitCount = 0;
        
        [NewBoy loadEffectMusic];
        //set boy's favor
        [self setCurrentFruitFavor];
        //        [self sayLikeFruit];
        sound = 0;//[[SimpleAudioEngine sharedEngine] playEffect:@"eatApple.m4a"];
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
    
    
    //    rect.origin.x = headSprite.position.x - headSprite.boundingBox.size.width / 2;
    //    rect.origin.y = screenSize.height - (headSprite.position.y + headSprite.boundingBox.size.height / 2);
    //    rect.size.height = 105;
    //    rect.size.width = 115;
    
    
    return rect;
}

- (void)setCurrentFruitFavor {
    int newTag = 0;
    do {
        //        fruitTag = arc4random() % 7 + 10;
        newTag = arc4random() % 6 + 10;
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
    CCRepeat *speakRepeat = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:speak] times:4];
    [headSprite runAction:[CCSequence actionOne:speakRepeat two:openLock]];
    
    [[SimpleAudioEngine sharedEngine] stopEffect:sound];
    
    //得到label
    CCLabelTTF *talkLabel = (CCLabelTTF *)[talkSprite getChildByTag:TALK_TAG];
    
    NSString *name = nil;
    BOOL isEn = [[[VegetablesScene sharedEatFurits] navBar] isEnglish];
    switch (fruitTag) {
        case NBFruitAppleTag:
            
            if (isEn) {
                name = SOUND_EAT_CARROT_EN;
            } else {
                if ([ZZNavBar getNumberEnCnJp] == 2) {
                    name = SOUND_EAT_CARROT_CN;
                } else {
                    name = SOUND_EAT_CARROT_JP;
                }
                
            }
            
            [talkLabel setString:NSLocalizedStringFromTable(@"eatCarrot", [ZZNavBar getStringEnCnJp], nil)];
            break;
            
        case NBFruitGrapeTag:
            
            if (isEn) {
                name = SOUND_EAT_CORN_EN;
            } else {
                if ([ZZNavBar getNumberEnCnJp] == 2) {
                    name = SOUND_EAT_CORN_CN;
                } else {
                    name = SOUND_EAT_CORN_JP;
                }
                
            }
            
            [talkLabel setString:NSLocalizedStringFromTable(@"eatCorn", [ZZNavBar getStringEnCnJp], nil)];
            break;
            
        case NBFruitBananaTag:
            
            if (isEn) {
                name = SOUND_EAT_MUSHROOM_EN;
            } else {
                if ([ZZNavBar getNumberEnCnJp] == 2) {
                    name = SOUND_EAT_MUSHROOM_CN;
                } else {
                    name = SOUND_EAT_MUSHROOM_JP;
                }
                
            }
            
            [talkLabel setString:NSLocalizedStringFromTable(@"eatMushroom", [ZZNavBar getStringEnCnJp], nil)];
            break;
            
        case NBFruitCherryTag:
            
            if (isEn) {
                name = SOUND_EAT_PUMPKIN_EN;
            } else {
                if ([ZZNavBar getNumberEnCnJp] == 2) {
                    name = SOUND_EAT_PUMPKIN_CN;
                } else {
                    name = SOUND_EAT_PUMPKIN_JP;
                }
                
            }
            
            [talkLabel setString:NSLocalizedStringFromTable(@"eatPumpkin", [ZZNavBar getStringEnCnJp], nil)];
            break;
            
        case NBFruitOrangeTag:
            
            if (isEn) {
                name = SOUND_EAT_TOMATO_EN;
            } else {
                if ([ZZNavBar getNumberEnCnJp] == 2) {
                    name = SOUND_EAT_TOMATO_CN;
                } else {
                    name = SOUND_EAT_TOMATO_JP;
                }
                
            }
            
            [talkLabel setString:NSLocalizedStringFromTable(@"eatTomato", [ZZNavBar getStringEnCnJp], nil)];
            break;
            
        case NBFruitWatermelonTag:
            
            if (isEn) {
                name = SOUND_EAT_POTATO_EN;
            } else {
                if ([ZZNavBar getNumberEnCnJp] == 2) {
                    name = SOUND_EAT_POTATO_CN;
                } else {
                    name = SOUND_EAT_POTATO_JP;
                }
                
            }
            
            [talkLabel setString:NSLocalizedStringFromTable(@"eatPotato", [ZZNavBar getStringEnCnJp], nil)];
            break;
            
        default:
            CCLOG(@"ERROR，我啥也不想吃。%d", fruitTag);
            break;
    }
    
    sound = [[SimpleAudioEngine sharedEngine] playEffect:name];
    
    
}

- (NSString *)getCurrentFruitName {
    switch (fruitTag) {
        case NBFruitAppleTag:
            return @"Carrot";
            break;
            
        case NBFruitGrapeTag:
            return @"Corn";
            break;
            
        case NBFruitBananaTag:
            return @"Mushroom";
            break;
            
        case NBFruitCherryTag:
            return @"Pumpkin";
            break;
            
        case NBFruitOrangeTag:
            return @"Tomato";
            break;
            
        case NBFruitWatermelonTag:
            return @"Potato";
            break;
            
            //        case FruitDurianTag:
            //            return @"Durian";
            //            break;
            
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
        case NBHeadNormalTagAction:
            frame = [frameCache spriteFrameByName:PNG_HEAD_NORMAL];
            [headSprite setDisplayFrame:frame];
            break;
            
        case NBHeadOpenMouthTagAction:
            frame = [frameCache spriteFrameByName:PNG_HEAD_OPEN_MOUTH];
            [headSprite setDisplayFrame:frame];
            break;
            
        case NBHeadEatTagAction:
            //            frame = [frameCache spriteFrameByName:PNG_HEAD_EAT];
            //            [headSprite setDisplayFrame:frame];
            [self headAnimationEatWithFruitTag:boyTagFruit];
            break;
            
        case NBHeadRightTagAction:
            frame = [frameCache spriteFrameByName:PNG_HEAD_RIGHT];
            [headSprite setDisplayFrame:frame];
            break;
            
        case NBHeadWrongTagAction:
            frame = [frameCache spriteFrameByName:PNG_HEAD_WRONG];
            [headSprite setDisplayFrame:frame];
            break;
            
        case NBBodyNormalTgAction:
            frame = [frameCache spriteFrameByName:PNG_BODY_NORMAL];
            [bodySprite setDisplayFrame:frame];
            break;
            
        case NBBodyBig0TagAction:
            frame = [frameCache spriteFrameByName:PNG_BODY_BIG_0];
            [bodySprite setDisplayFrame:frame];
            break;
            
        case NBBodyBig1TagAction:
            frame = [frameCache spriteFrameByName:PNG_BODY_BIG_1];
            [bodySprite setDisplayFrame:frame];
            break;
            
        case NBBodyBig2TagAction:
            frame = [frameCache spriteFrameByName:PNG_BODY_BIG_2];
            [bodySprite setDisplayFrame:frame];
            break;
            
        case NBBodyBig3TagAction:
            frame = [frameCache spriteFrameByName:PNG_BODY_BIG_3];
            [bodySprite setDisplayFrame:frame];
            break;
            
        case NBBodyShitTagAction:
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
    NewBoyIsAnimLocked = YES;
    
    //吃的水果数+1
    fruitCount ++;
    
    //播放动画
    switch (fruitCount) {
        case 1:
            [self boyAnimationPlayWithFruitTag:boyTagFruit bodyTag:NBBodyBig0TagAction];
            break;
            
        case 2:
            [self boyAnimationPlayWithFruitTag:boyTagFruit bodyTag:NBBodyBig1TagAction];
            break;
            
        case 3:
            [self boyAnimationPlayWithFruitTag:boyTagFruit bodyTag:NBBodyBig2TagAction];
            break;
            
        case 4:
            [self boyAnimationPlayWithFruitTag:boyTagFruit bodyTag:NBBodyBig3TagAction];
            break;
            
        case 5:
            [self boyUtimateAnimationPlayWithFruitTag:boyTagFruit bodyTag:NBBodyNormalTgAction];
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
    [NewBoy playEffectMusic];
    
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
            [[SimpleAudioEngine sharedEngine] playEffect:EFFECT_RIGHT];
        }];
        
        //播放吃对了的动画
        [headSprite runAction:[CCSequence actions:eatRepeat, eatRight, rightAct, eatEffect, openLock, nil]];
        
        //再次设置随机水果
        [self setCurrentFruitFavor];
        
    } else {
        
        CCCallBlock *eatWrong = [CCCallBlock actionWithBlock:^{
            [[SimpleAudioEngine sharedEngine] playEffect:EFFECT_WRONG];
        }];
        
        //播放吃错了的动画
        [headSprite runAction:[CCSequence actions:eatRepeat, eatWrong, wrongAct, eatEffect, openLock, nil]];
        
        //播放音效，什么什么虽然很好吃。但是。。。
        CCLOG(@"虽然很好吃，但是");
    }
    
    //播放音效，我想吃什么什么
    //    [self sayLikeFruit];
    
    //肚子变化
    [self boySetActionByActionTag:boyTagBody fruitTag:0];
    
}

- (void)boyUtimateAnimationPlayWithFruitTag:(int)boyTagFruit bodyTag:(int)boyTagBody {
    
    //吃东西的动画
    CCAnimate *eatAct = [CCAnimate actionWithAnimation:[CCAnimation animationWithFrame:ANIM_HEAD_EAT frameCount:2 delay:0.2]];
    CCRepeat *eatRepeat = [CCRepeat actionWithAction:eatAct times:3];
    
    //    //吃对了的表情
    //    CCAnimate *rightAct = [CCAnimate actionWithAnimation:[CCAnimation animationWithFrame:@"headRight" frameCount:1 delay:1]];
    //
    //    //吃错了的表情
    //    CCAnimate *wrongAct = [CCAnimate actionWithAnimation:[CCAnimation animationWithFrame:@"headWrong" frameCount:1 delay:1]];
    
    //拉屎ing表情动画
    CCAnimate *headShitingAct = [CCAnimate actionWithAnimation:[CCAnimation animationWithSingleFrame:@"headShit0" delay:1]];
    
    //拉完屎害羞的表情
    CCAnimate *headShitAfterAct = [CCAnimate actionWithAnimation:[CCAnimation animationWithSingleFrame:@"headShit1" delay:2]];
    
    //肚子小了
    //    CCAnimate *bodyNormalAct = [CCAnimate actionWithAnimation:[CCAnimation animationWithSingleFrame:@"bodyNormal" delay:1]];
    CCCallFunc *bodyNormalAct = [CCCallFunc actionWithTarget:self selector:@selector(bodyAnimationBodyNormal)];
    
    //吃完之后打开动画锁
    id openLock = [CCCallFunc actionWithTarget:self selector:@selector(openAnimationLock)];
    
    CCCallBlock *eatEffect = [CCCallBlock actionWithBlock:^{
        [self sayLikeFruit];
    }];
    
    //    CCDelayTime *delay = [CCDelayTime actionWithDuration:0.1];
    
    //播放吃东西的音效
    [NewBoy playEffectMusic];
    
    CCCallBlock *shiting = [CCCallBlock actionWithBlock:^{
        [[SimpleAudioEngine sharedEngine] playEffect:EFFECT_EAT_SHIT_0];
    }];
    
    //    CCCallBlock *shitAfter = [CCCallBlock actionWithBlock:^{
    //        [[SimpleAudioEngine sharedEngine] playEffect:EFFECT_EAT_SHIT_2];
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
        //播放吃错了的动画
        [headSprite runAction:[CCSequence actions:eatRepeat, shiting, headShitingAct, bodyNormalAct, /*shitAfter,  */headShitAfterAct, eatEffect, /*wrongAct, */openLock, nil]];
        
        //播放音效，什么什么虽然很好吃。但是。。。
        CCLOG(@"虽然很好吃，但是");
    }
    
    //播放音效，我想吃什么什么
    //    [self sayLikeFruit];
    
    //肚子变化
    //    [self boySetActionByActionTag:boyTagBody fruitTag:0];
    
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
    //    [self boySetActionByActionTag:BodyNormalTgAction fruitTag:0];
    [bodySprite runAction:[CCAnimate actionWithAnimation:[self getAnimationBodyBackToNormalWithDelay:0.03]]];
    
    CCMoveTo *moveToHide = [CCMoveTo actionWithDuration:0.003 position:ccp(shitSprite.position.x, shitSprite.position.y + 40)];
    //    CCRotateTo *rotateTo45 = [CCRotateTo actionWithDuration:0.003 angle:45.0];
    //    CCSpawn *shitHide = [CCSpawn actionOne:moveToHide two:rotateTo45];
    
    CCMoveTo *moveToShow = [CCMoveTo actionWithDuration:0.08 position:ccp(shitSprite.position.x, shitSprite.position.y)];
    //    CCRotateTo *rotateTo0 = [CCRotateTo actionWithDuration:0.08 angle:0.0];
    //    CCSpawn *shitShow = [CCSpawn actionOne:moveToShow two:rotateTo0];
    
    CCCallBlock *shitEffect = [CCCallBlock actionWithBlock:^{
        [[SimpleAudioEngine sharedEngine] playEffect:EFFECT_EAT_SHIT_1];
    }];
    
    [shitSprite runAction:[CCSequence actions:moveToHide, shitEffect, [CCShow action], moveToShow, /*[CCScaleTo actionWithDuration:0.1 scale:1.2], [CCScaleTo actionWithDuration:0.1 scale:0.8], [CCScaleTo actionWithDuration:0.1 scale:1.0], *//*[CCDelayTime actionWithDuration:2], [CCHide action], */nil]];
    
    //    [CCScaleBy actionWithDuration:0.1 scaleX:270.0f scaleY:350.0f];
}


- (void)openAnimationLock {
    
    //打开动画锁
    NewBoyIsAnimLocked = NO;
    
    //头的表情恢复正常
    [self boySetActionByActionTag:NBHeadNormalTagAction fruitTag:0];
    
    //屎消失
    [shitSprite runAction:[CCSequence actions:[CCDelayTime actionWithDuration:2], [CCHide action], nil]];
    
    //设置水果显示
    [[VegetablesScene sharedEatFurits] setFruitVisible:YES];
}

- (BOOL)isAnimationLocked {
    return NewBoyIsAnimLocked;
}

//提前加载音效
+(void)loadEffectMusic{
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"eat.caf"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:EFFECT_RIGHT];
    [[SimpleAudioEngine sharedEngine] preloadEffect:EFFECT_WRONG];
    [[SimpleAudioEngine sharedEngine] preloadEffect:EFFECT_EAT_SHIT_0];
    [[SimpleAudioEngine sharedEngine] preloadEffect:EFFECT_EAT_SHIT_1];
    //    [[SimpleAudioEngine sharedEngine] preloadEffect:EFFECT_EAT_SHIT_2];
    
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_EAT_PUMPKIN_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_EAT_MUSHROOM_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_EAT_POTATO_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_EAT_TOMATO_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_EAT_CORN_EN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_EAT_CARROT_EN];
    
    switch ([ZZNavBar getNumberEnCnJp]) {
        case 2:
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_EAT_PUMPKIN_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_EAT_MUSHROOM_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_EAT_POTATO_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_EAT_TOMATO_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_EAT_CORN_CN];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_EAT_CARROT_CN];
            break;
            
        case 3:
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_EAT_PUMPKIN_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_EAT_MUSHROOM_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_EAT_POTATO_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_EAT_TOMATO_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_EAT_CORN_JP];
            [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_EAT_CARROT_JP];
            break;
            
        default:
            break;
    }

}

+(void)unloadEffectMusic {
    [[SimpleAudioEngine sharedEngine] unloadEffect:@"eat.caf"];
    [[SimpleAudioEngine sharedEngine] unloadEffect:EFFECT_RIGHT];
    [[SimpleAudioEngine sharedEngine] unloadEffect:EFFECT_WRONG];
    [[SimpleAudioEngine sharedEngine] unloadEffect:EFFECT_EAT_SHIT_0];
    [[SimpleAudioEngine sharedEngine] unloadEffect:EFFECT_EAT_SHIT_1];
    //    [[SimpleAudioEngine sharedEngine] unloadEffect:EFFECT_EAT_SHIT_2];
    
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_EAT_PUMPKIN_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_EAT_MUSHROOM_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_EAT_POTATO_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_EAT_TOMATO_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_EAT_CORN_EN];
    [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_EAT_CARROT_EN];
    
    switch ([ZZNavBar getNumberEnCnJp]) {
        case 2:
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_EAT_PUMPKIN_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_EAT_MUSHROOM_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_EAT_POTATO_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_EAT_TOMATO_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_EAT_CORN_CN];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_EAT_CARROT_CN];
            break;
            
        case 3:
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_EAT_PUMPKIN_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_EAT_MUSHROOM_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_EAT_POTATO_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_EAT_TOMATO_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_EAT_CORN_JP];
            [[SimpleAudioEngine sharedEngine] unloadEffect:SOUND_EAT_CARROT_JP];
            break;
            
        default:
            break;
    }
}


//播放背景音效
+(void)playEffectMusic {
    [[SimpleAudioEngine sharedEngine] playEffect:@"eat.caf"];
}


#pragma mark -
#pragma mark TouchEvent
- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLocation = [VegetablesScene locationFromTouch:touch];
    
    _isTouchHandled = CGRectContainsPoint([headSprite boundingBox], touchLocation);
    if (_isTouchHandled)
	{
        
        //如果动画上锁，则不再设置当前喜欢的水果
        if (NewBoyIsAnimLocked == NO) {
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
    
}

@end

