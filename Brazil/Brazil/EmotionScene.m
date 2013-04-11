//
//  EmotionScene.m
//  Brazil
//
//  Created by zhaozilong on 13-1-6.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "EmotionScene.h"
#import "Position.h"

@interface EmotionScene()
//@property (nonatomic, retain) ZZNavBar *navBar;
@property (nonatomic, retain) NSMutableArray *nums;
@property (nonatomic, retain) NSMutableArray *faces;

@end


@implementation EmotionScene

@synthesize navBar = _navBar;
@synthesize nums;
@synthesize faces;

static EmotionScene *instanceOfEmotionScene;

- (void)dealloc {
    
    
    CCLOG(@"EmotionScene is dealloc");
    [self unloadEffects];
    [nums release];
    [faces release];
    instanceOfEmotionScene = nil;
    
    if ([ZZNavBar isiPad]) {
        if ([ZZNavBar isRetina]) {
            [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"emotion0.plist"];
            [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"emotion1.plist"];
            [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"emotion2.plist"];
        } else {
            [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"emotion.plist"];
        }
    } else {
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"emotion.plist"];
    }
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    [super dealloc];
}

+ (EmotionScene *)sharedEmotionScene {
    
    NSAssert(instanceOfEmotionScene != nil, @"instanceOfEmotionScene is not intialize");
    return instanceOfEmotionScene;
}

+ (id)scene {
    CCScene *scene = [CCScene node];
    EmotionScene *layer = [EmotionScene node];
    
    [scene addChild:layer];
    
    return scene;
}

- (id)init {
    
    if (self = [super init]) {
        instanceOfEmotionScene = self;
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        if ([ZZNavBar isiPad]) {
            if ([ZZNavBar isRetina]) {
                [frameCache addSpriteFramesWithFile:@"emotion0.plist"];
                [frameCache addSpriteFramesWithFile:@"emotion1.plist"];
                [frameCache addSpriteFramesWithFile:@"emotion2.plist"];
            } else {
                [frameCache addSpriteFramesWithFile:@"emotion.plist"];
            }
        } else {
            [frameCache addSpriteFramesWithFile:@"emotion.plist"];
        }
        
        
        //位置数组
        CCArray *positions = [CCArray arrayWithCapacity:4];
        CGFloat Y = 0;
        if ([ZZNavBar isiPad]) {
            Y = -136;
        } else {
            if ([ZZNavBar isiPhone5]) {
                Y = -75;
            } else {
                Y = -80;
            }
        }
        
        [positions addObject:[Position getPosition:ccp(screenSize.width / 4, (screenSize.height + Y) / 4)]];
        [positions addObject:[Position getPosition:ccp(screenSize.width * 3 / 4, (screenSize.height + Y) / 4)]];
        [positions addObject:[Position getPosition:ccp(screenSize.width / 4, (screenSize.height + Y) * 3 / 4)]];
        [positions addObject:[Position getPosition:ccp(screenSize.width * 3 / 4, (screenSize.height + Y) * 3 / 4)]];

        //取得4个互不相等的0-5的随机数
        nums = [[NSMutableArray alloc] initWithCapacity:4];
        for (int i = 0; i <= 3; i++) {
            [nums addObject:[NSNumber numberWithInt:100]];
        }
        int count = 4;
        BOOL isSame = NO;
        do {
            int randNum = arc4random() % 6;
            for (int i = 0; i <= 3; i++) {
                int num = [[nums objectAtIndex:i] intValue];
                if (num == randNum) {
                    isSame = YES;
                    break;
                }
            }
            
            if (!isSame) {
                [nums replaceObjectAtIndex:--count withObject:[NSNumber numberWithInt:randNum]];
            }
            
            isSame = NO;

        } while (count > 0);
        
        //随即设置背景颜色
        [self setBackgroundColor];
        
        //初始化face的位置
        Face *faceSprite;
        faces = [[NSMutableArray alloc] initWithCapacity:4];
        for (int i = 0; i <= 3; i++) {
            Position *temp = [positions objectAtIndex:i];
            faceSprite = [Face faceWithParentNode:self pos:ccp(temp.X, temp.Y) zorder:0 faceTag:[[nums objectAtIndex:i] intValue]];
            [faces addObject:faceSprite];
        }
        
        _navBar = [ZZNavBar node];
        [self addChild:_navBar];
        [_navBar setTitleLabelWithString:NSLocalizedStringFromTable(@"emotion", [ZZNavBar getStringEnCnJp], nil)];
        
    }
    return self;
}

- (void)setFaceZOrderByFaceTag:(int)tag {
    for (Face *face in faces) {
        if (face.tag == tag) {
            face.zOrder = 1;
            [self reorderChild:face z:1];
        } else {
            [self reorderChild:face z:0];
        }
    }
    
}

+(CGPoint) locationFromTouch:(UITouch*)touch
{
	CGPoint touchLocation = [touch locationInView: [touch view]];
	return [[CCDirector sharedDirector] convertToGL:touchLocation];
}

- (void)onExitTransitionDidStart {
    [[CCTouchDispatcher sharedDispatcher] removeAllDelegates];
}

- (void)setBackgroundColor {
    NSMutableSet *allSet = [NSMutableSet set];
    for (int j = 0; j < 6; j++) {
        [allSet addObject:[NSNumber numberWithInt:j]];
    }
    
    NSSet *set = [NSSet setWithArray:nums];
    [allSet minusSet:set];
    int tag = [[allSet anyObject] intValue];
    ccColor4B color;
    switch (tag) {
        case FaceSpriteTagAngry:
            color = ccc4(237, 13, 13, 255);
            break;
            
        case FaceSpriteTagHappy:
            color = ccc4(255, 216, 1, 255);
            break;
            
        case FaceSpriteTagSad:
            color = ccc4(6, 189, 221, 255);
            break;
            
        case FaceSpriteTagScare:
            color = ccc4(109, 224, 195, 255);
            break;
            
        case FaceSpriteTagSmile:
            color = ccc4(234, 123, 191, 255);
            break;
            
        case FaceSpriteTagSurprise:
            color = ccc4(152, 192, 31, 255);
            break;
            
        default:
            color = ccc4(255, 255, 255, 255);
            break;
    }
    CCLayerColor *colorLayer = [CCLayerColor layerWithColor:color];
    [self addChild:colorLayer z:-10];
}


- (void)unloadEffects {
    int num = [nums count];
    int tag = 0;
    for (int i = 0; i < num; i++) {
        tag = [[nums objectAtIndex:0] intValue];
        [self unloadEffectsByTag:tag];
    }
}

- (void)unloadEffectsByTag:(int)faceTag {
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
    
    [[SimpleAudioEngine sharedEngine] unloadEffect:nameEn];
    if ([ZZNavBar getNumberEnCnJp] != 1) {
        [[SimpleAudioEngine sharedEngine] unloadEffect:nameCn];
    }
    
}



@end
