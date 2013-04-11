//
//  Face.m
//  Brazil
//
//  Created by ; on 13-1-6.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "Face.h"


@implementation Face

- (void)dealloc {
    
    CCLOG(@"Face dealloc");
    
    

    [super dealloc];
}

+ (Face *)faceWithParentNode:(CCNode *)parentNode pos:(CGPoint)point zorder:(int)zorder faceTag:(int)tag {
    return [[[self alloc] initWithParentNode:parentNode pos:point zorder:zorder faceTag:tag] autorelease];
}

- (id)initWithParentNode:(CCNode *)parentNode pos:(CGPoint)point zorder:(int)zorder faceTag:(int)faceTag {
    if (self = [super init]) {
        
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:-1 swallowsTouches:YES];
        
        [parentNode addChild:self z:zorder tag:faceTag];
        [self setFaceFrameByTag:self.tag num:0];
        [self loadEffectsByTag:self.tag];
        self.position = point;
        
    }
    return self;
}

- (void)loadEffectsByTag:(int)faceTag {
    NSString *nameEn = nil;
    NSString *nameCn = nil;
    switch (faceTag) {
        case FaceSpriteTagAngry:
            nameEn = SOUND_ANGRY_EN;
            if ([ZZNavBar getNumberEnCnJp] != 1) {
                nameCn = SOUND_ANGRY_JP;
            }
            break;
            
        case FaceSpriteTagHappy:
            nameEn = SOUND_HAPPY_EN;
            
            if ([ZZNavBar getNumberEnCnJp] != 1) {
                nameCn = SOUND_HAPPY_JP;
            }
            break;
            
        case FaceSpriteTagSad:
            nameEn = SOUND_SAD_EN;
            
            if ([ZZNavBar getNumberEnCnJp] != 1) {
                nameCn = SOUND_SAD_JP;
            }
            break;
            
        case FaceSpriteTagScare:
            nameEn = SOUND_SCARE_EN;
            
            if ([ZZNavBar getNumberEnCnJp] != 1) {
                nameCn = SOUND_SCARE_JP;
            }
            break;
            
        case FaceSpriteTagSmile:
            nameEn = SOUND_SMILE_EN;
            
            if ([ZZNavBar getNumberEnCnJp] != 1) {
                nameCn = SOUND_SMILE_JP;
            }
            break;
            
        case FaceSpriteTagSurprise:
            nameEn = SOUND_SURPRISE_EN;
            
            if ([ZZNavBar getNumberEnCnJp] != 1) {
                nameCn = SOUND_SURPRISE_JP;
            }
            break;
            
        default:
            break;
    }
    
    [[SimpleAudioEngine sharedEngine] preloadEffect:nameEn];
    if ([ZZNavBar getNumberEnCnJp] != 1) {
        [[SimpleAudioEngine sharedEngine] preloadEffect:nameCn];
    }
    
}

- (void)setFaceFrameByTag:(int)faceTag num:(int)frameNum {
    CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    NSString *name = nil;
    if (frameNum == 0) {
        switch (faceTag) {
            case FaceSpriteTagAngry:
                name = @"angry0.png";
                break;
                
            case FaceSpriteTagHappy:
                name = @"happy0.png";
                break;
                
            case FaceSpriteTagSad:
                name = @"sad0.png";
                break;
                
            case FaceSpriteTagScare:
                name = @"scare0.png";
                break;
                
            case FaceSpriteTagSmile:
                name = @"smile0.png";
                break;
                
            case FaceSpriteTagSurprise:
                name = @"surprise0.png";
                break;
                
            default:
                break;
        }
    } else {
        switch (faceTag) {
            case FaceSpriteTagAngry:
                name = @"angry1.png";
                break;
                
            case FaceSpriteTagHappy:
                name = @"happy1.png";
                break;
                
            case FaceSpriteTagSad:
                name = @"sad1.png";
                break;
                
            case FaceSpriteTagScare:
                name = @"scare1.png";
                break;
                
            case FaceSpriteTagSmile:
                name = @"smile1.png";
                break;
                
            case FaceSpriteTagSurprise:
                name = @"surprise1.png";
                break;
                
            default:
                break;
        }

    }
    [self setDisplayFrame:[frameCache spriteFrameByName:name]];
}

- (void)setTitleAndSayByTag:(int)faceTag {
    BOOL isEn = [[[EmotionScene sharedEmotionScene] navBar] isEnglish];
    NSString *name = nil;
    NSString *title = nil;
    switch (faceTag) {
        case FaceSpriteTagAngry:
            if (isEn) {
                name = SOUND_ANGRY_EN;
            } else {
                name = SOUND_ANGRY_JP;
            }
            
            title = NSLocalizedStringFromTable(@"angry", [ZZNavBar getStringEnCnJp], nil);
            break;
            
        case FaceSpriteTagHappy:
            if (isEn) {
                name = SOUND_HAPPY_EN;
            } else {
                name = SOUND_HAPPY_JP;
            }
            title = NSLocalizedStringFromTable(@"happy", [ZZNavBar getStringEnCnJp], nil);
            break;
            
        case FaceSpriteTagSad:
            if (isEn) {
                name = SOUND_SAD_EN;
            } else {
                name = SOUND_SAD_JP;
            }
            title = NSLocalizedStringFromTable(@"sad", [ZZNavBar getStringEnCnJp], nil);
            break;
            
        case FaceSpriteTagScare:
            if (isEn) {
                name = SOUND_SCARE_EN;
            } else {
                name = SOUND_SCARE_JP;
            }
            title = NSLocalizedStringFromTable(@"scare", [ZZNavBar getStringEnCnJp], nil);
            break;
            
        case FaceSpriteTagSmile:
            if (isEn) {
                name = SOUND_SMILE_EN;
            } else {
                name = SOUND_SMILE_JP;
            }
            title = NSLocalizedStringFromTable(@"smile", [ZZNavBar getStringEnCnJp], nil);
            break;
            
        case FaceSpriteTagSurprise:
            if (isEn) {
                name = SOUND_SURPRISE_EN;
            } else {
                name = SOUND_SURPRISE_JP;
            }
            title = NSLocalizedStringFromTable(@"surprise", [ZZNavBar getStringEnCnJp], nil);
            break;
            
        default:
            break;
    }
    
    [[SimpleAudioEngine sharedEngine] playEffect:name];
    [[[EmotionScene sharedEmotionScene] navBar] setTitleLabelWithString:title];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint currentTouchPoint = [EmotionScene locationFromTouch:touch];
    BOOL isTouch = CGRectContainsPoint([self boundingBox], currentTouchPoint);
    if (isTouch) {
        [self setTitleAndSayByTag:self.tag];
        [self setFaceFrameByTag:self.tag num:1];
        
        [[EmotionScene sharedEmotionScene] setFaceZOrderByFaceTag:self.tag];
        [self runAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1 scale:1.1], [CCScaleTo actionWithDuration:0.1 scale:1.0], nil]];
        
//        CCLOG(@"zorder is %d", self.vertexZ);
    }
    return isTouch;
}


- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    [self setFaceFrameByTag:self.tag num:0];
}

@end
