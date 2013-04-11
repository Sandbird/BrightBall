//
//  CarSprite.m
//  Brazil
//
//  Created by zhaozilong on 12-12-20.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CarSprite.h"


@implementation CarSprite

- (void)dealloc {
    
    CCLOG(@"Car dealloc");
    
    [soundSource release];
    
    if (self.tag == CarBicycleTag) {
        [middleRepeat release];
    }
    [frontRepeat release];
    [backRepeat release];
    [super dealloc];
}

+ (CarSprite *)carWithParentNode:(CCNode *)parentNode pos:(CGPoint)point zorder:(int)zorder carTag:(int)tag {
    return [[[self alloc] initWithParentNode:parentNode pos:point zorder:zorder carTag:tag] autorelease];
}

- (id)initWithParentNode:(CCNode *)parentNode pos:(CGPoint)point zorder:(int)zorder carTag:(int)carTag {
    if (self = [super init]) {
        //touch is enabled
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:-2 swallowsTouches:YES];
        
        screenSize = [[CCDirector sharedDirector] winSize];
        
        CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        CCSpriteFrame *frame = [frameCache spriteFrameByName:[NSString stringWithFormat:@"%@.png", [self getImageNameByCarTag:carTag]]];
        [self setDisplayFrame:frame];
        
        CGPoint tyreFrontPos;// = [self getPadFrontTyrePosByCarTag:carTag];
        CGPoint tyreBackPos;// = [self getPadBackTyrePosByCarTag:carTag];
        
        if ([ZZNavBar isiPad]) {
            tyreFrontPos = [self getPadFrontTyrePosByCarTag:carTag];
            tyreBackPos = [self getPadBackTyrePosByCarTag:carTag];
        } else {
            tyreFrontPos = [self getPhoneFrontTyrePosByCarTag:carTag];
            tyreBackPos = [self getPhoneBackTyrePosByCarTag:carTag];
        }
        
        frame = [frameCache spriteFrameByName:[NSString stringWithFormat:@"%@-1.png", [self getImageNameByCarTag:carTag]]];
        tyreFrontSprite = [CCSprite spriteWithSpriteFrame:frame];
        [self addChild:tyreFrontSprite z:-1];
        tyreFrontSprite.position = ccp(tyreFrontPos.x, tyreFrontPos.y);
        
        frame = [frameCache spriteFrameByName:[NSString stringWithFormat:@"%@-2.png", [self getImageNameByCarTag:carTag]]];
        tyreBackSprite = [CCSprite spriteWithSpriteFrame:frame];
        [self addChild:tyreBackSprite z:-1];
        tyreBackSprite.position = ccp(tyreBackPos.x, tyreBackPos.y);
        
        //设置car
        [parentNode addChild:self z:zorder tag:carTag];
        
        //轮子滚动的速度
        [self setTyreSpeedByCarTag:carTag];
        
        //自行车有镫子
        if (carTag == CarBicycleTag) {
            frame = [frameCache spriteFrameByName:@"bicycle-0.png"];
            tyreMidSprite = [CCSprite spriteWithSpriteFrame:frame];
            [self addChild:tyreMidSprite z:1];
            tyreMidSprite.anchorPoint = ccp(0.5, 1.0);
            if ([ZZNavBar isiPad]) {
                tyreMidSprite.position = ccp(87, 26);
            } else {
                tyreMidSprite.position = ccp(44, 12);
            }
            
            middleRepeat = [[CCRepeatForever alloc] initWithAction:[CCRotateBy actionWithDuration:3 angle:-360]];
        }
        
        //设置位置
        self.anchorPoint = ccp(0, 0.5);
        self.position = point;
        
        [self scheduleUpdate];
    }
    
    return self;
}

