//
//  NoteScene.m
//  Brazil
//
//  Created by zhaozilong on 12-12-16.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "NoteScene.h"

#define NOTE_DO_2_4     @"do2-4"
#define NOTE_DO_1_4     @"do1-4"
#define NOTE_DO_2_2     @"do2-2"
#define NOTE_RE_2_4     @"re2-4"
#define NOTE_MI_2_4     @"mi2-4"
#define NOTE_MI_1_4     @"mi1-4"
#define NOTE_MI_2_2     @"mi2-2"
#define NOTE_SOL_1_4    @"sol1-4"
#define NOTE_SOL_2_2    @"sol2-2"
#define NOTE_LA_1_4     @"la1-4"
#define NOTE_LA_1_2     @"la1-2"
#define NOTE_SI_1_4     @"si1-4"


@implementation NoteScene

@synthesize navBar = _navBar;

static NoteScene *instanceOfNoteScene;

- (void)dealloc {
    CCLOG(@"noteScene dealloc");
    
    [NoteScene unloadEffects];
    instanceOfNoteScene = nil;
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"note.plist"];
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    [super dealloc];
}

+ (NoteScene *)sharedNoteScene {
    NSAssert(instanceOfNoteScene != nil, @"NoteScene not intialize");
    return instanceOfNoteScene;
}

+ (id)scene {
    CCScene *scene = [CCScene node];
    NoteScene *layer = [NoteScene node];
    [scene addChild:layer];
    return scene;
}

