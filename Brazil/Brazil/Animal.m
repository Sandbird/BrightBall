//
//  Animal.m
//  Brazil
//
//  Created by zhaozilong on 12-12-11.
//
//

#import "Animal.h"
#import "CCAnimationHelper.h"
#import "ZooScene.h"

#define ANIMAL_0_TAG 0
#define ANIMAL_1_TAG 1
#define ANIMAL_2_TAG 2
#define ANIMAL_3_TAG 3
#define ANIMAL_4_TAG 4


@implementation Animal
@synthesize delegate = _delegate;

- (void)dealloc {
    
    CCLOG(@"animal is dealloc");
     
    [_delegate release], _delegate = nil;
    [super dealloc];
}

+ (id)animalWithParentNode:(CCNode *)parentNode pos:(CGPoint)point prefix:(int)animalSuffix  {
    return [[[self alloc] initWithParentNode:parentNode pos:point prefix:animalSuffix] autorelease];
}

- (id)initWithParentNode:(CCNode *)parentNode pos:(CGPoint)point prefix:(int)animalSuffix {
    if (self = [super init]) {
        
        node = parentNode;
        
        //打开动画锁
        isAnimLocked = NO;
        
        //touch is enabled
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:-1 swallowsTouches:YES];
        
        //screen size
        screenSize = [[CCDirector sharedDirector] winSize];
        halfScreenPosX = screenSize.width / 3;
        
        //preload effect
        [Animal loadEffects];
        
        
        //initialize egg sprite
        frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        
        switch (animalSuffix) {
            case 1:
                //上部分位置
                if ([ZZNavBar isiPad]) {
                    postion = ccp(0, 419);
                } else {
                    if ([ZZNavBar isiPhone5]) {
                        postion = ccp(0, 245);
                    } else {
                        postion = ccp(0, 201);
                    }
                }
                
                lastPostion = ccpSub(postion, ccp(screenSize.width, 0));
                nextPostion = ccpAdd(postion, ccp(screenSize.width, 0));
                [self setAnimalUpPostion];
                break;
                
            case 2:
                //中间位置
                if ([ZZNavBar isiPad]) {
                    postion = ccp(0, 234.5);
                } else {
                    if ([ZZNavBar isiPhone5]) {
                        postion = ccp(0, 168.5);
                    } else {
                        postion = ccp(0, 125);
                    }
                }
                
                lastPostion = ccpSub(postion, ccp(screenSize.width, 0));
                nextPostion = ccpAdd(postion, ccp(screenSize.width, 0));
                [self setAnimalMiddlePostion];
                break;
                
            case 3:
                //下部分位置
                
                postion = ccp(0, 0);
                lastPostion = ccpSub(postion, ccp(screenSize.width, 0));
                nextPostion = ccpAdd(postion, ccp(screenSize.width, 0));
                [self setAnimalBottomPostion];
                break;
                
            default:
                break;
        }

    }
    
    return self;
}

+ (void)loadEffects {
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"click.caf"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"click2.caf"];
}

