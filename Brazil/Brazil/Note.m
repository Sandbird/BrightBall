//
//  Note.m
//  Brazil
//
//  Created by zhaozilong on 12-12-16.
//
//

#import "Note.h"

@implementation Note

- (void)dealloc {
    
    CCLOG(@"note dealloc");
    
    [super dealloc];
}

+ (id)noteWithParentNode:(CCNode *)parentNode abPos:(CGPoint)abPoint notePos:(CGPoint)notePoint alphabet:(NSString *)abStr noteName:(NSString *)noteStr  {
    return [[[self alloc] initWithParentNode:parentNode abPos:abPoint notePos:notePoint alphabet:abStr noteName:noteStr] autorelease];
}

- (id)initWithParentNode:(CCNode *)parentNode abPos:(CGPoint)abPoint notePos:(CGPoint)notePoint alphabet:(NSString *)receivedAbStr noteName:(NSString *)receivedNoteStr {
    if (self = [super init]) {
        
        //打开动画锁
//        isAnimLocked = NO;
        
        //touch is enabled
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:-1 swallowsTouches:YES];
        
        //screen size
//        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        //字母和音符的名称
        noteStr = receivedNoteStr;
        abStr = receivedAbStr;
        
        
        //initialize egg sprite
        frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        
        //note
        frame = [frameCache spriteFrameByName:[NSString stringWithFormat:@"%@.png", noteStr]];
        noteSprite = [CCSprite spriteWithSpriteFrame:frame];
        [parentNode addChild:noteSprite];
        noteSprite.anchorPoint = ccp(0.5, 1);
        noteSprite.position = notePoint;
        
        //alphabet
        frame = [frameCache spriteFrameByName:[NSString stringWithFormat:@"%@.png", abStr]];
        abSprite = [CCSprite spriteWithSpriteFrame:frame];
        [parentNode addChild:abSprite];
        abSprite.anchorPoint = ccp(0.5, 1);
        abSprite.position = abPoint;
        
    }
    
    return self;
}

- (void)setNavBarTitleByNote:(NSString *)str {
    
    NSString *title = NSLocalizedStringFromTable(str, [ZZNavBar getStringEnCnJp], nil);
    [[[NoteScene sharedNoteScene] navBar] setTitleLabelWithString:title];
}

- (void)setNavBarTitleByAlpha:(NSString *)str {
    NSString *title = nil;
    if ([str isEqualToString:@"A"]) {
        title = @"A\na";
    } else if ([str isEqualToString:@"B"]) {
        title = @"B\nb";
    } else if ([str isEqualToString:@"C"]) {
        title = @"C\nc";
    } else if ([str isEqualToString:@"D"]) {
        title = @"D\nd";
    } else if ([str isEqualToString:@"E"]) {
        title = @"E\ne";
    } else if ([str isEqualToString:@"F"]) {
        title = @"F\nf";
    } else if ([str isEqualToString:@"G"]) {
        title = @"G\ng";
    } else if ([str isEqualToString:@"H"]) {
        title = @"H\nh";
    } else if ([str isEqualToString:@"I"]) {
        title = @"I\ni";
    } else if ([str isEqualToString:@"J"]) {
        title = @"J\nj";
    } else if ([str isEqualToString:@"K"]) {
        title = @"K\nk";
    } else if ([str isEqualToString:@"L"]) {
        title = @"L\nl";
    } else if ([str isEqualToString:@"M"]) {
        title = @"M\nm";
    } else if ([str isEqualToString:@"N"]) {
        title = @"N\nn";
    } else if ([str isEqualToString:@"O"]) {
        title = @"O\no";
    } else if ([str isEqualToString:@"P"]) {
        title = @"P\np";
    } else if ([str isEqualToString:@"Q"]) {
        title = @"Q\nq";
    } else if ([str isEqualToString:@"R"]) {
        title = @"R\nr";
    } else if ([str isEqualToString:@"S"]) {
        title = @"S\ns";
    } else if ([str isEqualToString:@"T"]) {
        title = @"T\nt";
    } else if ([str isEqualToString:@"U"]) {
        title = @"U\nu";
    } else if ([str isEqualToString:@"V"]) {
        title = @"V\nv";
    } else if ([str isEqualToString:@"W"]) {
        title = @"W\nw";
    } else if ([str isEqualToString:@"X"]) {
        title = @"X\nx";
    } else if ([str isEqualToString:@"Y"]) {
        title = @"Y\ny";
    } else {
        title = @"Z\nz";
    }
    
    [[[NoteScene sharedNoteScene] navBar] setTitleLabelWithString:title];
}


- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    
    lastTouchLocation = [NoteScene locationFromTouch:touch];
    isTouchHandled = (CGRectContainsPoint([noteSprite boundingBox], lastTouchLocation) || CGRectContainsPoint([abSprite boundingBox], lastTouchLocation));
    
    if (isTouchHandled) {
        
        if (CGRectContainsPoint([noteSprite boundingBox], lastTouchLocation)) {
            [self setNavBarTitleByNote:noteStr];
            [[SimpleAudioEngine sharedEngine] playEffect:[NSString stringWithFormat:@"%@.caf", noteStr]];
            [noteSprite runAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1 scale:1.1], [CCScaleTo actionWithDuration:0.1 scale:1.0], nil]];
        } else {
            [self setNavBarTitleByAlpha:abStr];
            [[SimpleAudioEngine sharedEngine] playEffect:[NSString stringWithFormat:@"%@.caf", abStr]];
            [abSprite runAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1 scale:1.1], [CCScaleTo actionWithDuration:0.1 scale:1.0], nil]];
        }
    }
    
    return isTouchHandled;
}


@end
