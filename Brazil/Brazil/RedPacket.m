//
//  RedPacket.m
//  Brazil
//
//  Created by zhaozilong on 13-1-22.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "RedPacket.h"


@implementation RedPacket

- (void)dealloc {
    
    CCLOG(@"RedPacket dealloc");
    
    [super dealloc];
}

+ (id)redPacketWithParentNode:(CCNode *)parentNode pos:(CGPoint)point tag:(int)tag {
    return [[[self alloc] initWithParentNode:parentNode pos:point tag:tag] autorelease];
}

- (id)initWithParentNode:(CCNode *)parentNode pos:(CGPoint)point tag:(int)tag {
    if (self = [super init]) {
        //touch is enabled
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:-1 swallowsTouches:YES];
        
        giftTag = tag;
        
//        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        count = 0;
        
        frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        
        [self setDisplayFrame:[frameCache spriteFrameByName:@"packet1.png"]];
        self.position = point;
        [parentNode addChild:self];
        
        coverSprite = [CCSprite spriteWithSpriteFrameName:@"packet5.png"];
        coverSprite.visible = NO;
        [parentNode addChild:coverSprite z:-1];
        coverSprite.position = point;
//        coverSprite.position = ccp(self.boundingBox.size.width / 2, self.boundingBox.size.height / 2);
        
        
        //创建礼物精灵
        NSString *name = [self getNameByRedPacketTag:tag];
        giftSprite = [CCSprite spriteWithSpriteFrameName:name];
        [self addChild:giftSprite z:-1];
        giftSprite.visible = NO;
        giftSprite.position = ccp(self.boundingBox.size.width / 2, self.boundingBox.size.height / 2);
        
        screenSize = [[CCDirector sharedDirector] winSize];
    }
    
    return self;
}

- (void)setRedPacketStatusByTapCount:(int)c {
    
    switch (c) {
        case 1:
            [self setDisplayFrame:[frameCache spriteFrameByName:@"packet2.png"]];
            
            //设置title
            [[[RedPacketScene sharedRedPacketScene] navBar] setTitleLabelWithString:NSLocalizedStringFromTable(@"redPacket", [ZZNavBar getStringEnCnJp], nil)];
            
            //播放声音
            [[[RedPacketScene sharedRedPacketScene] navBar] playSoundByNameEn:SOUND_REDPACKET_EN Cn:SOUND_REDPACKET_CN Jp:SOUND_REDPACKET_JP];
            break;
            
        case 2:
            [self setDisplayFrame:[frameCache spriteFrameByName:@"packet3.png"]];
            
            [[SimpleAudioEngine sharedEngine] playEffect:EFFECT_REDPACKET_01];
            break;
            
        case 3:
            //ipad下移320像素，ip4s上移140像素，ip5下移150像素
            [self setDisplayFrame:[frameCache spriteFrameByName:@"packet0.png"]];
            [self playGiftAnimate];
            [coverSprite runAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1 scale:1.1], [CCScaleTo actionWithDuration:0.1 scale:1.0], nil]];
            [giftSprite runAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1 scale:1.1], [CCScaleTo actionWithDuration:0.1 scale:1.0], nil]];
            
            //设置title
            [self setTitleByRedPacketTag:giftTag];
            
            //播放音效
            [[SimpleAudioEngine sharedEngine] playEffect:EFFECT_REDPACKET_02];
            
            break;
            
        default:
            //播放gift的声音
            [coverSprite runAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1 scale:1.1], [CCScaleTo actionWithDuration:0.1 scale:1.0], nil]];
            [giftSprite runAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1 scale:1.1], [CCScaleTo actionWithDuration:0.1 scale:1.0], nil]];
            
            //设置title
            [self setTitleByRedPacketTag:giftTag];
            
            //播放声音
            [self playSoundByTag:giftTag];
            
            break;
    }
}

