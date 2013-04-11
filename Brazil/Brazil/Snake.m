//
//  Snake.m
//  Brazil
//
//  Created by zhaozilong on 13-1-18.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "Snake.h"
#import "ZZNavBar.h"
#import "FireworkScene.h"
#import "CCAnimationHelper.h"


@implementation Snake

- (void)dealloc {
    
    CCLOG(@"Snake dealloc");
    
    [super dealloc];
}

+ (Snake *)snakeWithParentNode:(CCNode *)parentNode {
    return [[[self alloc] initWithParentNode:parentNode] autorelease];
}

- (id)initWithParentNode:(CCNode *)parentNode {
    if (self = [super init]) {
        //touch is enabled
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:NO];
        
        [parentNode addChild:self];
        
        screenSize = [[CCDirector sharedDirector] winSize];
        
        frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        
        CGFloat snakeX, snakeY, eyeX, blessX, blessY;
        if ([ZZNavBar isiPad]) {
            snakeX = 100;
            snakeY = 10;
            
            eyeX = 110;
            
            blessX = 95;
            blessY = -80;
        } else {
            CGFloat x = 0.41667;
            CGFloat y = 0.46875;
            
            snakeX = 100 * x;
            snakeY = 10 * y;
            
            eyeX = 110 * x;
            
            blessX = 95 * x;
            
            if ([ZZNavBar isiPhone5]) {
                blessY = -80 * y - 65;
            } else {
                blessY = -80 * y - 20;
            }
            
        }
        
        //小蛇的身子
        CCSpriteFrame *frame = [frameCache spriteFrameByName:@"snake0.png"];
        [self setDisplayFrame:frame];
        self.position = ccp(self.contentSize.width / 2 + snakeX, self.contentSize.height / 2 + snakeY);
        
        //眼睛
        eyeSprite = [CCSprite spriteWithSpriteFrameName:@"eye0.png"];
        eyeSprite.position = ccp(eyeX, self.contentSize.height / 2);
        [self addChild:eyeSprite];
        
        //福字
        blessSprite = [CCSprite spriteWithSpriteFrameName:@"blessing.png"];
        blessSprite.position = ccp(screenSize.width / 2 + blessX, screenSize.height / 2 + blessY);
        [self addChild:blessSprite];
        
        //bomb
        bombSprite = [CCSprite spriteWithSpriteFrameName:@"bomb0.png"];
        bombSprite.position = ccp(screenSize.width / 2, screenSize.height / 2);
        [parentNode addChild:bombSprite];
        bombSprite.visible = NO;
        
#if 0
        //用来测试触摸的位置
        CCSprite *test = [CCSprite spriteWithFile:@"Default@2x.png" rect:[self getSnakeSpriteRect]];
        test.position = [self getSnakeSpriteRect].origin;
        [self addChild:test z:-5];
        
        test = [CCSprite spriteWithFile:@"Default-Portrait.png" rect:[self getBlessSpriteRect]];
        test.position = [self getBlessSpriteRect].origin;
        [self addChild:test z:-5];
#endif
        
        
        
    }
    
    return self;
}

- (CGRect)getSnakeSpriteRect {
    
    if ([ZZNavBar isiPad]) {
        return CGRectMake(150, 0, 300, 500);
    } else {
        CGFloat x = 0.41667;
        CGFloat y = 0.46875;
        return CGRectMake(150 * x - 20, 0, 300 * x, 500 * y);
    }
    
}

- (CGRect)getBlessSpriteRect {
    if ([ZZNavBar isiPad]) {
        return CGRectMake(480, 520, 150, 150);
    } else {
        CGFloat x = 0.41667;
        CGFloat y = 0.46875;
        if ([ZZNavBar isiPhone5]) {
            return CGRectMake(480 * x + 10, 520 * y - 20, 150 * x, 150 * y - 10);
        } else {
            return CGRectMake(480 * x , 520 * y, 150 * x, 150 * y - 40);
        }
        
    }
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint currentTouchPoint = [FireworkScene locationFromTouch:touch];
    BOOL isTouch = (CGRectContainsPoint([self getSnakeSpriteRect], currentTouchPoint) || CGRectContainsPoint([self getBlessSpriteRect], currentTouchPoint));
    
    if (isTouch) {
        if (CGRectContainsPoint([self getSnakeSpriteRect], currentTouchPoint)) {
            //变大小
            [self runAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1 scale:1.1], [CCScaleTo actionWithDuration:0.1 scale:1.0], nil]];
            
            //播放声音，显示单词
            [[[FireworkScene sharedFireworkScene] navBar] setTitleLabelWithString:NSLocalizedStringFromTable(@"snake", [ZZNavBar getStringEnCnJp], nil)];
            
            [[[FireworkScene sharedFireworkScene] navBar] playSoundByNameEn:SOUND_SNAKE_EN Cn:SOUND_SNAKE_CN Jp:SOUND_SNAKE_JP];
        } else {
            [self playBombAnimation];
            
            //isFirst放鞭炮归零
            [[FireworkScene sharedFireworkScene] setIsFirst:YES];
            
            [[SimpleAudioEngine sharedEngine] playEffect:EFFECT_FIRECRACKER_02];

        }
    }
    
    return isTouch;
}

- (void)playBombAnimation {
    CCAnimate *bombAnimate = [CCAnimate actionWithAnimation:[CCAnimation animationWithFrame:@"bomb" frameCount:2 delay:0.2]];
    
    CCCallBlock *backToColor = [CCCallBlock actionWithBlock:^{
        [self setDisplayFrame:[frameCache spriteFrameByName:@"snake0.png"]];
    }];
    
    CCCallBlock *backToEye = [CCCallBlock actionWithBlock:^{
        [eyeSprite setDisplayFrame:[frameCache spriteFrameByName:@"eye0.png"]];
    }];
    
    CCCallBlock *snakeAction = [CCCallBlock actionWithBlock:^{
        [self setDisplayFrame:[frameCache spriteFrameByName:@"snake1.png"]];
        CCAnimate *eyeAnimate = [CCAnimate actionWithAnimation:[CCAnimation animationWithFrame:@"eye" frameCount:2 delay:0.2]];
        CCRepeat *eyeRepeat = [CCRepeat actionWithAction:eyeAnimate times:2];
        CCSequence *snakeAndEyeAction = [CCSequence actions:eyeRepeat, backToEye, [CCDelayTime actionWithDuration:1], backToColor, nil];
        [eyeSprite runAction:snakeAndEyeAction];
    }];
    
    CCCallBlock *smallBomb = [CCCallBlock actionWithBlock:^{
        [bombSprite setDisplayFrame:[frameCache spriteFrameByName:@"bomb0.png"]];
    }];
    
    CCSequence *action = [CCSequence actions:[CCShow action], bombAnimate, [CCHide action], snakeAction, smallBomb, nil];
    [bombSprite runAction:action];
    
    [[FireworkScene sharedFireworkScene] restoreFirecrackers];
}

- (void)playFirecrackerAnimation {
    
    CCCallBlock *closeEye = [CCCallBlock actionWithBlock:^{
        [eyeSprite setDisplayFrame:[frameCache spriteFrameByName:@"eye2.png"]];
    }];
    
    CCCallBlock *openEye = [CCCallBlock actionWithBlock:^{
        [eyeSprite setDisplayFrame:[frameCache spriteFrameByName:@"eye0.png"]];
    }];
    
    CCSequence *action = [CCSequence actions:closeEye, [CCDelayTime actionWithDuration:0.2], openEye, nil];
    
    [eyeSprite runAction:action];

}


@end
