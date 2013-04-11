//
//  Firecracker.m
//  Brazil
//
//  Created by zhaozilong on 13-1-18.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "Firecracker.h"
#import "FireworkScene.h"


@implementation Firecracker

- (void)dealloc {
    
    CCLOG(@"Firecracker dealloc");
    [super dealloc];
}

+ (id)firecrackerWithPos:(CGPoint)point zorder:(int)zorder rotate:(CGFloat)rotate isFlip:(BOOL)isFlip {
    return [[[self alloc] initWithPos:point zorder:zorder rotate:rotate isFlip:isFlip] autorelease];
}

- (id)initWithPos:(CGPoint)point zorder:(int)zorder rotate:(CGFloat)rotate isFlip:(BOOL)isFlip {
    if (self = [super initWithSpriteFrameName:@"firecracker.png"]) {
        
//        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:zorder swallowsTouches:YES];
        
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:-1 swallowsTouches:YES];
        
        frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
//        [self setDisplayFrame:[frameCache spriteFrameByName:@"firecracker.png"]];
        self.position = point;
        self.zOrder = zorder;
        [self setFlipX:isFlip];
        [self setRotation:rotate];
        
//        bombSprite.position = point;
//        bombSprite.zOrder = zorder;
        
        bombFrame = [frameCache spriteFrameByName:@"bomb2.png"];
        
//        CCLOG(@"111111");
    }
    
    return self;
}

- (void)playBombAnimate {
    CCCallBlock *bomb0 = [CCCallBlock actionWithBlock:^{
        [self setDisplayFrame:[frameCache spriteFrameByName:@"bomb2.png"]];
    }];
    
    CCCallBlock *bomb1 = [CCCallBlock actionWithBlock:^{
        [self setDisplayFrame:[frameCache spriteFrameByName:@"firecracker.png"]];
    }];
    
    CCSequence *action = [CCSequence actions:bomb0, [CCDelayTime actionWithDuration:0.2], [CCHide action], bomb1, nil];
    
    [self runAction:action];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    
    CGPoint currentTouchPostion = [FireworkScene locationFromTouch:touch];
    
    //鞭炮的触摸范围
    CGRect fRect = [self boundingBox];
    CGFloat y;
    if ([ZZNavBar isiPad]) {
        y = -50;
    } else {
        y = -25;
    }
    fRect.origin = ccp(self.boundingBox.origin.x, self.boundingBox.origin.y + y);
    
    CGRect sRect = [self boundingBox];
    CGFloat sx, sy;
    if ([ZZNavBar isiPad]) {
        sx = 100;
        sy = -40;
    } else {
        CGFloat x = 0.41667;
        CGFloat y = 0.46875;
        sx = 100 * x;
        sy = -40 * y;
    }
    sRect.origin = ccp(self.boundingBox.origin.x + sx, self.boundingBox.origin.y + sy);
    
    BOOL isTouch = CGRectContainsPoint(sRect, currentTouchPostion);
    if (isTouch && self.visible) {
        [self playBombAnimate];
        
        [[[FireworkScene sharedFireworkScene] snake] playFirecrackerAnimation];
        [[[FireworkScene sharedFireworkScene] navBar] setTitleLabelWithString:NSLocalizedStringFromTable(@"firecracker", [ZZNavBar getStringEnCnJp], nil)];
        
        if ([[FireworkScene sharedFireworkScene] isFirst]) {
            [[[FireworkScene sharedFireworkScene] navBar] playSoundByNameEn:SOUND_FIRECRACKER_EN Cn:SOUND_FIRECRACKER_CN Jp:SOUND_FIRECRACKER_JP];
            
            [[FireworkScene sharedFireworkScene] setIsFirst:NO];
        } else {
            [[SimpleAudioEngine sharedEngine] playEffect:EFFECT_FIRECRACKER_01];
        }
    
    }

    return isTouch;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    
    CGPoint currentTouchPostion = [FireworkScene locationFromTouch:touch];
    BOOL isTouch = CGRectContainsPoint(self.boundingBoxInPixels, currentTouchPostion);
    if (isTouch) {
        
    }
    
}


@end
