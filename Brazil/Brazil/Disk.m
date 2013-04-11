//
//  Disk.m
//  Brazil
//
//  Created by zhaozilong on 12-12-18.
//
//

#import "Disk.h"

@implementation Disk

- (void)dealloc {
    
    CCLOG(@"Disk dealloc");
    
    [jokerRotForever release], jokerRotForever = nil;
    [elephantRotForever release], rotateForever = nil;
    [rotateForever release], rotateForever = nil;
    [super dealloc];
}

+ (id)diskWithParentNode:(CCNode *)parentNode {
    return [[[self alloc] initWithParentNode:parentNode] autorelease];
}

- (id)initWithParentNode:(CCNode *)parentNode {
    if (self = [super init]) {
        
        node = parentNode;
        
        //打开动画锁
        //        isAnimLocked = NO;
        
        //touch is enabled
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:-1 swallowsTouches:YES];
        
        //screen size
        screenSize = [[CCDirector sharedDirector] winSize];
        
        //initialize egg sprite
        frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        
        frame = [frameCache spriteFrameByName:@"disk.png"];
        diskSprite = [CCSprite spriteWithSpriteFrame:frame];
        //        diskSprite = [CCSprite spriteWithFile:@"disk_new.png"];
        diskSprite.position = ccp(screenSize.width / 2, screenSize.height / 2);
        [parentNode addChild:diskSprite];
        
        frame = [frameCache spriteFrameByName:@"jokerA.png"];
        jokerSprite = [CCSprite spriteWithSpriteFrame:frame];
        jokerSprite.position = ccp(screenSize.width / 2, screenSize.height / 2);
        [parentNode addChild:jokerSprite];
        //        jokerSprite.visible = YES;
        
        
        frame = [frameCache spriteFrameByName:@"elephantA.png"];
        elephantSprite = [CCSprite spriteWithSpriteFrame:frame];
        elephantSprite.visible = NO;
        elephantSprite.scale = 0;
        elephantSprite.position = ccp(screenSize.width / 2, screenSize.height / 2);
        [parentNode addChild:elephantSprite];
        
        rotateForever = [[CCRepeatForever alloc] initWithAction:[CCRotateBy actionWithDuration:5 angle:180]];
        jokerRotForever = [[CCRepeatForever alloc] initWithAction:[CCRotateBy actionWithDuration:5 angle:180]];
        elephantRotForever = [[CCRepeatForever alloc] initWithAction:[CCRotateBy actionWithDuration:5 angle:180]];
        
        [self setDiskRotateByBool:YES];
        
    }
    
    return self;
}

- (void)setDiskRotateByBool:(BOOL)isRotateOn {
    if (isRotateOn) {
        [diskSprite runAction:rotateForever];
        [elephantSprite runAction:elephantRotForever];
        [jokerSprite runAction:jokerRotForever];
    } else {
        [diskSprite stopAction:rotateForever];
        [elephantSprite stopAction:elephantRotForever];
        [jokerSprite stopAction:jokerRotForever];
    }
    
}

