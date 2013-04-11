//
//  SeasideScene.h
//  Brazil
//
//  Created by zhaozilong on 13-1-24.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ZZNavBar.h"

#define SOUND_FIREWORKS_EN @"firework-en.caf"
#define SOUND_MOON_EN @"moon-en.caf"
#define SOUND_STAR_EN @"star-en.caf"
#define SOUND_SEA_EN @"sea-en.caf"
#define SOUND_STARFISH_EN @"starfish-en.caf"
#define SOUND_UMBRELLA_EN @"umbrella-en.caf"
#define SOUND_SEASHELL_EN @"seashell-en.caf"

#define SOUND_FIREWORKS_CN @"firework-cn.caf"
#define SOUND_MOON_CN @"moon-cn.caf"
#define SOUND_STAR_CN @"star-cn.caf"
#define SOUND_SEA_CN @"sea-cn.caf"
#define SOUND_STARFISH_CN @"starfish-cn.caf"
#define SOUND_UMBRELLA_CN @"umbrella-cn.caf"
#define SOUND_SEASHELL_CN @"seashell-cn.caf"

#define SOUND_FIREWORKS_JP @"firework-jp.caf"
#define SOUND_MOON_JP @"moon-jp.caf"
#define SOUND_STAR_JP @"star-jp.caf"
#define SOUND_SEA_JP @"sea-jp.caf"
#define SOUND_STARFISH_JP @"starfish-jp.caf"
#define SOUND_UMBRELLA_JP @"umbrella-jp.caf"
#define SOUND_SEASHELL_JP @"seashell-jp.caf"

#define EFFECT_FIREWORK_01 @"fireworkEffect_01.caf"
#define EFFECT_FIREWORK_02 @"fireworkEffect_02.caf"

typedef enum
{
    SeasideTagStar0,
    SeasideTagStar1,
    SeasideTagStar2,
    SeasideTagStar3,
    SeasideTagStar4,
    SeasideTagStar5,
    SeasideTagMoon,
    SeasideTagUmbrella0,
    SeasideTagUmbrella1,
    SeasideTagUmbrella2,
    SeasideTagStarfish0,
    SeasideTagStarfish1,
    SeasideTagStarfish2,
    SeasideTagShell0,
    SeasideTagShell1,
    SeasideTagShell2,
    SeasideTagShell3,
    SeasideTagSea0,
    SeasideTagSea1,
    SeasideTagSea2,
    SeasideTagSea3,
    
} SeasideTags;

@interface SeasideScene : CCLayer <CCTargetedTouchDelegate> {
    CCSpriteBatchNode *starBatch;
    CCSpriteBatchNode *umBatch;
    CCSpriteBatchNode *sea0Batch;
    CCSpriteBatchNode *sea1Batch;
    
    CGSize screenSize;
}

@property (nonatomic, retain) ZZNavBar *navBar;

+ (CGPoint)locationFromTouch:(UITouch*)touch;

+ (SeasideScene *)sharedSeasideScene;

+ (id)scene;

@end
