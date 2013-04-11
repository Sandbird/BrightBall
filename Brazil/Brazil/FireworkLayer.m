//
//  FireworkLayer.m
//  Brazil
//
//  Created by zhaozilong on 13-1-24.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "FireworkLayer.h"
#import "SeasideScene.h"

#define FX_1 1111
#define FX_2 2222
#define FX_3 3333
#define FX_4 4444


@implementation FireworkLayer

- (void)dealloc {
    [soundSource release];
    [super dealloc];
}

-(id) init
{
	if ((self = [super init]))
	{
//		CGSize screenSize = [[CCDirector sharedDirector] winSize];
//        CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        
        holdTag = 0;
        
        spriteA = [CCSprite spriteWithSpriteFrameName:@"firework0.png"];
        [self addChild:spriteA];
        spriteB = [CCSprite spriteWithSpriteFrameName:@"firework1.png"];
        [self addChild:spriteB];
        spriteC = [CCSprite spriteWithSpriteFrameName:@"firework2.png"];
        [self addChild:spriteC];
        spriteD = [CCSprite spriteWithSpriteFrameName:@"firework3.png"];
        [self addChild:spriteD];
        
        CGPoint PA, PB, PC, PD;
        if ([ZZNavBar isiPad]) {
            PA = ccp(120, 110);
            PB = ccp(300, 110);
            PC = ccp(480, 110);
            PD = ccp(650, 110);
        } else {
            if ([ZZNavBar isiPhone5]) {
                PA = ccp(40, 60);
                PB = ccp(120, 60);
                PC = ccp(200, 60);
                PD = ccp(280, 60);
            } else {
                PA = ccp(40, 60);
                PB = ccp(120, 60);
                PC = ccp(200, 60);
                PD = ccp(280, 60);
            }
        }
        spriteA.position = PA;
        spriteB.position = PB;
        spriteC.position = PC;
        spriteD.position = PD;
        
		self.isTouchEnabled = YES;
        
        [self scheduleUpdate];
	}
	return self;
}

-(void) runEffect
{
    CGPoint fxPoint[4];
    if ([ZZNavBar isiPad]) {
        fxPoint[0] = ccp(160, 200);
        fxPoint[1] = ccp(-80, -330);
        fxPoint[2] = ccp(100, -330);
        fxPoint[3] = ccp(0, 90);
    } else {
        if ([ZZNavBar isiPhone5]) {
            fxPoint[0] = ccp(40, 60);
            fxPoint[1] = ccp(-40, -200);
            fxPoint[2] = ccp(40, -200);
            fxPoint[3] = ccp(0, 90);
        } else {
            fxPoint[0] = ccp(40, 60);
            fxPoint[1] = ccp(-40, -160);
            fxPoint[2] = ccp(40, -160);
            fxPoint[3] = ccp(0, 90);
        }
    }
	
//	CCParticleSystem* system;
    int fxTag = 0;
	switch (particleType)
	{
		case ParticleTypeDesignedFX1:
			// by using ARCH_OPTIMAL_PARTICLE_SYSTEM either the CCQuadParticleSystem or CCPointParticleSystem class is
			// used depending on the current target.
			system = [CCParticleSystemQuad particleWithFile:@"fx_01.plist"];
			system.positionType = kCCPositionTypeFree;
            system.sourcePosition = fxPoint[0];
            fxTag = FX_1;
            
			break;
		case ParticleTypeDesignedFX2:
			// uses a plist with the texture already embedded
			system = [CCParticleSystemQuad particleWithFile:@"fx_02.plist"];
			system.positionType = kCCPositionTypeFree;
            system.sourcePosition = fxPoint[1];
            fxTag = FX_2;
            
			break;
		case ParticleTypeDesignedFX3:
			// same effect but different texture (scaled down by Particle Designer)
			system = [CCParticleSystemQuad particleWithFile:@"fx_03.plist"];
			system.positionType = kCCPositionTypeFree;
            system.sourcePosition = fxPoint[2];
            fxTag = FX_3;
            
			break;
		case ParticleTypeDesignedFX4:
            system = [CCParticleSystemQuad particleWithFile:@"fx_04.plist"];
			system.positionType = kCCPositionTypeFree;
            system.sourcePosition = fxPoint[3];
            fxTag = FX_4;

			break;
            
		default:
			// do nothing
			break;
	}
    
	CGSize winSize = [[CCDirector sharedDirector] winSize];
	system.position = CGPointMake(winSize.width / 2, winSize.height / 2);
	[self addChild:system z:1 tag:fxTag];
}

-(void) setNextParticleTypeByTag:(ParticleTypes)tag
{
	switch (tag) {
        case ParticleTypeDesignedFX1:
            particleType = ParticleTypeDesignedFX1;
            break;
            
        case ParticleTypeDesignedFX2:
            particleType = ParticleTypeDesignedFX2;
            break;
            
        case ParticleTypeDesignedFX3:
            particleType = ParticleTypeDesignedFX3;
            break;
            
        case ParticleTypeDesignedFX4:
            particleType = ParticleTypeDesignedFX4;
            break;
            
        default:
            break;
    }
}


-(void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:-1 swallowsTouches:YES];
}

// Implements logic to check if the touch location was in an area that this layer wants to handle as input.
//-(bool) isTouchForMe:(CGPoint)touchLocation
//{
//	CCNode* node = [self getChildByTag:UILayerTagFrameSprite];
//	return CGRectContainsPoint([node boundingBox], touchLocation);
//}

