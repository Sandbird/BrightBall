//
//  ChooseBallLayer.m
//  Brazil
//
//  Created by zhaozilong on 12-10-29.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "ChooseBallLayer.h"
#import "MainScene.h"
#import "CCAnimationHelper.h"

#define PAGE_1 11111
#define PAGE_2 22222
#define PAGE_3 33333


@implementation ChooseBallLayer

static ChooseBallLayer *instanceOfChooseBall;

- (void)dealloc {
    
    instanceOfChooseBall = nil;
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"choose.plist"];
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    [super dealloc];
}

+ (ChooseBallLayer *)sharedChooseBall {
    
    NSAssert(instanceOfChooseBall != nil, @"ChooseBallLayer is not yet initialize!");
    return instanceOfChooseBall;
}

+ (CCScene *)scene {
    CCScene *scene = [CCScene node];
    ChooseBallLayer *layer = [ChooseBallLayer node];
    [scene addChild:layer];
    
    return scene;
}

- (id)init {
    
    if (self = [super init]) {
        
        instanceOfChooseBall = self;
        
        self.isTouchEnabled = YES;
        
        CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        [frameCache addSpriteFramesWithFile:@"choose.plist"];
        
        screenSize = [[CCDirector sharedDirector] winSize];
        
        CCLayerColor *color = [CCLayerColor layerWithColor:ccc4(178, 226, 233, 255)];
        [self addChild:color z:-15];
        
        CCSprite *background = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"mainBG.png"]];
        [self addChild:background z:-1];
        background.position = ccp(screenSize.width / 2, background.contentSize.height / 2);
        
        backSprite = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"back.png"]];
        [self addChild:backSprite];
        CGPoint backPos;
        CGPoint cloud1Pos, cloud2Pos, cloud3Pos, cloud4Pos, cloud5Pos;
        CGFloat pageY;
        if ([ZZNavBar isiPad]) {
            backPos = ccp(70, 950);
            
            cloud3Pos = ccp(100, 200);
            cloud1Pos = ccp(250, 70);
            cloud5Pos = ccp(330, 230);
            cloud4Pos = ccp(540, 100);
            cloud2Pos = ccp(700, 200);
            
            pageY = 450;

        } else {
            CGFloat x = 0.41667;
            CGFloat y = 0.46875;
            if ([ZZNavBar isiPhone5]) {
                backPos = ccp(x * 70, y * 950 + 90);
                
                pageY = 260;
            } else {
                backPos = ccp(x * 70, y * 950);
                
                pageY = 220;
            }
            
            cloud3Pos = ccp(x * 100, y * 200);
            cloud1Pos = ccp(x * 250, y * 70);
            cloud5Pos = ccp(x * 330, y * 230);
            cloud4Pos = ccp(x * 540, y * 100);
            cloud2Pos = ccp(x * 700, y * 200);
        }
        backSprite.position = backPos;
        
        //初始化三个位置
        currPoint = ccp(0, 0);
        lastPoint = ccp(-screenSize.width, 0);
        nextPoint = ccp(screenSize.width, 0);
            
        //初始化每一页的位置
        [self setPageInitialPostion];
        
        //初始化pageControl
        pageControl = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"page0.png"]];
        [self addChild:pageControl];
        pageControl.position = ccp(screenSize.width / 2, screenSize.height / 2 + pageY);
        
        //云彩的初始化
        CCSpriteFrame *frame;
        cloudArray = [[CCArray alloc] initWithCapacity:5];
        frame = [frameCache spriteFrameByName:@"cloud-0.png"];
        CCSprite *cloudSprite = [CCSprite spriteWithSpriteFrame:frame];
        [self addChild:cloudSprite z:1 tag:0];
        cloudSprite.position = cloud1Pos;
        [cloudArray addObject:cloudSprite];
        
        frame = [frameCache spriteFrameByName:@"cloud-1.png"];
        cloudSprite = [CCSprite spriteWithSpriteFrame:frame];
        [self addChild:cloudSprite z:-1 tag:1];
        cloudSprite.position = cloud2Pos;
        [cloudArray addObject:cloudSprite];
        
        frame = [frameCache spriteFrameByName:@"cloud-2.png"];
        cloudSprite = [CCSprite spriteWithSpriteFrame:frame];
        [self addChild:cloudSprite z:-1 tag:2];
        cloudSprite.position = cloud3Pos;
        [cloudArray addObject:cloudSprite];
        
        frame = [frameCache spriteFrameByName:@"cloud-3.png"];
        rateCloudSprite = [CCSprite spriteWithSpriteFrame:frame];
        [self addChild:rateCloudSprite z:1 tag:3];
        rateCloudSprite.position = cloud4Pos;
        [cloudArray addObject:rateCloudSprite];
        
        frame = [frameCache spriteFrameByName:@"cloud-4.png"];
        cloudSprite = [CCSprite spriteWithSpriteFrame:frame];
        [self addChild:cloudSprite z:1 tag:4];
        cloudSprite.position = cloud5Pos;
        [cloudArray addObject:cloudSprite];
        
        speedArray = [[CCArray alloc] initWithCapacity:5];
		[speedArray addObject:[NSNumber numberWithFloat:0.3f]];//0
		[speedArray addObject:[NSNumber numberWithFloat:0.4f]];//1
		[speedArray addObject:[NSNumber numberWithFloat:0.5f]];//2
        [speedArray addObject:[NSNumber numberWithFloat:0.6f]];//3
        [speedArray addObject:[NSNumber numberWithFloat:0.7f]];//4
		NSAssert([speedArray count] == 5, @"speedFactors count does not match numStripes!");
        
        [self scheduleUpdate];
    }
    
    return self;
}

