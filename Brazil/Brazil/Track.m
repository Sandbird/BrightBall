//
//  Track.m
//  Brazil
//
//  Created by zhaozilong on 12-11-29.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "Track.h"
#import "ZZNavBar.h"

#define TRACK_1_TAG 111
#define TRACK_2_TAG 222


@implementation Track

-(id) init
{
	if ((self = [super init]))
	{
		// The screensize never changes during gameplay, so we can cache it in a member variable.
		screenSize = [[CCDirector sharedDirector] winSize];
		
		// Get the game's texture atlas texture by adding it. Since it's added already it will simply return
		// the CCTexture2D associated with the texture atlas.
		CCTexture2D* gameArtTexture = [[CCTextureCache sharedTextureCache] addImage:@"rubbish.png"];
		
		// Create the background spritebatch
		spriteBatch = [CCSpriteBatchNode batchNodeWithTexture:gameArtTexture];
		[self addChild:spriteBatch];
        
//		numStripes = 7;
		
		// Add the 7 different stripes and position them on the screen
		NSString* frameName = [NSString stringWithFormat:@"track0.png"];
        CCSprite* sprite = [CCSprite spriteWithSpriteFrameName:frameName];
        sprite.anchorPoint = CGPointMake(0, 0.5f);
        sprite.position = CGPointMake(0, screenSize.height / 5);
        [spriteBatch addChild:sprite];
        [sprite setTag:TRACK_1_TAG];
        
        CGFloat gapX, gapY;
        NSNumber *speed;
        if ([ZZNavBar isiPad]) {
            gapX = 260;
            gapY = 0;
            speed = [NSNumber numberWithFloat:1.5f];
        } else {
            gapX = 100;
            gapY = -10;
            speed = [NSNumber numberWithFloat:0.6f];
            
        }
        
        diskSprite = [Rubbish rubbishWithParentNode:self rubbishTag:RubbishDiskTag position:ccp(0, sprite.contentSize.height / 2 + gapY)];
        
        plasticSprite = [Rubbish rubbishWithParentNode:self rubbishTag:RubbishPlasticTag position:ccp(gapX, sprite.contentSize.height / 2 + gapY)];
        
        cokeSprite = [Rubbish rubbishWithParentNode:self rubbishTag:RubbishCokeTag position:ccp(2 * gapX, sprite.contentSize.height / 2 + gapY)];
        
        bottleSprite = [Rubbish rubbishWithParentNode:self rubbishTag:RubbishBottleTag position:ccp(3 * gapX, sprite.contentSize.height / 2 + gapY)];
        
        batterySprite = [Rubbish rubbishWithParentNode:self rubbishTag:RubbishBatteryTag position:ccp(4 * gapX, sprite.contentSize.height / 2 + gapY)];
        
        newspaperSprite = [Rubbish rubbishWithParentNode:self rubbishTag:RubbishNewspaperTag position:ccp(5 * gapX, sprite.contentSize.height / 2 + gapY)];
        
        
//		// Add 7 more stripes, flip them and position them next to their neighbor stripe
		NSString* frameName2 = [NSString stringWithFormat:@"track0.png"];
        CCSprite* sprite2 = [CCSprite spriteWithSpriteFrameName:frameName2];
//
        // Position the new sprite one screen width to the right
        sprite2.anchorPoint = CGPointMake(0, 0.5f);
        sprite2.position = CGPointMake(screenSize.width - 2, screenSize.height / 5);
        
        // Flip the sprite so that it aligns perfectly with its neighbor
        sprite2.flipX = YES;
        
        // Add the sprite using the same tag offset by numStripes
        [spriteBatch addChild:sprite2];
        [sprite2 setTag:TRACK_2_TAG];
		
		// Initialize the array that contains the scroll factors for individual stripes.
		speedFactors = [[CCArray alloc] initWithCapacity:numStripes];
		[speedFactors addObject:speed];
//		NSAssert([speedFactors count] == numStripes, @"speedFactors count does not match numStripes!");
        
		scrollSpeed = 1.0f;
		[self scheduleUpdate];
	}
	
	return self;
}

-(void) dealloc
{
    CCLOG(@"track dealloc");
	[speedFactors release];
	[super dealloc];
}

-(void) update:(ccTime)delta
{
	CCSprite* sprite;
	CCARRAY_FOREACH([spriteBatch children], sprite)
	{
		NSNumber* factor = [speedFactors objectAtIndex:0];
        CGPoint pos = sprite.position;
        
        pos.x += scrollSpeed * [factor floatValue];
        
        // Reposition stripes when they're out of bounds
        if (pos.x > screenSize.width) {
			pos.x -= screenSize.width * 2 - 2;
		}
        sprite.position = pos;
        
        CGFloat gapX, gapY;
        if ([ZZNavBar isiPad]) {
            gapX = 260;
            gapY = 0;
        } else {
            if ([ZZNavBar isiPhone5]) {
                gapX = 100;
                gapY = 5;
            } else {
                gapX = 100;
                gapY = -10;
            }
            
        }
        
        if (sprite.tag == TRACK_1_TAG) {
            if (!diskSprite.isTouchHandled) {
                [diskSprite setSpritePostion:ccp(pos.x, sprite.contentSize.height / 2 + gapY)];
            }
            
            if (!plasticSprite.isTouchHandled) {
                [plasticSprite setSpritePostion:ccp(pos.x + gapX, sprite.contentSize.height / 2 + gapY)];
            }
            
            if (!cokeSprite.isTouchHandled) {
                [cokeSprite setSpritePostion:ccp(pos.x + 2 * gapX, sprite.contentSize.height / 2 + gapY)];
            }

        } else if (sprite.tag == TRACK_2_TAG) {
            if (!bottleSprite.isTouchHandled) {
                [bottleSprite setSpritePostion:ccp(pos.x, sprite.contentSize.height / 2 + gapY)];
            }
            
            if (!batterySprite.isTouchHandled) {
                [batterySprite setSpritePostion:ccp(pos.x + gapX, sprite.contentSize.height / 2 + gapY)];
            }
            
            if (!newspaperSprite.isTouchHandled) {
                [newspaperSprite setSpritePostion:ccp(pos.x + 2 * gapX, sprite.contentSize.height / 2 + gapY)];
            }

        }
     
	}
}


@end