-(BOOL) ccTouchBegan:(UITouch*)touch withEvent:(UIEvent *)event
{
	location = [SeasideScene locationFromTouch:touch];
	isTouchEnabled_ = (CGRectContainsPoint(spriteA.boundingBox, location) || CGRectContainsPoint(spriteB.boundingBox, location) || CGRectContainsPoint(spriteC.boundingBox, location) || CGRectContainsPoint(spriteD.boundingBox, location));
    
	if (self.isTouchEnabled)
	{
		if (CGRectContainsPoint(spriteA.boundingBox, location)) {
            [spriteA runAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1 scale:1.1], [CCScaleTo actionWithDuration:0.1 scale:1.0], nil]];
            [self setNextParticleTypeByTag:ParticleTypeDesignedFX1];
            
            [[SimpleAudioEngine sharedEngine] playEffect:EFFECT_FIREWORK_01];
            
            CCCallBlock *fireworkSound = [CCCallBlock actionWithBlock:^{
                [[[SeasideScene sharedSeasideScene] navBar] playSoundByNameEn:SOUND_FIREWORKS_EN Cn:SOUND_FIREWORKS_CN Jp:SOUND_FIREWORKS_JP];
            }];
            
            CCSequence *action = [CCSequence actions:[CCDelayTime actionWithDuration:0.7], fireworkSound, nil];
            [self runAction:action];
            
            //记录当前选中的是哪个烟花
            holdTag = FX_1;
        } else if (CGRectContainsPoint(spriteB.boundingBox, location)) {
            [spriteB runAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1 scale:1.1], [CCScaleTo actionWithDuration:0.1 scale:1.0], nil]];
            [self setNextParticleTypeByTag:ParticleTypeDesignedFX2];
            
            //记录当前选中的是哪个烟花
            holdTag = FX_2;
        } else if (CGRectContainsPoint(spriteC.boundingBox, location)) {
            [spriteC runAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1 scale:1.1], [CCScaleTo actionWithDuration:0.1 scale:1.0], nil]];
            [self setNextParticleTypeByTag:ParticleTypeDesignedFX3];
            
            //记录当前选中的是哪个烟花
            holdTag = FX_2;
        } else {
            [spriteD runAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1 scale:1.1], [CCScaleTo actionWithDuration:0.1 scale:1.0], nil]];
            [self setNextParticleTypeByTag:ParticleTypeDesignedFX4];
            
            //记录当前选中的是哪个烟花
            holdTag = FX_2;
        }
        [self runEffect];
        [[[SeasideScene sharedSeasideScene] navBar] setTitleLabelWithString:NSLocalizedStringFromTable(@"fireworks", [ZZNavBar getStringEnCnJp], nil)];
//        [[[SeasideScene sharedSeasideScene] navBar] playSoundByNameEn:SOUND_FIREWORKS_EN Cn:SOUND_FIREWORKS_CN Jp:SOUND_FIREWORKS_JP];
    }
    
	return isTouchEnabled_;
}

-(void) ccTouchEnded:(UITouch*)touch withEvent:(UIEvent *)event
{
    
	if (isTouchEnabled_)
	{
		if (CGRectContainsPoint(spriteA.boundingBox, location)) {

        } else if (CGRectContainsPoint(spriteB.boundingBox, location)) {

            [system stopSystem];
            
        } else if (CGRectContainsPoint(spriteC.boundingBox, location)) {

            [system stopSystem];

        } else {

            [system stopSystem];

        }
    }
    
    isTouchEnabled_ = NO;
    
    lastHoldTag = holdTag;
    
    if (soundSource) {
        if ([soundSource isPlaying]) {
            [soundSource stop];
        }
    }

}

-(void) update:(ccTime)delta {
    if (isTouchEnabled_) {
        if (holdTag == FX_1) {
//            if (soundSource) {
//                if (lastHoldTag != FX_1) {
//                    [soundSource release], soundSource = nil;
//                    soundSource = [[[SimpleAudioEngine sharedEngine] soundSourceForFile:EFFECT_FIREWORK_01] retain];
//                    
//                    [soundSource play];
//                    
//                    lastHoldTag = FX_1;
//                } else {
//                    if (![soundSource isPlaying]) {
//                        [soundSource play];
//                    }
//                }
//            } else {
//                soundSource = [[[SimpleAudioEngine sharedEngine] soundSourceForFile:EFFECT_FIREWORK_01] retain];
//                
//                [soundSource play];
//                
//                lastHoldTag = FX_1;
//            }

        }
        
        if (holdTag == FX_2) {
            if (soundSource) {
                if (lastHoldTag != FX_2) {
                    [soundSource release];
                    soundSource = [[[SimpleAudioEngine sharedEngine] soundSourceForFile:EFFECT_FIREWORK_02] retain];
                    
                    [soundSource play];
                    
                    lastHoldTag = FX_2;
                } else {
                    if (![soundSource isPlaying]) {
                        [soundSource play];
                    }
                }
                
            } else {
                soundSource = [[[SimpleAudioEngine sharedEngine] soundSourceForFile:EFFECT_FIREWORK_02] retain];
                
                [soundSource play];
                
                lastHoldTag = FX_2;
            }
            
        }
    }
}

@end
