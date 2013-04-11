//
//  RedPacketScene.h
//  Brazil
//
//  Created by zhaozilong on 13-1-22.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ZZNavBar.h"

#define SOUND_REDPACKET_EN @"redPacket-en.caf"
#define SOUND_LOLLIPOP_EN @"lollipop-en.caf"
#define SOUND_TEDDYBEAR_EN @"teddyBear-en.caf"
#define SOUND_ALIEN_EN @"alien-en.caf"
#define SOUND_PENCIL_EN @"pencil-en.caf"
#define SOUND_GLASSES_EN @"glasses-en.caf"
#define SOUND_CAMERA_EN @"camera-en.caf"
#define SOUND_MOUSE_EN @"mouse-en.caf"
#define SOUND_GOLDINGOT_EN @"goldIngot-en.caf"

#define SOUND_REDPACKET_CN @"redPacket-cn.caf"
#define SOUND_LOLLIPOP_CN @"lollipop-cn.caf"
#define SOUND_TEDDYBEAR_CN @"teddyBear-cn.caf"
#define SOUND_ALIEN_CN @"alien-cn.caf"
#define SOUND_PENCIL_CN @"pencil-cn.caf"
#define SOUND_GLASSES_CN @"glasses-cn.caf"
#define SOUND_CAMERA_CN @"camera-cn.caf"
#define SOUND_MOUSE_CN @"mouse-cn.caf"
#define SOUND_GOLDINGOT_CN @"goldIngot-cn.caf"

#define SOUND_REDPACKET_JP @"redPacket-jp.caf"
#define SOUND_LOLLIPOP_JP @"lollipop-jp.caf"
#define SOUND_TEDDYBEAR_JP @"teddyBear-jp.caf"
#define SOUND_ALIEN_JP @"alien-jp.caf"
#define SOUND_PENCIL_JP @"pencil-jp.caf"
#define SOUND_GLASSES_JP @"glasses-jp.caf"
#define SOUND_CAMERA_JP @"camera-jp.caf"
#define SOUND_MOUSE_JP @"mouse-jp.caf"
#define SOUND_GOLDINGOT_JP @"goldIngot-jp.caf"

#define EFFECT_REDPACKET_01 @"redPacketEffect_01.caf"
#define EFFECT_REDPACKET_02 @"redPacketEffect_02.caf"


@interface RedPacketScene : CCLayer {
    
}

@property (nonatomic, retain) ZZNavBar *navBar;

+ (CGPoint)locationFromTouch:(UITouch*)touch;

+ (RedPacketScene *)sharedRedPacketScene;

+ (id)scene;

@end
