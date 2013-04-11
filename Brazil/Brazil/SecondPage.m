//
//  SecondPage.m
//  Brazil
//
//  Created by zhaozilong on 12-12-23.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "SecondPage.h"
#import "ZZNavBar.h"


@implementation SecondPage

- (id)init {
    if (self = [super init]) {
        
//        self.isTouchEnabled = YES;
        
        CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        volcanoSprite = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"locked.png"]];
        volcanoSprite.position = ccp(screenSize.width / 2, screenSize.height / 2);
        [self addChild:volcanoSprite];
        
        CCSpriteFrame *frame = nil;
        CCSprite *sprite = nil;
        CCLabelTTF *continueEN = nil;
        CGFloat fontSize, y;
        switch ([ZZNavBar getNumberEnCnJp]) {
            case 1:
                if ([ZZNavBar isiPad]) {
                    fontSize = 70;
                    y = -150;
                } else {
                    fontSize = 35;
                    y = -80;
                }
                continueEN = [CCLabelTTF labelWithString:@"Continue" fontName:@"MarkerFelt-Thin" fontSize:fontSize];
                continueEN.color = ccc3(41, 41, 41);
                continueEN.position = ccp(screenSize.width / 2, screenSize.height / 2 + y);
//                [self addChild:continueEN];
                [self addChild:continueEN z:2];
                break;
                
            case 2:
                frame = [frameCache spriteFrameByName:@"lockedCN.png"];
                sprite = [CCSprite spriteWithSpriteFrame:frame];
                sprite.position = volcanoSprite.position;
                [self addChild:sprite];
                break;
                
            case 3:
                frame = [frameCache spriteFrameByName:@"lockedJP.png"];
                sprite = [CCSprite spriteWithSpriteFrame:frame];
                sprite.position = volcanoSprite.position;
                [self addChild:sprite];
                break;
                
            default:
                break;
        }
        
        
   
    }
    
    return self;
}

#if 0

-(void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}


- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint currentTouchPoint = [ChooseBallLayer locationFromTouch:touch];
    
    isTouchEnabled_ = CGRectContainsPoint(self.boundingBox, currentTouchPoint);
    
    return isTouchEnabled_;
}

#endif



@end