- (void)setTyreSpeedByCarTag:(int)tag {
    switch (tag) {
        case CarBusTag:
            frontRepeat = [[CCRepeatForever alloc] initWithAction:[CCRotateBy actionWithDuration:1.5 angle:-360]];
            backRepeat = [[CCRepeatForever alloc] initWithAction:[CCRotateBy actionWithDuration:1.5 angle:-360]];
            break;
            
        case CarBicycleTag:
            frontRepeat = [[CCRepeatForever alloc] initWithAction:[CCRotateBy actionWithDuration:2 angle:-360]];
            backRepeat = [[CCRepeatForever alloc] initWithAction:[CCRotateBy actionWithDuration:2 angle:-360]];
            break;
            
        case CarCarTag:
            frontRepeat = [[CCRepeatForever alloc] initWithAction:[CCRotateBy actionWithDuration:0.5 angle:-360]];
            backRepeat = [[CCRepeatForever alloc] initWithAction:[CCRotateBy actionWithDuration:0.5 angle:-360]];
            break;
            
        case Car4Tag:
            frontRepeat = [[CCRepeatForever alloc] initWithAction:[CCRotateBy actionWithDuration:1 angle:-360]];
            backRepeat = [[CCRepeatForever alloc] initWithAction:[CCRotateBy actionWithDuration:1 angle:-360]];
            break;
            
        case Car5Tag:
            frontRepeat = [[CCRepeatForever alloc] initWithAction:[CCRotateBy actionWithDuration:1 angle:-360]];
            backRepeat = [[CCRepeatForever alloc] initWithAction:[CCRotateBy actionWithDuration:1 angle:-360]];
            break;
            
        default:
            break;
    }
    
}

- (CGPoint)getPadFrontTyrePosByCarTag:(int)carTag {
    CGPoint point;
    switch (carTag) {
        case CarBusTag:
            point = ccp(128, 5);
            break;
            
        case CarBicycleTag:
            point = ccp(8, 17);
            break;
            
        case CarCarTag:
            point = ccp(70, 20);
            break;
            
        case Car4Tag:
            point = ccp(110, 10);
            break;
            
        case Car5Tag:
            point = ccp(20, 17);
            break;
            
        default:
            break;
    }
    return point;
}

- (CGPoint)getPadBackTyrePosByCarTag:(int)carTag {
    CGPoint point;
    switch (carTag) {
        case CarBusTag:
            point = ccp(428, 5);
            break;
            
        case CarBicycleTag:
            point = ccp(159, 17);
            break;
            
        case CarCarTag:
            point = ccp(375, 20);
            break;
            
        case Car4Tag:
            point = ccp(335, 10);
            break;
            
        case Car5Tag:
            point = ccp(238, 17);
            break;
            
        default:
            break;
    }
    return point;
}

- (CGPoint)getPhoneFrontTyrePosByCarTag:(int)carTag {
    CGPoint point;
    switch (carTag) {
        case CarBusTag:
            point = ccp(65, 5);
            break;
            
        case CarBicycleTag:
            point = ccp(5, 9);
            break;
            
        case CarCarTag:
            point = ccp(35, 10);
            break;
            
        case Car4Tag:
            point = ccp(55, 5);
            break;
            
        case Car5Tag:
            point = ccp(11, 10);
            break;
            
        default:
            break;
    }
    return point;
}


- (CGPoint)getPhoneBackTyrePosByCarTag:(int)carTag {
    CGPoint point;
    switch (carTag) {
        case CarBusTag:
            point = ccp(215, 5);
            break;
            
        case CarBicycleTag:
            point = ccp(80, 9);
            break;
            
        case CarCarTag:
            point = ccp(188, 10);
            break;
            
        case Car4Tag:
            point = ccp(168, 5);
            break;
            
        case Car5Tag:
            point = ccp(123, 10);
            break;
            
        default:
            break;
    }
    return point;
}



- (NSString *)getImageNameByCarTag:(int)carTag {
    
    NSString *name = nil;
    switch (carTag) {
        case CarBusTag:
            name = @"bus";
            break;
            
        case CarBicycleTag:
            name = @"bicycle";
            break;
            
        case CarCarTag:
            name = @"car";
            break;
            
        case Car4Tag:
            name = @"car4";
            break;
            
        case Car5Tag:
            name = @"car5";
            break;
            
        default:
            break;
    }
    
    return name;
}