- (float)getAngleByPoint1:(CGPoint)posFrom point2:(CGPoint)posTo {
    CGPoint posZero = ccp(screenSize.width / 2, screenSize.height / 2);
    posFrom = ccpSub(posFrom, posZero);
    posTo = ccpSub(posTo, posZero);
    
    float a, b, degreeA, degreeB;
    
    a = atanf(posFrom.y / posFrom.x);
    degreeA = CC_RADIANS_TO_DEGREES(a);
    b = atanf(posTo.y / posTo.x);
    degreeB = CC_RADIANS_TO_DEGREES(b);
    
    float cocosAngle;
    if ((degreeA * degreeB) < 0) {
        cocosAngle = degreeA + degreeB;
    } else {
        cocosAngle = degreeA - degreeB;
    }
    
    return cocosAngle;
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    
    loop = 0;
    
    lastTouchLocation = [CircusScene locationFromTouch:touch];
    
    isTouchHandled = (CGRectContainsPoint([diskSprite boundingBox], lastTouchLocation) || (CGRectContainsPoint([jokerSprite boundingBox], lastTouchLocation) && jokerSprite.visible == YES) || (CGRectContainsPoint([elephantSprite boundingBox], lastTouchLocation) && elephantSprite.visible == YES));
    
    if (isTouchHandled) {
        
        if (CGRectContainsPoint([jokerSprite boundingBox], lastTouchLocation) && jokerSprite.visible == YES) {
            CCLOG(@"小丑");
            [jokerSprite runAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.05 scale:1.1], [CCScaleTo actionWithDuration:0.05 scale:1.0], nil]];
            [self sayEnglishByStr:CIRCUS_JOKER];
            frame = [frameCache spriteFrameByName:@"jokerB.png"];
            [jokerSprite setDisplayFrame:frame];
        } else if (CGRectContainsPoint([elephantSprite boundingBox], lastTouchLocation) && elephantSprite.visible == YES) {
            CCLOG(@"大象");
            [elephantSprite runAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.05 scale:1.1], [CCScaleTo actionWithDuration:0.05 scale:1.0], nil]];
            [self sayEnglishByStr:CIRCUS_ELEPHANT];
            frame = [frameCache spriteFrameByName:@"elephantB.png"];
            [elephantSprite setDisplayFrame:frame];
        }
        [self setDiskRotateByBool:NO];
        
    }
    
    return isTouchHandled;
    
}

-(void) ccTouchMoved:(UITouch*)touch withEvent:(UIEvent *)event
{
	CGPoint currentTouchLocation = [CircusScene locationFromTouch:touch];
    
    float angle = [self getAngleByPoint1:lastTouchLocation point2:currentTouchLocation];
    
    diskSprite.rotation += angle;
    elephantSprite.rotation += angle;
    jokerSprite.rotation += angle;
    
    lastTouchLocation = currentTouchLocation;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    //    isTouchHandled = NO;
    
    [self setDiskRotateByBool:YES];
    
    if (jokerSprite.visible == YES) {
        frame = [frameCache spriteFrameByName:@"jokerA.png"];
        [jokerSprite setDisplayFrame:frame];
    } else if (elephantSprite.visible == YES) {
        frame = [frameCache spriteFrameByName:@"elephantA.png"];
        [elephantSprite setDisplayFrame:frame];
    } else {
        //圆盘是空的
        
    }
    
}

- (void)setElephantAnim {
    CCScaleTo *small = [CCScaleTo actionWithDuration:1 scale:0];
    CCScaleTo *big = [CCScaleTo actionWithDuration:1 scale:1];
    CCHide *hide = [CCHide action];
    CCShow *show = [CCShow action];
    CCSequence *action;
    CCCallBlock *openLock = [CCCallBlock actionWithBlock:^{
        [[CircusScene sharedCircusScene] setIsAnimLocked:NO];
    }];
    
    if (elephantSprite.visible) { //大象存在就消失
        action = [CCSequence actions:small, hide, openLock, nil];
        //        [elephantSprite runAction:action];
    } else if (jokerSprite.visible) { //小丑存在，就用大象替换
        CCSequence *actionB = [CCSequence actions:small, hide, nil];
        action = [CCSequence actions:show, big, openLock, nil];
        [jokerSprite runAction:actionB];
        //        [elephantSprite runAction:action];
        
    } else if (elephantSprite.visible == NO && jokerSprite.visible == NO) { //都不存在，大象出现
        action = [CCSequence actions:show, big, openLock, nil];
        //        [elephantSprite runAction:action];
    }
    
    [elephantSprite runAction:action];
}

- (void)setJokerAnim {
    CCScaleTo *small = [CCScaleTo actionWithDuration:1 scale:0];
    CCScaleTo *big = [CCScaleTo actionWithDuration:1 scale:1];
    CCHide *hide = [CCHide action];
    CCShow *show = [CCShow action];
    CCSequence *action;
    CCCallBlock *openLock = [CCCallBlock actionWithBlock:^{
        [[CircusScene sharedCircusScene] setIsAnimLocked:NO];
    }];
    
    if (jokerSprite.visible) { //小丑存在就消失
        action = [CCSequence actions:small, hide, openLock, nil];
        //        [elephantSprite runAction:action];
    } else if (elephantSprite.visible) { //大象存在，就用小丑替换
        CCSequence *actionB = [CCSequence actions:small, hide, nil];
        action = [CCSequence actions:show, big, openLock, nil];
        [elephantSprite runAction:actionB];
        //        [elephantSprite runAction:action];
        
    } else if (elephantSprite.visible == NO && jokerSprite.visible == NO) { //都不存在，小丑出现
        action = [CCSequence actions:show, big, openLock, nil];
        //        [elephantSprite runAction:action];
    }
    
    [jokerSprite runAction:action];
}