- (id)init {
    if (self = [super init]) {
        instanceOfNoteScene = self;
        
        CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        [frameCache addSpriteFramesWithFile:@"note.plist"];
        
        //背景
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        CGPoint bgPoint = CGPointMake(screenSize.width / 2, screenSize.height / 2);
        CCSprite *background;
        if ([ZZNavBar isiPhone5]) {
            background = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"staveBG-568.png"]];
            
        } else {
            background = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"staveBG.png"]];
        }
        background.position = bgPoint;
		[self addChild:background];
        
        //音符和字母
        CGPoint apos, bpos, cpos, dpos, epos, fpos, gpos, hpos, ipos, jpos, kpos, lpos, mpos, npos, opos, ppos, qpos, rpos, spos, tpos, upos, vpos, wpos, xpos, ypos, zpos;
        
        CGPoint napos, nbpos, ncpos, ndpos, nepos, nfpos, ngpos, nhpos, nipos, njpos, nkpos, nlpos, nmpos, nnpos, nopos, nppos, nqpos, nrpos, nspos, ntpos, nupos, nvpos, nwpos, nxpos, nypos, nzpos;
        CGFloat oneBasic;
        CGFloat oneBottom, twoBottom, triBottom, fourBottom;
        CGFloat interval;
        
        
            oneBasic = 193;
            oneBottom = 670; twoBottom = 470; triBottom = 250; fourBottom = 60;
            interval = 55;
            
            //第一小节
            napos = ccp(oneBasic, 777);
            apos = ccp(oneBasic, oneBottom);
            
            nbpos = ccp(oneBasic + interval, 793);
            bpos = ccp(oneBasic + interval, oneBottom);
            
            ncpos = ccp(oneBasic + 2 * interval + 20, 777);
            cpos = ccp(oneBasic + 2 * interval + 20, oneBottom);
            
            ndpos = ccp(oneBasic + 3 * interval + 20, 793);
            dpos = ccp(oneBasic + 3 * interval + 20, oneBottom);
            
            //第二小节
            nepos = ccp(oneBasic + 5.5 * interval, 770);
            epos = ccp(oneBasic + 5.5 * interval, oneBottom);
            
            nfpos = ccp(oneBasic + 6.5 * interval + 10, 793);
            fpos = ccp(oneBasic + 6.5 * interval + 10, oneBottom);
            
            ngpos = ccp(oneBasic + 8 * interval, 798);
            gpos = ccp(oneBasic + 8 * interval, oneBottom);
            
            //第三小节
            nhpos = ccp(oneBasic, 583);
            hpos = ccp(oneBasic, twoBottom);
            
            nipos = ccp(oneBasic + interval, 596);
            ipos = ccp(oneBasic + interval, twoBottom);
            
            njpos = ccp(oneBasic + 2 * interval + 20, 583);
            jpos = ccp(oneBasic + 2 * interval + 20, twoBottom);
            
            nkpos = ccp(oneBasic + 3 * interval + 20, 596);
            kpos = ccp(oneBasic + 3 * interval + 20, twoBottom);
            
            //第四小节
            nlpos = ccp(oneBasic + 5.5 * interval, 572);
            lpos = ccp(oneBasic + 5.5 * interval, twoBottom);
            
            nmpos = ccp(oneBasic + 6.5 * interval + 10, 596);
            mpos = ccp(oneBasic + 6.5 * interval + 10, twoBottom);
            
            nnpos = ccp(oneBasic + 8 * interval, 602);
            npos = ccp(oneBasic + 8 * interval, twoBottom);
            
            //第五小节
            nopos = ccp(oneBasic, 408);
            opos = ccp(oneBasic, triBottom);
            
            nppos = ccp(oneBasic + interval, 353);
            ppos = ccp(oneBasic + interval, triBottom);
            
            nqpos = ccp(oneBasic + 2 * interval + 20, 408);
            qpos = ccp(oneBasic + 2 * interval + 20, triBottom);
            
            //第六小节
            nrpos = ccp(oneBasic + 5.5 * interval, 398);
            rpos = ccp(oneBasic + 5.5 * interval, triBottom);
            
            nspos = ccp(oneBasic + 6.5 * interval + 10, 376);
            spos = ccp(oneBasic + 6.5 * interval + 10, triBottom);
            
            ntpos = ccp(oneBasic + 8 * interval, 360);
            tpos = ccp(oneBasic + 8 * interval, triBottom);
            
            //第七小节
            nupos = ccp(oneBasic, 179);
            upos = ccp(oneBasic, fourBottom);
            
            nvpos = ccp(oneBasic + interval, 197);
            vpos = ccp(oneBasic + interval, fourBottom);
            
            nwpos = ccp(oneBasic + 2 * interval + 20, 179);
            wpos = ccp(oneBasic + 2 * interval + 20, fourBottom);
            
            //第八小节
            nxpos = ccp(oneBasic + 5.5 * interval, 170);
            xpos = ccp(oneBasic + 5.5 * interval, fourBottom);
            
            nypos = ccp(oneBasic + 6.5 * interval + 10, 170);
            ypos = ccp(oneBasic + 6.5 * interval + 10, fourBottom);
            
            nzpos = ccp(oneBasic + 8 * interval, 158);
            zpos = ccp(oneBasic + 8 * interval, fourBottom);
        
        if (![ZZNavBar isiPad]) {
            
            CGFloat x = 0.41667;
            CGFloat y = 0.46875;
            
            //第一小节
            napos = ccp(x * napos.x, y * napos.y);
            apos = ccp(x * apos.x, y * apos.y);
            
            nbpos = ccp(x * nbpos.x, y * nbpos.y);
            bpos = ccp(x * bpos.x, y * bpos.y);
            
            ncpos = ccp(x * ncpos.x, y * ncpos.y);
            cpos = ccp(x * cpos.x, y * cpos.y);
            
            ndpos = ccp(x * ndpos.x, y * ndpos.y);
            dpos = ccp(x * dpos.x, y * dpos.y);
            
            //第二小节
            nepos = ccp(x * nepos.x, y * nepos.y);
            epos = ccp(x * epos.x, y * epos.y);
            
            nfpos = ccp(x * nfpos.x, y * nfpos.y);
            fpos = ccp(x * fpos.x, y * fpos.y);
            
            ngpos = ccp(x * ngpos.x, y * ngpos.y);
            gpos = ccp(x * gpos.x, y * gpos.y);

            //第三小节
            nhpos = ccp(x * nhpos.x, y * nhpos.y);
            hpos = ccp(x * hpos.x, y * hpos.y);
            
            nipos = ccp(x * nipos.x, y * nipos.y);
            ipos = ccp(x * ipos.x, y * ipos.y);
            
            njpos = ccp(x * njpos.x, y * njpos.y);
            jpos = ccp(x * jpos.x, y * jpos.y);
            
            nkpos = ccp(x * nkpos.x, y * nkpos.y);
            kpos = ccp(x * kpos.x, y * kpos.y);
            
            //第四小节
            nlpos = ccp(x * nlpos.x, y * nlpos.y);
            lpos = ccp(x * lpos.x, y * lpos.y);
            
            nmpos = ccp(x * nmpos.x, y * nmpos.y);
            mpos = ccp(x * mpos.x, y * mpos.y);
            
            nnpos = ccp(x * nnpos.x, y * nnpos.y);
            npos = ccp(x * npos.x, y * npos.y);
            
            //第五小节
            nopos = ccp(x * nopos.x, y * nopos.y);
            opos = ccp(x * opos.x, y * opos.y);
            
            nppos = ccp(x * nppos.x, y * nppos.y);
            ppos = ccp(x * ppos.x, y * ppos.y);
            
            nqpos = ccp(x * nqpos.x, y * nqpos.y);
            qpos = ccp(x * qpos.x, y * qpos.y);
            
            //第六小节
            nrpos = ccp(x * nrpos.x, y * nrpos.y);
            rpos = ccp(x * rpos.x, y * rpos.y);
            
            nspos = ccp(x * nspos.x, y * nspos.y);
            spos = ccp(x * spos.x, y * spos.y);
            
            ntpos = ccp(x * ntpos.x, y * ntpos.y);
            tpos = ccp(x * tpos.x, y * tpos.y);
            
            //第七小节
            nupos = ccp(x * nupos.x, y * nupos.y);
            upos = ccp(x * upos.x, y * upos.y);
            
            nvpos = ccp(x * nvpos.x, y * nvpos.y);
            vpos = ccp(x * vpos.x, y * vpos.y);
            
            nwpos = ccp(x * nwpos.x, y * nwpos.y);
            wpos = ccp(x * wpos.x, y * wpos.y);
            
            //第八小节
            nxpos = ccp(x * nxpos.x, y * nxpos.y);
            xpos = ccp(x * xpos.x, y * xpos.y);
            
            nypos = ccp(x * nypos.x, y * nypos.y);
            ypos = ccp(x * ypos.x, y * ypos.y);
            
            nzpos = ccp(x * nzpos.x, y * nzpos.y);
            zpos = ccp(x * zpos.x, y * zpos.y);

        }
        
        //第一小节
        [Note noteWithParentNode:self abPos:apos notePos:napos alphabet:@"A" noteName:NOTE_MI_2_4];
        [Note noteWithParentNode:self abPos:bpos notePos:nbpos alphabet:@"B" noteName:NOTE_SOL_1_4];
        [Note noteWithParentNode:self abPos:cpos notePos:ncpos alphabet:@"C" noteName:NOTE_MI_2_4];
        [Note noteWithParentNode:self abPos:dpos notePos:ndpos alphabet:@"D" noteName:NOTE_SOL_1_4];
        
        //第二小节
        [Note noteWithParentNode:self abPos:epos notePos:nepos alphabet:@"E" noteName:NOTE_RE_2_4];
        [Note noteWithParentNode:self abPos:fpos notePos:nfpos alphabet:@"F" noteName:NOTE_SOL_1_4];
        [Note noteWithParentNode:self abPos:gpos notePos:ngpos alphabet:@"G" noteName:NOTE_SOL_2_2];
        
        //第三小节
        [Note noteWithParentNode:self abPos:hpos notePos:nhpos alphabet:@"H" noteName:NOTE_DO_2_4];
        [Note noteWithParentNode:self abPos:ipos notePos:nipos alphabet:@"I" noteName:NOTE_MI_1_4];
        [Note noteWithParentNode:self abPos:jpos notePos:njpos alphabet:@"J" noteName:NOTE_DO_2_4];
        [Note noteWithParentNode:self abPos:kpos notePos:nkpos alphabet:@"K" noteName:NOTE_MI_1_4];
        
        //第四小节
        [Note noteWithParentNode:self abPos:lpos notePos:nlpos alphabet:@"L" noteName:NOTE_SI_1_4];
        [Note noteWithParentNode:self abPos:mpos notePos:nmpos alphabet:@"M" noteName:NOTE_MI_1_4];
        [Note noteWithParentNode:self abPos:npos notePos:nnpos alphabet:@"N" noteName:NOTE_MI_2_2];
        
        //第五小节
        [Note noteWithParentNode:self abPos:opos notePos:nopos alphabet:@"O" noteName:NOTE_LA_1_4];
        [Note noteWithParentNode:self abPos:ppos notePos:nppos alphabet:@"P" noteName:NOTE_DO_1_4];
        [Note noteWithParentNode:self abPos:qpos notePos:nqpos alphabet:@"Q" noteName:NOTE_LA_1_2];
        
        //第六小节
        [Note noteWithParentNode:self abPos:rpos notePos:nrpos alphabet:@"R" noteName:NOTE_SOL_1_4];
        [Note noteWithParentNode:self abPos:spos notePos:nspos alphabet:@"S" noteName:NOTE_MI_1_4];
        [Note noteWithParentNode:self abPos:tpos notePos:ntpos alphabet:@"T" noteName:NOTE_DO_2_2];
        
        //第七小节
        [Note noteWithParentNode:self abPos:upos notePos:nupos alphabet:@"U" noteName:NOTE_MI_2_4];
        [Note noteWithParentNode:self abPos:vpos notePos:nvpos alphabet:@"V" noteName:NOTE_SOL_1_4];
        [Note noteWithParentNode:self abPos:wpos notePos:nwpos alphabet:@"W" noteName:NOTE_MI_2_2];
        
        //第八小节
        [Note noteWithParentNode:self abPos:xpos notePos:nxpos alphabet:@"X" noteName:NOTE_RE_2_4];
        [Note noteWithParentNode:self abPos:ypos notePos:nypos alphabet:@"Y" noteName:NOTE_RE_2_4];
        [Note noteWithParentNode:self abPos:zpos notePos:nzpos alphabet:@"Z" noteName:NOTE_DO_2_2];

        
        //preload effects
        [NoteScene loadEffects];
        
        //加NavBar
        _navBar = [ZZNavBar node];
        [self addChild:_navBar];
        [_navBar setTitleLabelWithString:NSLocalizedStringFromTable(@"abc", [ZZNavBar getStringEnCnJp], nil)];
        
    }
    return self;
}