- (void)setAnimalUpPostion {
    
    CCAnimation *anim;
    CCRepeatForever *repeat;
    
    //动物
    frame = [frameCache spriteFrameByName:@"lion0.png"];
    animalSprite_0 = [CCSprite spriteWithSpriteFrame:frame];
    [node addChild:animalSprite_0];
    animalSprite_0.anchorPoint = ccp(0, 0);
    animalSprite_0.position = lastPostion;
    animalSprite_0.tag = ANIMAL_0_TAG;
    lastSprite = animalSprite_0;
    
    anim = [CCAnimation animationWithFrame:@"lion" frameCount:2 delay:0.5];
    repeat = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:anim]];
    [animalSprite_0 runAction:repeat];
    
    
    frame = [frameCache spriteFrameByName:@"panda0.png"];
    animalSprite_1 = [CCSprite spriteWithSpriteFrame:frame];
    [node addChild:animalSprite_1];
    animalSprite_1.anchorPoint = ccp(0, 0);
    animalSprite_1.position = postion;
    animalSprite_1.tag = ANIMAL_1_TAG;
    currentSprite = animalSprite_1;
    
    anim = [CCAnimation animationWithFrame:@"panda" frameCount:2 delay:0.5];
    repeat = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:anim]];
    [animalSprite_1 runAction:repeat];
    
    frame = [frameCache spriteFrameByName:@"orangutan0.png"];
    animalSprite_2 = [CCSprite spriteWithSpriteFrame:frame];
    [node addChild:animalSprite_2];
    animalSprite_2.anchorPoint = ccp(0, 0);
    animalSprite_2.position = nextPostion;
    animalSprite_2.tag = ANIMAL_2_TAG;
    nextSprite = animalSprite_2;
    
    anim = [CCAnimation animationWithFrame:@"orangutan" frameCount:2 delay:0.5];
    repeat = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:anim]];
    [animalSprite_2 runAction:repeat];
    
    frame = [frameCache spriteFrameByName:@"cow0.png"];
    animalSprite_3 = [CCSprite spriteWithSpriteFrame:frame];
    animalSprite_3.tag = ANIMAL_3_TAG;
    [node addChild:animalSprite_3];
    animalSprite_3.anchorPoint = ccp(0, 0);
    animalSprite_3.visible = NO;
    
    anim = [CCAnimation animationWithFrame:@"cow" frameCount:2 delay:0.5];
    repeat = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:anim]];
    [animalSprite_3 runAction:repeat];
    
    frame = [frameCache spriteFrameByName:@"elephant0.png"];
    animalSprite_4 = [CCSprite spriteWithSpriteFrame:frame];
    animalSprite_4.tag = ANIMAL_4_TAG;
    [node addChild:animalSprite_4];
    animalSprite_4.anchorPoint = ccp(0, 0);
    animalSprite_4.visible = NO;
    
    anim = [CCAnimation animationWithFrame:@"elephant" frameCount:2 delay:0.5];
    repeat = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:anim]];
    [animalSprite_4 runAction:repeat];

}


- (void)setAnimalMiddlePostion {
    //动物
    frame = [frameCache spriteFrameByName:@"elephant2.png"];
    animalSprite_0 = [CCSprite spriteWithSpriteFrame:frame];
    [node addChild:animalSprite_0];
    animalSprite_0.anchorPoint = ccp(0, 0);
    animalSprite_0.position = lastPostion;
    animalSprite_0.tag = ANIMAL_0_TAG;
    lastSprite = animalSprite_0;
    
    frame = [frameCache spriteFrameByName:@"orangutan2.png"];
    animalSprite_1 = [CCSprite spriteWithSpriteFrame:frame];
    [node addChild:animalSprite_1];
    animalSprite_1.anchorPoint = ccp(0, 0);
    animalSprite_1.position = postion;
    animalSprite_1.tag = ANIMAL_1_TAG;
    currentSprite = animalSprite_1;
    
    frame = [frameCache spriteFrameByName:@"lion2.png"];
    animalSprite_2 = [CCSprite spriteWithSpriteFrame:frame];
    [node addChild:animalSprite_2];
    animalSprite_2.anchorPoint = ccp(0, 0);
    animalSprite_2.position = nextPostion;
    animalSprite_2.tag = ANIMAL_2_TAG;
    nextSprite = animalSprite_2;
    
    frame = [frameCache spriteFrameByName:@"panda2.png"];
    animalSprite_3 = [CCSprite spriteWithSpriteFrame:frame];
    animalSprite_3.tag = ANIMAL_3_TAG;
    [node addChild:animalSprite_3];
    animalSprite_3.anchorPoint = ccp(0, 0);
    animalSprite_3.visible = NO;
    
    frame = [frameCache spriteFrameByName:@"cow2.png"];
    animalSprite_4 = [CCSprite spriteWithSpriteFrame:frame];
    animalSprite_4.tag = ANIMAL_4_TAG;
    [node addChild:animalSprite_4];
    animalSprite_4.anchorPoint = ccp(0, 0);
    animalSprite_4.visible = NO;
    
}

