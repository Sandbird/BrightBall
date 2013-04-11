//
//  FireworkLayer.h
//  Brazil
//
//  Created by zhaozilong on 13-1-24.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SimpleAudioEngine.h"

typedef enum
{
	ParticleTypeDesignedFX1 = 0,
	ParticleTypeDesignedFX2,
	ParticleTypeDesignedFX3,
	ParticleTypeDesignedFX4,
	
	ParticleTypes_MAX,
} ParticleTypes;

@interface FireworkLayer : CCLayer {
    CCSprite *spriteA;
    CCSprite *spriteB;
    CCSprite *spriteC;
    CCSprite *spriteD;
    ParticleTypes particleType;
    
    CCParticleSystem* system;
    
    int currentSparkTag;
    CGPoint location;
    
    CDSoundSource *soundSource;
    
    int holdTag;
    int lastHoldTag;
    
}

@end
