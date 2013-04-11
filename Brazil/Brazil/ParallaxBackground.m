//
//  ParallaxBackground.m
//  ScrollingWithJoy
//
//  Created by Steffen Itterheim on 11.08.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import "ParallaxBackground.h"


@implementation ParallaxBackground

@synthesize scrollSpeed = _scrollSpeed;

-(void) dealloc
{
    CCLOG(@"background dealloc");
    [layerArray release];
	[speedFactors release];
	[super dealloc];
}

-(id) init
{
	if ((self = [super init]))
	{
		// The screensize never changes during gameplay, so we can cache it in a member variable.
		screenSize = [[CCDirector sharedDirector] winSize];
		
        /*
         // Get the game's texture atlas texture by adding it. Since it's added already it will simply return
         // the CCTexture2D associated with the texture atlas.
         CCTexture2D* gameArtTexture = [[CCTextureCache sharedTextureCache] addImage:@"traffic.png"];
         
         // Create the background spritebatch
         spriteBatch = [CCSpriteBatchNode batchNodeWithTexture:gameArtTexture];
         [self addChild:spriteBatch];
         
         */
        //touch is enabled
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:-1 swallowsTouches:YES];
        
        
        CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        
        CCSpriteFrame *frame;
        CCSprite* sprite;
        layerArray = [[CCArray alloc] initWithCapacity:35];
		numStripes = 6;
        for (int j = 0; j < numStripes; j++) {
            // Add the 7 different stripes and position them on the screen
            if (j == 4) {
                for (int i = 0; i < 6; i++)
                {
                    
                    NSString* frameName = [NSString stringWithFormat:@"thing%d.png", i + 1];
                    frame = [frameCache spriteFrameByName:frameName];
                    sprite = [CCSprite spriteWithSpriteFrame:frame];
                    sprite.tag = i + 1;
                    sprite.anchorPoint = CGPointMake(0, 0.5f);
                    CGFloat ypos;
                    if ([ZZNavBar isiPad]) {
                        switch (i + 1) {
                            case 1:
                                ypos = screenSize.height / 2 + 30;
                                break;
                                
                            case 2:
                                ypos = screenSize.height / 2 + 25;
                                break;
                                
                            case 3:
                                ypos = screenSize.height / 2;
                                break;
                                
                            case 4:
                                ypos = screenSize.height / 2 + 90;
                                break;
                                
                            case 5:
                                ypos = screenSize.height / 2 + 80;
                                break;
                                
                            case 6:
                                ypos = screenSize.height / 2 + 110;
                                break;
                                
                            default:
                                break;
                        }
                    } else {
                        if ([ZZNavBar isiPhone5]) {
                            switch (i + 1) {
                                case 1:
                                    ypos = screenSize.height / 2 - 30;
                                    break;
                                    
                                case 2:
                                    ypos = screenSize.height / 2 - 30;
                                    break;
                                    
                                case 3:
                                    ypos = screenSize.height / 2 - 30;
                                    break;
                                    
                                case 4:
                                    ypos = screenSize.height / 2 + 20;
                                    break;
                                    
                                case 5:
                                    ypos = screenSize.height / 2;
                                    break;
                                    
                                case 6:
                                    ypos = screenSize.height / 2 + 25;
                                    break;
                                    
                                default:
                                    break;
                            }
                            
                        } else {
                            switch (i + 1) {
                                case 1:
                                    ypos = screenSize.height / 2 + 15;
                                    break;
                                    
                                case 2:
                                    ypos = screenSize.height / 2 + 15;
                                    break;
                                    
                                case 3:
                                    ypos = screenSize.height / 2 + 10;
                                    break;
                                    
                                case 4:
                                    ypos = screenSize.height / 2 + 50;
                                    break;
                                    
                                case 5:
                                    ypos = screenSize.height / 2 + 40;
                                    break;
                                    
                                case 6:
                                    ypos = screenSize.height / 2 + 65;
                                    break;
                                    
                                default:
                                    break;
                            }
                            
                        }
                        
                    }
                    sprite.position = CGPointMake(i * (screenSize.width - 1) , ypos);
                    [layerArray addObject:sprite];
                    [self addChild:sprite z:2];
                    
                    //                [spriteBatch addChild:sprite z:(j + 1) * 2];
                }
            } else if (j == 5) {
                CGPoint pos1, pos2, pos3, pos4, pos5;
                if ([ZZNavBar isiPhone5]) {
                    pos1 = ccp(3 * (screenSize.width - 1) / 2, screenSize.height * 2 / 5);
                    pos2 = ccp(5 * (screenSize.width - 1) / 2, screenSize.height * 2 / 7);
                    pos3 = ccp(7 * (screenSize.width - 1) / 2, screenSize.height / 5);
                    pos4 = ccp((screenSize.width - 1) / 4, screenSize.height / 6);
                    pos5 = ccp(9 * (screenSize.width - 1) / 2, screenSize.height * 2 / 5);
                } else {
                    pos1 = ccp(3 * (screenSize.width - 1) / 2, screenSize.height * 3 / 7);
                    pos2 = ccp(5 * (screenSize.width - 1) / 2, screenSize.height * 2 / 5 - 30);
                    pos3 = ccp(7 * (screenSize.width - 1) / 2, screenSize.height / 5);
                    pos4 = ccp((screenSize.width - 1) / 4, screenSize.height / 6);
                    pos5 = ccp(9 * (screenSize.width - 1) / 2, screenSize.height * 3 / 7);
                }
                
                sprite = [CarSprite carWithParentNode:self pos:pos1 zorder:4 carTag:CarBicycleTag];
                [layerArray addObject:sprite];
                
                sprite = [CarSprite carWithParentNode:self pos:pos5 zorder:4 carTag:Car5Tag];
                [layerArray addObject:sprite];
                
                sprite = [CarSprite carWithParentNode:self pos:pos2 zorder:4 carTag:CarCarTag];
                [layerArray addObject:sprite];
                
                sprite = [CarSprite carWithParentNode:self pos:pos3 zorder:4 carTag:Car4Tag];
                [layerArray addObject:sprite];
                
                sprite = [CarSprite carWithParentNode:self pos:pos4 zorder:4 carTag:CarBusTag];
                [layerArray addObject:sprite];
                
                
            } else {
                for (int i = 0; i < 6; i++)
                {
                    
                    NSString* frameName = [NSString stringWithFormat:@"layer%d-%d.png", j, i + 1];
                    frame = [frameCache spriteFrameByName:frameName];
                    sprite = [CCSprite spriteWithSpriteFrame:frame];
                    sprite.anchorPoint = CGPointMake(0, 0.5f);
                    sprite.position = CGPointMake(i * (screenSize.width - 1), screenSize.height / 2);
                    [layerArray addObject:sprite];
                    
                    switch (j) {
                        case 0:
                            [self addChild:sprite z:0];
                            break;
                            
                        case 1:
                            [self addChild:sprite z:1];
                            break;
                            
                        case 2:
                            [self addChild:sprite z:3];
                            break;
                            
                        case 3:
                            [self addChild:sprite z:5];
                            break;
                            
                        default:
                            break;
                    }
                }
                
            }
            
        }
        
		
		// Initialize the array that contains the scroll factors for individual stripes.
		speedFactors = [[CCArray alloc] initWithCapacity:numStripes];
		[speedFactors addObject:[NSNumber numberWithFloat:0.3f]];//0
		[speedFactors addObject:[NSNumber numberWithFloat:0.5f]];//1
		[speedFactors addObject:[NSNumber numberWithFloat:0.8f]];//2
        [speedFactors addObject:[NSNumber numberWithFloat:0.8f]];//3
        [speedFactors addObject:[NSNumber numberWithFloat:0.8f]];//4
		[speedFactors addObject:[NSNumber numberWithFloat:1.2f]];//5
		NSAssert([speedFactors count] == numStripes, @"speedFactors count does not match numStripes!");
        
		_scrollSpeed = 6.0f;
        //		[self scheduleUpdate];
	}
	
	return self;
}