//狮子，熊猫，猩猩，奶牛，大象
//大象，猩猩，狮子，熊猫，奶牛
//奶牛，大象，猩猩，狮子，熊猫


- (void)setAnimalBottomPostion {
    //动物
    frame = [frameCache spriteFrameByName:@"cow3.png"];
    animalSprite_0 = [CCSprite spriteWithSpriteFrame:frame];
    [node addChild:animalSprite_0];
    animalSprite_0.anchorPoint = ccp(0, 0);
    animalSprite_0.position = lastPostion;
    animalSprite_0.tag = ANIMAL_0_TAG;
    lastSprite = animalSprite_0;
    
    frame = [frameCache spriteFrameByName:@"elephant3.png"];
    animalSprite_1 = [CCSprite spriteWithSpriteFrame:frame];
    [node addChild:animalSprite_1];
    animalSprite_1.anchorPoint = ccp(0, 0);
    animalSprite_1.position = postion;
    animalSprite_1.tag = ANIMAL_1_TAG;
    currentSprite = animalSprite_1;
    
    frame = [frameCache spriteFrameByName:@"orangutan3.png"];
    animalSprite_2 = [CCSprite spriteWithSpriteFrame:frame];
    [node addChild:animalSprite_2];
    animalSprite_2.anchorPoint = ccp(0, 0);
    animalSprite_2.position = nextPostion;
    animalSprite_2.tag = ANIMAL_2_TAG;
    nextSprite = animalSprite_2;
    
    frame = [frameCache spriteFrameByName:@"lion3.png"];
    animalSprite_3 = [CCSprite spriteWithSpriteFrame:frame];
    animalSprite_3.tag = ANIMAL_3_TAG;
    [node addChild:animalSprite_3];
    animalSprite_3.anchorPoint = ccp(0, 0);
    animalSprite_3.visible = NO;
    
    frame = [frameCache spriteFrameByName:@"panda3.png"];
    animalSprite_4 = [CCSprite spriteWithSpriteFrame:frame];
    animalSprite_4.tag = ANIMAL_4_TAG;
    [node addChild:animalSprite_4];
    animalSprite_4.anchorPoint = ccp(0, 0);
    animalSprite_4.visible = NO;
    
}

- (int)getCurrentAnimalTag {
    return currentSprite.tag;
}



- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    
    lastTouchLocation = [ZooScene locationFromTouch:touch];
    
    isTouchHandled = CGRectContainsPoint([currentSprite boundingBox], lastTouchLocation);
    
    if (isTouchHandled) {
        interval = 0;
    }
    
    return isTouchHandled;
    
}

-(void) ccTouchMoved:(UITouch*)touch withEvent:(UIEvent *)event
{
    
	CGPoint currentTouchLocation = [ZooScene locationFromTouch:touch];
    
    if (++interval % 7 == 0 || interval <= 3) {
        CCLOG(@"moved...");
        [[SimpleAudioEngine sharedEngine] playEffect:@"click2.caf"];
    }
	
	// Take the difference of the current to the last touch location.
	CGPoint moveTo = ccpSub(lastTouchLocation, currentTouchLocation);
	// Then reverse it since the goal is not to give the impression of moving the camera over the background,
	// but to touch and move the background.
	moveTo = ccpMult(moveTo, -1);
	
	lastTouchLocation = currentTouchLocation;
	
	// Adjust the layer's position accordingly, this will change the position of all nodes it contains too.
    currentSprite.position = ccpAdd(currentSprite.position, ccp(moveTo.x, 0));
    lastSprite.position = ccpAdd(lastSprite.position, ccp(moveTo.x, 0));
    nextSprite.position = ccpAdd(nextSprite.position, ccp(moveTo.x, 0));
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    isTouchHandled = NO;
    
    if (currentSprite.position.x > halfScreenPosX) {
        
        [currentSprite runAction:[CCMoveTo actionWithDuration:0.2 position:nextPostion]];
        [lastSprite runAction:[CCMoveTo actionWithDuration:0.2 position:postion]];
        [self setAnimalPostionByAnimalTag:lastSprite.tag];
    } else if (currentSprite.position.x < -halfScreenPosX) {
        [currentSprite runAction:[CCMoveTo actionWithDuration:0.2 position:lastPostion]];
        [nextSprite runAction:[CCMoveTo actionWithDuration:0.2 position:postion]];
        [self setAnimalPostionByAnimalTag:nextSprite.tag];
    } else {
        [currentSprite runAction:[CCMoveTo actionWithDuration:0.2 position:postion]];
        [lastSprite runAction:[CCMoveTo actionWithDuration:0.2 position:lastPostion]];
        [nextSprite runAction:[CCMoveTo actionWithDuration:0.2 position:nextPostion]];
    }
    
    [_delegate animalIsMatch];
    
    // Move the game layer back to its designated position.
//	CCMoveTo* move = [CCMoveTo actionWithDuration:0.1 position:defaultPosition];
//	CCEaseIn* ease = [CCEaseIn actionWithAction:move rate:0.5f];
    
//	[currentSprite runAction:ease];
    
}