-(void) update:(ccTime)delta {
    if (isTouchHandled) {
        CGPoint point;
        switch (self.tag) {
            case CarBusTag:
                if (self.position.x > screenSize.width / 4) {
                    point = self.position;
                    point.x --;
                    self.position = point;
                } else if (self.position.x < screenSize.width / 4) {
                    point = self.position;
                    point.x ++;
                    self.position = point;
                }
                if (soundSource) {
                    if (![soundSource isPlaying]) {
                        [soundSource play];
                    }
                } else {
                    soundSource = [[[SimpleAudioEngine sharedEngine] soundSourceForFile:EFFECT_CAR] retain];
                    
                    [soundSource play];
                }
                
                
                
                break;
                
            case CarBicycleTag:
                if (self.position.x > screenSize.width / 2) {
                    point = self.position;
                    point.x --;
                    self.position = point;
                } else if (self.position.x < screenSize.width / 2) {
                    point = self.position;
                    point.x ++;
                    self.position = point;
                }
                
                if (soundSource) {
                    if (![soundSource isPlaying]) {
                        [soundSource play];
                    }
                } else {
                    soundSource = [[[SimpleAudioEngine sharedEngine] soundSourceForFile:EFFECT_BICYCLE] retain];
                    
                    [soundSource play];
                }
                break;
                
            case CarCarTag:
                if (self.position.x > screenSize.width / 4) {
                    point = self.position;
                    point.x --;
                    self.position = point;
                } else if (self.position.x < screenSize.width / 4) {
                    point = self.position;
                    point.x ++;
                    self.position = point;
                }
                
                if (soundSource) {
                    if (![soundSource isPlaying]) {
                        [soundSource play];
                    }
                } else {
                    soundSource = [[[SimpleAudioEngine sharedEngine] soundSourceForFile:EFFECT_CAR] retain];
                    
                    [soundSource play];
                }
                break;
                
            case Car4Tag:
                if (self.position.x > screenSize.width / 4) {
                    point = self.position;
                    point.x --;
                    self.position = point;
                } else if (self.position.x < screenSize.width / 4) {
                    point = self.position;
                    point.x ++;
                    self.position = point;
                }
                
                if (soundSource) {
                    if (![soundSource isPlaying]) {
                        [soundSource play];
                    }
                } else {
                    soundSource = [[[SimpleAudioEngine sharedEngine] soundSourceForFile:EFFECT_CAR] retain];
                    
                    [soundSource play];
                }
                break;
                
            case Car5Tag:
                if (self.position.x > screenSize.width / 4) {
                    point = self.position;
                    point.x --;
                    self.position = point;
                } else if (self.position.x < screenSize.width / 4) {
                    point = self.position;
                    point.x ++;
                    self.position = point;
                }
                
                if (soundSource) {
                    if (![soundSource isPlaying]) {
                        [soundSource play];
                    }
                } else {
                    soundSource = [[[SimpleAudioEngine sharedEngine] soundSourceForFile:EFFECT_MOTORBIKE] retain];
                    
                    [soundSource play];
                }
                break;
                
            default:
                break;
        }
        
    }
}

- (void)setNameByCarTag:(int)tag {
    
    switch (tag) {
        case CarBusTag:
            [[[TrafficScene sharedTrafficScene] navBar] setTitleLabelWithString:NSLocalizedStringFromTable(@"bus", [ZZNavBar getStringEnCnJp], nil)];
            
            break;
            
        case CarBicycleTag:
            [[[TrafficScene sharedTrafficScene] navBar] setTitleLabelWithString:NSLocalizedStringFromTable(@"bicycle", [ZZNavBar getStringEnCnJp], nil)];
            
            break;
            
        case CarCarTag:
            [[[TrafficScene sharedTrafficScene] navBar] setTitleLabelWithString:NSLocalizedStringFromTable(@"car", [ZZNavBar getStringEnCnJp], nil)];
            
            break;
            
        case Car4Tag:
            [[[TrafficScene sharedTrafficScene] navBar] setTitleLabelWithString:NSLocalizedStringFromTable(@"truck", [ZZNavBar getStringEnCnJp], nil)];
            
            break;
            
        case Car5Tag:
            [[[TrafficScene sharedTrafficScene] navBar] setTitleLabelWithString:NSLocalizedStringFromTable(@"motorbike", [ZZNavBar getStringEnCnJp], nil)];
            
            break;
            
        default:
            break;
    }
    
}