+(CGPoint) locationFromTouch:(UITouch*)touch
{
	CGPoint touchLocation = [touch locationInView: [touch view]];
	return [[CCDirector sharedDirector] convertToGL:touchLocation];
}

+ (void)loadEffects {
    [[SimpleAudioEngine sharedEngine] preloadEffect:[NSString stringWithFormat:@"%@.caf", NOTE_DO_1_4]];
    [[SimpleAudioEngine sharedEngine] preloadEffect:[NSString stringWithFormat:@"%@.caf", NOTE_DO_2_2]];
    [[SimpleAudioEngine sharedEngine] preloadEffect:[NSString stringWithFormat:@"%@.caf", NOTE_DO_2_4]];
    [[SimpleAudioEngine sharedEngine] preloadEffect:[NSString stringWithFormat:@"%@.caf", NOTE_RE_2_4]];
    [[SimpleAudioEngine sharedEngine] preloadEffect:[NSString stringWithFormat:@"%@.caf", NOTE_MI_1_4]];
    [[SimpleAudioEngine sharedEngine] preloadEffect:[NSString stringWithFormat:@"%@.caf", NOTE_MI_2_2]];
    [[SimpleAudioEngine sharedEngine] preloadEffect:[NSString stringWithFormat:@"%@.caf", NOTE_MI_2_4]];
    [[SimpleAudioEngine sharedEngine] preloadEffect:[NSString stringWithFormat:@"%@.caf", NOTE_SOL_1_4]];
    [[SimpleAudioEngine sharedEngine] preloadEffect:[NSString stringWithFormat:@"%@.caf", NOTE_SOL_2_2]];
    [[SimpleAudioEngine sharedEngine] preloadEffect:[NSString stringWithFormat:@"%@.caf", NOTE_LA_1_2]];
    [[SimpleAudioEngine sharedEngine] preloadEffect:[NSString stringWithFormat:@"%@.caf", NOTE_LA_1_4]];
    [[SimpleAudioEngine sharedEngine] preloadEffect:[NSString stringWithFormat:@"%@.caf", NOTE_SI_1_4]];
    
}