-(void) update:(ccTime)delta
{
	CCSprite* sprite;
	CCARRAY_FOREACH(layerArray, sprite)
	{
        
        //        CCLOG(@"30,,,%@ \n 31,,,%@", [layerArray objectAtIndex:30], [layerArray objectAtIndex:31]);
        if (sprite.tag == [[TrafficScene sharedTrafficScene] currentCar]) {
            continue;
        }
        
		//CCLOG(@"tag: %i", sprite.tag);
		NSNumber* factor = [speedFactors objectAtIndex:sprite.zOrder];
		
		CGPoint pos = sprite.position;
		pos.x += _scrollSpeed * [factor floatValue];
		
		// Reposition stripes when they're out of bounds
		if (pos.x > screenSize.width)
		{
            if (sprite.tag == CarBusTag || sprite.tag == CarBicycleTag || sprite.tag == CarCarTag || sprite.tag == Car4Tag || sprite.tag == Car5Tag) {
                pos.x -= (screenSize.width * 11 / 2) - 6;
            } else {
                pos.x -= (screenSize.width * 6) - 6;
            }
		}
		
		sprite.position = pos;
	}
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint currentTouchPoint = [TrafficScene locationFromTouch:touch];
    
    CCSprite *s1 = (CCSprite *)[self getChildByTag:1];
    CCSprite *s2 = (CCSprite *)[self getChildByTag:2];
    CCSprite *s3 = (CCSprite *)[self getChildByTag:3];
    CCSprite *s4 = (CCSprite *)[self getChildByTag:4];
    CCSprite *s5 = (CCSprite *)[self getChildByTag:5];
    CCSprite *s6 = (CCSprite *)[self getChildByTag:6];
    
    CGRect rect1 = [s1 boundingBox];
    CGRect rect2 = [s2 boundingBox];
    CGRect rect3 = [s3 boundingBox];
    CGRect rect4 = [s4 boundingBox];
    CGRect rect5 = [s5 boundingBox];
    CGRect rect6 = [s6 boundingBox];
    
    isTouchHandled = CGRectContainsPoint(rect1, currentTouchPoint) || CGRectContainsPoint(rect2, currentTouchPoint) || CGRectContainsPoint(rect3, currentTouchPoint) || CGRectContainsPoint(rect4, currentTouchPoint) || CGRectContainsPoint(rect5, currentTouchPoint) || CGRectContainsPoint(rect6, currentTouchPoint);
    
    CCSprite *sprite;
    NSString *building = nil;
    NSString *name = nil;
    BOOL isEn = [[[TrafficScene sharedTrafficScene] navBar] isEnglish];
    
    if (isTouchHandled) {
        if (CGRectContainsPoint(rect1, currentTouchPoint)) {
            sprite = s1;
            building = NSLocalizedStringFromTable(@"Tiananmen", [ZZNavBar getStringEnCnJp], nil);
            if (isEn) {
                name = SOUND_TIANANMEN_EN;
            } else {
                if ([ZZNavBar getNumberEnCnJp] == 2) {
                    name = SOUND_TIANANMEN_CN;
                } else {
                    name = SOUND_TIANANMEN_JP;
                }
                
            }
        } else if (CGRectContainsPoint(rect2, currentTouchPoint)) {
            sprite = s2;
            building = NSLocalizedStringFromTable(@"Pyramid", [ZZNavBar getStringEnCnJp], nil);
            if (isEn) {
                name = SOUND_PYRAMID_EN;
            } else {
                if ([ZZNavBar getNumberEnCnJp] == 2) {
                    name = SOUND_PYRAMID_CN;
                } else {
                    name = SOUND_PYRAMID_JP;
                }
                
            }
        } else if (CGRectContainsPoint(rect3, currentTouchPoint)) {
            sprite = s3;
            building = NSLocalizedStringFromTable(@"SydneyOperaHouse", [ZZNavBar getStringEnCnJp], nil);
            if (isEn) {
                name = SOUND_OPERA_EN;
            } else {
                if ([ZZNavBar getNumberEnCnJp] == 2) {
                    name = SOUND_OPERA_CN;
                } else {
                    name = SOUND_OPERA_JP;
                }
                
            }
        } else if (CGRectContainsPoint(rect4, currentTouchPoint)) {
            sprite = s4;
            building = NSLocalizedStringFromTable(@"StatueOfLiberty", [ZZNavBar getStringEnCnJp], nil);
            if (isEn) {
                name = SOUND_LIBERTY_EN;
            } else {
                if ([ZZNavBar getNumberEnCnJp] == 2) {
                    name = SOUND_LIBERTY_CN;
                } else {
                    name = SOUND_LIBERTY_JP;
                }
                
            }
        } else if (CGRectContainsPoint(rect5, currentTouchPoint)) {
            sprite = s5;
            building = NSLocalizedStringFromTable(@"TriumphalArch", [ZZNavBar getStringEnCnJp], nil);
            if (isEn) {
                name = SOUND_ARCH_EN;
            } else {
                if ([ZZNavBar getNumberEnCnJp] == 2) {
                    name = SOUND_ARCH_CN;
                } else {
                    name = SOUND_ARCH_JP;
                }
                
            }
        } else {
            sprite = s6;
            building = NSLocalizedStringFromTable(@"EiffelTower", [ZZNavBar getStringEnCnJp], nil);
            if (isEn) {
                name = SOUND_TOWER_EN;
            } else {
                if ([ZZNavBar getNumberEnCnJp] == 2) {
                    name = SOUND_TOWER_CN;
                } else {
                    name = SOUND_TOWER_JP;
                }
                
            }
        }
        [[[TrafficScene sharedTrafficScene] navBar] setTitleLabelWithString:building];
        
        [[SimpleAudioEngine sharedEngine] playEffect:name];
        
        [sprite runAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.05 scale:1.1], [CCScaleTo actionWithDuration:0.05 scale:1.0], nil]];
    }
    
    
    return isTouchHandled;
}

- (void)brakeOrMove:(BOOL)isMove {
    
    if (isMove) {
        [self scheduleUpdate];
    } else {
        [self unscheduleUpdate];
    }
    
}

@end