//播放汽车的音效和读音
- (void)sayNameByCarTag:(int)tag {
    
    NSString *name = nil;
    BOOL isEn = [[[TrafficScene sharedTrafficScene] navBar] isEnglish];
    switch (tag) {
        case CarBusTag:
            //            [[[TrafficScene sharedTrafficScene] navBar] setTitleLabelWithString:@"Bus\n公共汽车"];
            
            if (isEn) {
                name = SOUND_BUS_EN;
            } else {
                if ([ZZNavBar getNumberEnCnJp] == 2) {
                    name = SOUND_BUS_CN;
                } else {
                    name = SOUND_BUS_JP;
                }
                
            }
            break;
            
        case CarBicycleTag:
            //            [[[TrafficScene sharedTrafficScene] navBar] setTitleLabelWithString:@"Bicycle\n自行车"];
            
            if (isEn) {
                name = SOUND_BICYCLE_EN;
            } else {
                if ([ZZNavBar getNumberEnCnJp] == 2) {
                    name = SOUND_BICYCLE_CN;
                } else {
                    name = SOUND_BICYCLE_JP;
                }
                
            }
            break;
            
        case CarCarTag:
            //            [[[TrafficScene sharedTrafficScene] navBar] setTitleLabelWithString:@"Car\n轿车"];
            
            if (isEn) {
                name = SOUND_CAR_EN;
            } else {
                if ([ZZNavBar getNumberEnCnJp] == 2) {
                    name = SOUND_CAR_CN;
                } else {
                    name = SOUND_CAR_JP;
                }
                
            }
            break;
            
        case Car4Tag:
            //            [[[TrafficScene sharedTrafficScene] navBar] setTitleLabelWithString:@"Truck\n卡车"];
            
            if (isEn) {
                name = SOUND_CAR4_EN;
            } else {
                if ([ZZNavBar getNumberEnCnJp] == 2) {
                    name = SOUND_CAR4_CN;
                } else {
                    name = SOUND_CAR4_JP;
                }
                
            }
            break;
            
        case Car5Tag:
            //            [[[TrafficScene sharedTrafficScene] navBar] setTitleLabelWithString:@"Motorbike\n摩托车"];
            
            if (isEn) {
                name = SOUND_CAR5_EN;
            } else {
                if ([ZZNavBar getNumberEnCnJp] == 2) {
                    name = SOUND_CAR5_CN;
                } else {
                    name = SOUND_CAR5_JP;
                }
                
            }
            break;
            
        default:
            break;
    }
    
    [[SimpleAudioEngine sharedEngine] playEffect:name];
}

- (void)setSpeedByCarTag:(int)tag {
    
    switch (tag) {
        case CarBusTag:
            [[[TrafficScene sharedTrafficScene] background] setScrollSpeed:6.0];
            break;
            
        case CarBicycleTag:
            [[[TrafficScene sharedTrafficScene] background] setScrollSpeed:3.0];
            break;
            
        case CarCarTag:
            [[[TrafficScene sharedTrafficScene] background] setScrollSpeed:12.0];
            break;
            
        case Car4Tag:
            [[[TrafficScene sharedTrafficScene] background] setScrollSpeed:5.0];
            break;
            
        case Car5Tag:
            [[[TrafficScene sharedTrafficScene] background] setScrollSpeed:8.0];
            break;
            
        default:
            break;
    }
    
}


- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint currentPoint = [TrafficScene locationFromTouch:touch];
    
    isTouchHandled = CGRectContainsPoint(self.boundingBox, currentPoint);
    
    if (isTouchHandled) {
        
        //变大小
        [self runAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.05 scale:1.1], [CCScaleTo actionWithDuration:0.05 scale:1.0], nil]];
        
        //设置当前活动的Car
        [[TrafficScene sharedTrafficScene] setCurrentCar:self.tag];
        
        //播放声音，显示单词
        [self setNameByCarTag:self.tag];
        [self sayNameByCarTag:self.tag];
        
        //设置背景移动速度
        [self setSpeedByCarTag:self.tag];
        
        
        //轮子转,背景开始运动
        [[[TrafficScene sharedTrafficScene] background] brakeOrMove:YES];
        
        [tyreFrontSprite runAction:frontRepeat];
        [tyreBackSprite runAction:backRepeat];
        
        if (self.tag == CarBicycleTag) {
            [tyreMidSprite runAction:middleRepeat];
        }
        
        
    }
    
    
    return isTouchHandled;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    isTouchHandled = NO;
    
    if (soundSource) {
        if ([soundSource isPlaying]) {
            [soundSource stop];
        }
    }
    
    //设置当前没有活动的car
    [[TrafficScene sharedTrafficScene] setCurrentCar:CarNoneTag];
    
    //轮子停，背景停
    [[[TrafficScene sharedTrafficScene] background] brakeOrMove:NO];
    
    [tyreFrontSprite stopAction:frontRepeat];
    [tyreBackSprite stopAction:backRepeat];
    
    if (self.tag == CarBicycleTag) {
        [tyreMidSprite stopAction:middleRepeat];
    }
}

@end