- (void)playSoundByTag:(RedPacketTags)tag {
    NSString *nameEn = nil;
    NSString *nameCn = nil;
    NSString *nameJP = nil;
    switch (tag) {
        case RedPacketTagAlien:
            nameEn = SOUND_ALIEN_EN;
            nameCn = SOUND_ALIEN_CN;
            nameJP = SOUND_ALIEN_JP;
            break;
        case RedPacketTagCamera:
            nameEn = SOUND_CAMERA_EN;
            nameCn = SOUND_CAMERA_CN;
            nameJP = SOUND_CAMERA_JP;
            break;
        case RedPacketTagCandy:
            nameEn = SOUND_LOLLIPOP_EN;
            nameCn = SOUND_LOLLIPOP_CN;
            nameJP = SOUND_LOLLIPOP_JP;
            break;
        case RedPacketTagDoll:
            nameEn = SOUND_TEDDYBEAR_EN;
            nameCn = SOUND_TEDDYBEAR_CN;
            nameJP = SOUND_TEDDYBEAR_JP;
            break;
        case RedPacketTagGlass:
            nameEn = SOUND_GLASSES_EN;
            nameCn = SOUND_GLASSES_CN;
            nameJP = SOUND_GLASSES_JP;
            break;
        case RedPacketTagIngot:
            nameEn = SOUND_GOLDINGOT_EN;
            nameCn = SOUND_GOLDINGOT_CN;
            nameJP = SOUND_GOLDINGOT_JP;
            break;
        case RedPacketTagPencil:
            nameEn = SOUND_PENCIL_EN;
            nameCn = SOUND_PENCIL_CN;
            nameJP = SOUND_PENCIL_JP;
            break;
        case RedPacketTagRat:
            nameEn = SOUND_MOUSE_EN;
            nameCn = SOUND_MOUSE_CN;
            nameJP = SOUND_MOUSE_JP;
            break;
            
        default:
            break;
    }
    [[[RedPacketScene sharedRedPacketScene] navBar] playSoundByNameEn:nameEn Cn:nameCn Jp:nameJP];
}

- (void)playGiftAnimate {
    CGPoint point;
    if ([ZZNavBar isiPad]) {
        point = ccp(0, 145);
    } else {
        if ([ZZNavBar isiPhone5]) {
            point = ccp(0, 70);
        } else {
            point = ccp(0, 65);
        }
    }
    CCMoveBy *move = [CCMoveBy actionWithDuration:0.5 position:point];
    CCSequence *action = [CCSequence actionOne:[CCShow action] two:move];
    [coverSprite runAction:[CCShow action]];
    [giftSprite runAction:action];
    
}


- (NSString *)getNameByRedPacketTag:(RedPacketTags)tag {
    NSString *name = nil;
    switch (tag) {
        case RedPacketTagAlien:
            name = @"alien.png";
            break;
        case RedPacketTagCamera:
            name = @"camera.png";
            break;
        case RedPacketTagCandy:
            name = @"candy.png";
            break;
        case RedPacketTagDoll:
            name = @"doll.png";
            break;
        case RedPacketTagGlass:
            name = @"glass.png";
            break;
        case RedPacketTagIngot:
            name = @"ingot.png";
            break;
        case RedPacketTagPencil:
            name = @"pencil.png";
            break;
        case RedPacketTagRat:
            name = @"rat.png";
            break;
            
        default:
            break;
    }
    
    return name;
    
}

- (void)setTitleByRedPacketTag:(RedPacketTags)tag {
    NSString *name = nil;
    switch (tag) {
        case RedPacketTagAlien:
            name = @"alien";
            break;
        case RedPacketTagCamera:
            name = @"camera";
            break;
        case RedPacketTagCandy:
            name = @"lollipop";
            break;
        case RedPacketTagDoll:
            name = @"teddyBear";
            break;
        case RedPacketTagGlass:
            name = @"glasses";
            break;
        case RedPacketTagIngot:
            name = @"goldIngot";
            break;
        case RedPacketTagPencil:
            name = @"pencil";
            break;
        case RedPacketTagRat:
            name = @"mouse";
            break;
            
        default:
            break;
    }
    [[[RedPacketScene sharedRedPacketScene] navBar] setTitleLabelWithString:NSLocalizedStringFromTable(name, [ZZNavBar getStringEnCnJp], nil)];
    
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint currentTouchPoint = [RedPacketScene locationFromTouch:touch];
    BOOL isTouch = CGRectContainsPoint(self.boundingBox, currentTouchPoint);
    
    if (isTouch) {
        [self setRedPacketStatusByTapCount:++count];
        [self runAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1 scale:1.1], [CCScaleTo actionWithDuration:0.1 scale:1.0], nil]];
        
    }
    
    return isTouch;
}


@end