- (void)sayEnglishByStr:(NSString *)name {
    
    BOOL isEn = [[[CircusScene sharedCircusScene] navBar] isEnglish];
    
    if ([name isEqualToString:CIRCUS_ELEPHANT]) {
        [[[CircusScene sharedCircusScene] navBar] setTitleLabelWithString:NSLocalizedStringFromTable(@"elephant", [ZZNavBar getStringEnCnJp], nil)];
        if (isEn) {
            [[SimpleAudioEngine sharedEngine] playEffect:SOUND_ELEPHANT_EN];
        } else {
            if ([ZZNavBar getNumberEnCnJp] == 2) {
                [[SimpleAudioEngine sharedEngine] playEffect:SOUND_ELEPHANT_CN];
            } else {
                [[SimpleAudioEngine sharedEngine] playEffect:SOUND_ELEPHANT_JP];
            }
            
        }
    } else {
        [[[CircusScene sharedCircusScene] navBar] setTitleLabelWithString:NSLocalizedStringFromTable(@"joker", [ZZNavBar getStringEnCnJp], nil)];
        if (isEn) {
            [[SimpleAudioEngine sharedEngine] playEffect:SOUND_JOKER_EN];
        } else {
            if ([ZZNavBar getNumberEnCnJp] == 2) {
                [[SimpleAudioEngine sharedEngine] playEffect:SOUND_JOKER_CN];
            } else {
                [[SimpleAudioEngine sharedEngine] playEffect:SOUND_JOKER_JP];
            }
            
        }
        
    }
}

//判断图像中的透明区域
#if 0
- (int)getPixelColorAtLocation:(CGPoint)point
{
    
    CGContextRef cgctx = [self createARGBBitmapContextFromImage];
    if (cgctx == NULL) { return -1; /* error */ }
    
    size_t w = CGImageGetWidth(inImage);
    size_t h = CGImageGetHeight(inImage);
    
    CGRect rect = {{0,0},{w,h}};
    
    CGContextDrawImage(cgctx, rect, inImage);
    
    unsigned char* data = CGBitmapContextGetData (cgctx);
    
    int alpha;
    if (data != NULL) {
        
        @try {
            int offset = 4*((w*round(point.y))+round(point.x));
            
            alpha =  data[offset];
            
        }
        @catch (NSException * e) {
        }
        @finally {
            
        }
        
    }
    
    
    CGContextRelease(cgctx);
    
    if (data) { free(data); }
    
    return alpha;
}

- (CGContextRef)createARGBBitmapContextFromImage
{
    
    CGContextRef    context = NULL;
    CGColorSpaceRef colorSpace;
    void *          bitmapData;
    int             bitmapByteCount;
    int             bitmapBytesPerRow;
    
    size_t pixelsWide = CGImageGetWidth(inImage);
    size_t pixelsHigh = CGImageGetHeight(inImage);
    
    bitmapBytesPerRow   = (pixelsWide * 4);
    bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);
    
    colorSpace = CGColorSpaceCreateDeviceRGB();
    if (colorSpace == NULL)
        return nil;
    
    bitmapData = malloc( bitmapByteCount );
    if (bitmapData == NULL)
    {
        CGColorSpaceRelease( colorSpace );
        return nil;
    }
    
    context = CGBitmapContextCreate (bitmapData,
                                     pixelsWide,
                                     pixelsHigh,
                                     8,
                                     bitmapBytesPerRow,
                                     colorSpace,
                                     kCGImageAlphaPremultipliedFirst|kCGBitmapByteOrder32Big);
    
    if (context == NULL)
    {
        free (bitmapData);
        fprintf (stderr, "Context not created!");
    }
    
    CGColorSpaceRelease( colorSpace );
    
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    
    return context;
}
#endif



@end