- (void)setPageInitialPostion {
    
    secondPage = [SecondPage node];
    [self addChild:secondPage z:1 tag:PAGE_3];
    secondPage.position = lastPoint;
    lastLayer = secondPage;
    
    thirdPage = [ThirdPage node];
    [self addChild:thirdPage z:1 tag:PAGE_1];
    thirdPage.position = currPoint;
    currLayer = thirdPage;
    
    firstPage = [FirstPage node];
    [self addChild:firstPage z:1 tag:PAGE_2];
    firstPage.position = nextPoint;
    nextLayer = firstPage;
 
}

- (void)transToMainScene {
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[MainScene scene] withColor:ccRED]];
}

+ (CGPoint) locationFromTouch:(UITouch*)touch
{
	CGPoint touchLocation = [touch locationInView: [touch view]];
	return [[CCDirector sharedDirector] convertToGL:touchLocation];
}


-(void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:-1 swallowsTouches:YES];
}

- (void)update:(ccTime)delta {
    CCSprite* sprite;
	CCARRAY_FOREACH(cloudArray, sprite)
	{
		NSNumber* factor = [speedArray objectAtIndex:sprite.tag];
		CGPoint pos = sprite.position;
		pos.x -= 2 * [factor floatValue];
        
		// Reposition stripes when they're out of bounds
		if (pos.x < -rateCloudSprite.contentSize.width / 2)
		{
            pos.x += (screenSize.width + rateCloudSprite.contentSize.width);
		}
		
		sprite.position = pos;
	}
    
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    lastTouchLocation = [ChooseBallLayer locationFromTouch:touch];
    currentTouchPoint = lastTouchLocation;
    isTouchEnabled_ = (CGRectContainsPoint(backSprite.boundingBox, lastTouchLocation) || CGRectContainsPoint(firstPage.boundingBox, lastTouchLocation) || CGRectContainsPoint(thirdPage.boundingBox, lastTouchLocation) || CGRectContainsPoint(secondPage.boundingBox, lastTouchLocation));
    if (isTouchEnabled_) {
        if (CGRectContainsPoint(backSprite.boundingBox, lastTouchLocation)) {
            backSprite.scale = 1.1;
        } else {
              
        }
        
    }
    return isTouchEnabled_;
}

-(void) ccTouchMoved:(UITouch*)touch withEvent:(UIEvent *)event
{
    
	CGPoint currentTouchLocation = [ChooseBallLayer locationFromTouch:touch];
    
	// Take the difference of the current to the last touch location.
	CGPoint moveTo = ccpSub(lastTouchLocation, currentTouchLocation);
	// Then reverse it since the goal is not to give the impression of moving the camera over the background,
	// but to touch and move the background.
	moveTo = ccpMult(moveTo, -1);
	
	lastTouchLocation = currentTouchLocation;
	
    currLayer.position = ccpAdd(currLayer.position, ccp(moveTo.x, 0));
    lastLayer.position = ccpAdd(lastLayer.position, ccp(moveTo.x, 0));
    nextLayer.position = ccpAdd(nextLayer.position, ccp(moveTo.x, 0));
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    
    CGFloat halfScreenPosX = screenSize.width / 3;
    if (CGRectContainsPoint(backSprite.boundingBox, currentTouchPoint)) {
        backSprite.scale = 1.0;
        [ZZNavBar playBackEffect];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[MainScene scene] withColor:ccWHITE]];
    } else {
        if (currLayer.position.x > halfScreenPosX) {
            
            [currLayer runAction:[CCMoveTo actionWithDuration:0.2 position:nextPoint]];
            [lastLayer runAction:[CCMoveTo actionWithDuration:0.2 position:currPoint]];
            [self setPagePostionByTag:lastLayer.tag];
            
        } else if (currLayer.position.x < -halfScreenPosX) {
            
            [currLayer runAction:[CCMoveTo actionWithDuration:0.2 position:lastPoint]];
            [nextLayer runAction:[CCMoveTo actionWithDuration:0.2 position:currPoint]];
            [self setPagePostionByTag:nextLayer.tag];
            
        } else {
            [currLayer runAction:[CCMoveTo actionWithDuration:0.2 position:currPoint]];
            [lastLayer runAction:[CCMoveTo actionWithDuration:0.2 position:lastPoint]];
            [nextLayer runAction:[CCMoveTo actionWithDuration:0.2 position:nextPoint]];
        }

    }
}

- (void)setPagePostionByTag:(int)pageTag {
    
    CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    NSString *pageName = nil;
    switch (pageTag) {
        case PAGE_1:
            secondPage.position = lastPoint;
            thirdPage.position = currPoint;
            firstPage.position = nextPoint;
            
            lastLayer = secondPage;
            currLayer = thirdPage;
            nextLayer = firstPage;
            
            pageName = @"page0.png";

            
            break;
            
        case PAGE_2:
            thirdPage.position = lastPoint;
            firstPage.position = currPoint;
            secondPage.position = nextPoint;
            
            lastLayer = thirdPage;
            currLayer = firstPage;
            nextLayer = secondPage;
            
            pageName = @"page1.png";

            break;
            
        case PAGE_3:
            firstPage.position = lastPoint;
            secondPage.position = currPoint;
            thirdPage.position = nextPoint;
            
            lastLayer = firstPage;
            currLayer = secondPage;
            nextLayer = thirdPage;
            
            pageName = @"page2.png";
            
            break;
            
        default:
            break;
    }
    
    [pageControl setDisplayFrame:[frameCache spriteFrameByName:pageName]];
    
}


@end