- (void)setAnimalPostionByAnimalTag:(int)animalTag {
    switch (animalTag) {
        case ANIMAL_0_TAG:
            animalSprite_4.position = lastPostion;
            animalSprite_0.position = postion;
            animalSprite_1.position = nextPostion;
            
            animalSprite_4.visible = YES;
            animalSprite_0.visible = YES;
            animalSprite_1.visible = YES;
            animalSprite_2.visible = NO;
            animalSprite_3.visible = NO;
            
            lastSprite = animalSprite_4;
            currentSprite = animalSprite_0;
            nextSprite = animalSprite_1;
            break;
            
        case ANIMAL_1_TAG:
            animalSprite_0.position = lastPostion;
            animalSprite_1.position = postion;
            animalSprite_2.position = nextPostion;
            
            animalSprite_0.visible = YES;
            animalSprite_1.visible = YES;
            animalSprite_2.visible = YES;
            animalSprite_3.visible = NO;
            animalSprite_4.visible = NO;
            
            lastSprite = animalSprite_0;
            currentSprite = animalSprite_1;
            nextSprite = animalSprite_2;
            break;
            
        case ANIMAL_2_TAG:
            animalSprite_1.position = lastPostion;
            animalSprite_2.position = postion;
            animalSprite_3.position = nextPostion;
            
            animalSprite_1.visible = YES;
            animalSprite_2.visible = YES;
            animalSprite_3.visible = YES;
            animalSprite_4.visible = NO;
            animalSprite_0.visible = NO;
            
            lastSprite = animalSprite_1;
            currentSprite = animalSprite_2;
            nextSprite = animalSprite_3;
            break;
            
        case ANIMAL_3_TAG:
            animalSprite_2.position = lastPostion;
            animalSprite_3.position = postion;
            animalSprite_4.position = nextPostion;
            
            animalSprite_2.visible = YES;
            animalSprite_3.visible = YES;
            animalSprite_4.visible = YES;
            animalSprite_0.visible = NO;
            animalSprite_1.visible = NO;
            
            lastSprite = animalSprite_2;
            currentSprite = animalSprite_3;
            nextSprite = animalSprite_4;
            break;
            
        case ANIMAL_4_TAG:
            animalSprite_3.position = lastPostion;
            animalSprite_4.position = postion;
            animalSprite_0.position = nextPostion;
            
            animalSprite_3.visible = YES;
            animalSprite_4.visible = YES;
            animalSprite_0.visible = YES;
            animalSprite_1.visible = NO;
            animalSprite_2.visible = NO;
            
            lastSprite = animalSprite_3;
            currentSprite = animalSprite_4;
            nextSprite = animalSprite_0;
            break;
            
        default:
            break;
    }

}

- (void)setAnimalRightAnim {
    
//    [currentSprite runAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1 scale:1.1], [CCScaleTo actionWithDuration:0.1 scale:1.0], nil]];
}

@end