+ (void)unloadEffects {
    [[SimpleAudioEngine sharedEngine] unloadEffect:[NSString stringWithFormat:@"%@.caf", NOTE_DO_1_4]];
    [[SimpleAudioEngine sharedEngine] unloadEffect:[NSString stringWithFormat:@"%@.caf", NOTE_DO_2_2]];
    [[SimpleAudioEngine sharedEngine] unloadEffect:[NSString stringWithFormat:@"%@.caf", NOTE_DO_2_4]];
    [[SimpleAudioEngine sharedEngine] unloadEffect:[NSString stringWithFormat:@"%@.caf", NOTE_RE_2_4]];
    [[SimpleAudioEngine sharedEngine] unloadEffect:[NSString stringWithFormat:@"%@.caf", NOTE_MI_1_4]];
    [[SimpleAudioEngine sharedEngine] unloadEffect:[NSString stringWithFormat:@"%@.caf", NOTE_MI_2_2]];
    [[SimpleAudioEngine sharedEngine] unloadEffect:[NSString stringWithFormat:@"%@.caf", NOTE_MI_2_4]];
    [[SimpleAudioEngine sharedEngine] unloadEffect:[NSString stringWithFormat:@"%@.caf", NOTE_SOL_1_4]];
    [[SimpleAudioEngine sharedEngine] unloadEffect:[NSString stringWithFormat:@"%@.caf", NOTE_SOL_2_2]];
    [[SimpleAudioEngine sharedEngine] unloadEffect:[NSString stringWithFormat:@"%@.caf", NOTE_LA_1_2]];
    [[SimpleAudioEngine sharedEngine] unloadEffect:[NSString stringWithFormat:@"%@.caf", NOTE_LA_1_4]];
    [[SimpleAudioEngine sharedEngine] unloadEffect:[NSString stringWithFormat:@"%@.caf", NOTE_SI_1_4]];
    
}

- (void)onExitTransitionDidStart {
    [[CCTouchDispatcher sharedDispatcher] removeAllDelegates];
}

@end
