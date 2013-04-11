//
//  MainScene.m
//  Brazil
//
//  Created by zhaozilong on 12-10-29.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "MainScene.h"

#import "ChooseBallLayer.h"


@implementation MainScene

@synthesize titleSprite = _titleSprite;
@synthesize aboutPageSprite = _aboutPageSprite;
@synthesize rateCloudSprite = _rateCloudSprite;

static MainScene *instanceOfMainScene;

- (void)dealloc {
    
    [cloudArray release];
    [speedArray release];
    
    instanceOfMainScene = nil;
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    
    [super dealloc];
}

+ (MainScene *)sharedMainScene {
    
    NSAssert(instanceOfMainScene != nil, @"instanceOfMainScene is not yet initialize!");
    return instanceOfMainScene;
}

+ (CCScene *)scene {
    
    CCScene *scene = [CCScene node];
    
    MainScene *layer = [MainScene node];
    
    [scene addChild:layer];
    
    return scene;
}

- (id)init {
    
    if (self = [super init]) {
        
        instanceOfMainScene = self;
        
        //touch event
        isTouchEnabled_ = YES;
        
        //screen size
        screenSize = [[CCDirector sharedDirector] winSize];
        
        //add texture to momery
        CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        [frameCache addSpriteFramesWithFile:@"main.plist"];
        
        CCLayerColor *color = [CCLayerColor layerWithColor:ccc4(178, 226, 233, 255)];
        [self addChild:color z:-15];
        
        //背景
        CCSpriteFrame *frame = [frameCache spriteFrameByName:@"mainBG.png"];
        
        CCSprite *sprite = [CCSprite spriteWithSpriteFrame:frame];
        sprite.position = ccp(screenSize.width / 2, sprite.contentSize.height / 2);
        [self addChild:sprite z:-1];
        
        switch ([ZZNavBar getNumberEnCnJp]) {
            case 1:
                frame = [frameCache spriteFrameByName:@"titleEN.png"];
                break;
            case 2:
                frame = [frameCache spriteFrameByName:@"titleCN.png"];
                break;
            case 3:
                frame = [frameCache spriteFrameByName:@"titleJP.png"];
                break;
                
            default:
                break;
        }
        _titleSprite = [CCSprite spriteWithSpriteFrame:frame];
        [self addChild:_titleSprite];
        _titleSprite.position = ccp(_titleSprite.contentSize.width / 2, screenSize.height - _titleSprite.contentSize.height / 2);
        
        CGPoint startPos, sharePos, settingsPos, ballPos, springPos, volcanoPos, aboutPos;
        
        CGPoint cloud1Pos, cloud2Pos, cloud3Pos, cloud4Pos, cloud5Pos;
        
        CGFloat copyrightFont, cx, aboutX;
        
        CGFloat volcanoPosX;
        if ([ZZNavBar isiPad]) {
            startPos = ccp(screenSize.width / 2, screenSize.height / 2);
            sharePos = ccp(700, 960);
            settingsPos = ccp(700, 820);
            aboutPos = ccp(700, 860);
            ballPos = ccp(298, 780);
            springPos = ccp(300, 630);
            volcanoPos = ccp(screenSize.width / 2, 0);
            volcanoPosX = screenSize.width / 2 + 25;
            
            cloud3Pos = ccp(100, 200);
            cloud1Pos = ccp(250, 70);
            cloud5Pos = ccp(330, 230);
            cloud4Pos = ccp(540, 100);
            cloud2Pos = ccp(700, 200);
            
            copyrightFont = 20;
            cx = 0;
            
            aboutX = 10;
            
        } else {
            CGFloat x = 0.41667;
            CGFloat y = 0.46875;
            
            copyrightFont = 10;
            cx = 10;
            
            aboutX = 7;
            
            if ([ZZNavBar isiPhone5]) {
                startPos = ccp(screenSize.width / 2, screenSize.height / 2 + 8);
                sharePos = ccp(x * 700, y * 1150);
                settingsPos = ccp(x * 700, y * 1000);
                aboutPos = ccp(x * 700, y * 1040);
                ballPos = ccp(148, 420);
                springPos = ccp(145, 355);
            } else {
                startPos = ccp(screenSize.width / 2, screenSize.height / 2 - 17);
                sharePos = ccp(x * 700, y * 950);
                settingsPos = ccp(x * 700, y * 820);
                aboutPos = ccp(x * 700, y * 840);
                ballPos = ccp(140, 350);
                springPos = ccp(137, 285);
            }
            
            volcanoPos = ccp(screenSize.width / 2, 0);
            volcanoPosX = screenSize.width / 2 + 15;
            
            cloud3Pos = ccp(x * 100, y * 200);
            cloud1Pos = ccp(x * 250, y * 70);
            cloud5Pos = ccp(x * 330, y * 230);
            cloud4Pos = ccp(x * 540, y * 100);
            cloud2Pos = ccp(x * 700, y * 200);
        }
        
        CCLabelTTF *copyright = [CCLabelTTF labelWithString:@"Copyright © 2013 Iyuba.com Inc. All Rights Reserved." fontName:@"MarkerFelt-Thin" fontSize:copyrightFont];
        [self addChild:copyright z:5];
        copyright.position = ccp(screenSize.width / 2 + cx, copyright.contentSize.height / 2);
        
        settingsPage = [Settings node];
        [self addChild:settingsPage z:4];
        settingsPage.visible = NO;
        
        //Add button
        frame = [frameCache spriteFrameByName:@"start.png"];
        startSprite = [CCSprite spriteWithSpriteFrame:frame];
        startSprite.position = startPos;
        [self addChild:startSprite z:0];
        
        CCScaleTo *big = [CCScaleTo actionWithDuration:0.1 scale:1.1];
        CCScaleTo *small = [CCScaleTo actionWithDuration:0.1 scale:1];
        CCDelayTime *time = [CCDelayTime actionWithDuration:1.2];
        CCSequence *bigSmall = [CCSequence actions:big, small, time, nil];
        [startSprite runAction:[CCRepeatForever actionWithAction:bigSmall]];
        
        //share button
//        frame = [frameCache spriteFrameByName:@"share.png"];
//        shareSprite = [CCSprite spriteWithSpriteFrame:frame];
//        shareSprite.position = sharePos;
//        [self addChild:shareSprite z:0];
        
        //settings button
        frame = [frameCache spriteFrameByName:@"settings.png"];
        settingsSprite = [CCSprite spriteWithSpriteFrame:frame];
        settingsSprite.position = sharePos;
        [self addChild:settingsSprite z:5 tag:SETTINGS_OFF_TAG];
        
        
        //ball button
        frame = [frameCache spriteFrameByName:@"ball.png"];
        ballSprite = [CCSprite spriteWithSpriteFrame:frame];
        ballSprite.position = ballPos;
        [self addChild:ballSprite z:0];
        
        //spring
        frame = [frameCache spriteFrameByName:@"spring.png"];
        springSprite = [CCSprite spriteWithSpriteFrame:frame];
        springSprite.position = springPos;
        [self addChild:springSprite z:-1];
        
        //volcano
        frame = [frameCache spriteFrameByName:@"volcano-0.png"];
        volcanoSprite = [CCSprite spriteWithSpriteFrame:frame];
        volcanoSprite.position = ccp(volcanoPosX, volcanoSprite.contentSize.height / 2);
        [self addChild:volcanoSprite z:0];
        
        //About
        frame = [frameCache spriteFrameByName:@"about.png"];
        aboutSprite = [CCSprite spriteWithSpriteFrame:frame];
        aboutSprite.position = aboutPos;
        [self addChild:aboutSprite z:5 tag:ABOUT_OFF_TAG];
        [self setAboutPage];
        
        
        //Cloud
        cloudArray = [[CCArray alloc] initWithCapacity:5];
        frame = [frameCache spriteFrameByName:@"cloud-0.png"];
        CCSprite *cloudSprite = [CCSprite spriteWithSpriteFrame:frame];
        [self addChild:cloudSprite z:1 tag:0];
        cloudSprite.position = cloud1Pos;
        [cloudArray addObject:cloudSprite];
        
        frame = [frameCache spriteFrameByName:@"cloud-1.png"];
        cloudSprite = [CCSprite spriteWithSpriteFrame:frame];
        [self addChild:cloudSprite z:-1 tag:1];
        cloudSprite.position = cloud2Pos;
        [cloudArray addObject:cloudSprite];
        
        frame = [frameCache spriteFrameByName:@"cloud-2.png"];
        cloudSprite = [CCSprite spriteWithSpriteFrame:frame];
        [self addChild:cloudSprite z:-1 tag:2];
        cloudSprite.position = cloud3Pos;
        [cloudArray addObject:cloudSprite];
        
        switch ([ZZNavBar getNumberEnCnJp]) {
            case 1:
                frame = [frameCache spriteFrameByName:@"cloud-3EN.png"];
                break;
            case 2:
                frame = [frameCache spriteFrameByName:@"cloud-3CN.png"];
                break;
            case 3:
                frame = [frameCache spriteFrameByName:@"cloud-3JP.png"];
                break;
                
            default:
                break;
        }
        
        _rateCloudSprite = [CCSprite spriteWithSpriteFrame:frame];
        [self addChild:_rateCloudSprite z:1 tag:3];
        _rateCloudSprite.position = cloud4Pos;
        [cloudArray addObject:_rateCloudSprite];
        
        frame = [frameCache spriteFrameByName:@"cloud-4.png"];
        cloudSprite = [CCSprite spriteWithSpriteFrame:frame];
        [self addChild:cloudSprite z:1 tag:4];
        cloudSprite.position = cloud5Pos;
        [cloudArray addObject:cloudSprite];
        
        //Cloud speed
        speedArray = [[CCArray alloc] initWithCapacity:5];
		[speedArray addObject:[NSNumber numberWithFloat:0.3f]];//0
		[speedArray addObject:[NSNumber numberWithFloat:0.4f]];//1
		[speedArray addObject:[NSNumber numberWithFloat:0.5f]];//2
        [speedArray addObject:[NSNumber numberWithFloat:0.6f]];//3
        [speedArray addObject:[NSNumber numberWithFloat:0.7f]];//4
		NSAssert([speedArray count] == 5, @"speedFactors count does not match numStripes!");
        
        [self scheduleUpdate];
        
        
        //加载背景音乐
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        BOOL isPauseMusic = [userDefaults boolForKey:IS_PAUSE_MUSIC];
        if (isPauseMusic == NO) {
            SimpleAudioEngine *soundE = [SimpleAudioEngine sharedEngine];
            if (![soundE isBackgroundMusicPlaying]) {
                CCLOG(@"播放背景音乐");
                [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:BACKGROUND_MUSIC];
                [[SimpleAudioEngine sharedEngine] playBackgroundMusic:BACKGROUND_MUSIC loop:YES];
            }

        }

        
    }
    
    return self;
}

- (void)update:(ccTime)delta {
    CCSprite* sprite;
	CCARRAY_FOREACH(cloudArray, sprite)
	{
		NSNumber* factor = [speedArray objectAtIndex:sprite.tag];
		CGPoint pos = sprite.position;
		pos.x -= 2 * [factor floatValue];

		// Reposition stripes when they're out of bounds
		if (pos.x < -_rateCloudSprite.contentSize.width / 2)
		{
            pos.x += (screenSize.width + _rateCloudSprite.contentSize.width);
		}
		
		sprite.position = pos;
	}

}

-(void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (void)setAboutPage {
    
    CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    switch ([ZZNavBar getNumberEnCnJp]) {
        case 1:
            _aboutPageSprite = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"aboutBGEN.png"]];
            break;
        case 2:
            _aboutPageSprite = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"aboutBG.png"]];
            break;
        case 3:
            _aboutPageSprite = [CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"aboutBGJP.png"]];
            break;
            
        default:
            break;
    }
    
    _aboutPageSprite.position = ccp(screenSize.width / 2, screenSize.height / 2);
    [self addChild:_aboutPageSprite z:2];
    _aboutPageSprite.scale = 0;
    _aboutPageSprite.visible = NO;
    
    CCMenuItem *closeItem = [CCMenuItemImage itemFromNormalSprite:[CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"close.png"]] selectedSprite:[CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"close2.png"]] target:self selector:@selector(openAboutPage)];
    
//    CCMenuItem *iyubaItem = [CCMenuItemImage itemFromNormalImage:[CCSprite spriteWithSpriteFrame:[frameCache spriteFrameByName:@"iyuba.png"] selectedImage:nil target:self selector:@selector(<#selector#>)];
    CCSpriteFrame *frame;// = [frameCache spriteFrameByName:@"iyuba.png"];
    switch ([ZZNavBar getNumberEnCnJp]) {
        case 2:
            frame = [frameCache spriteFrameByName:@"iyuba2.png"];
            break;
            
        default:
            frame = [frameCache spriteFrameByName:@"iyuba2.png"];
            break;
    }
    CCMenuItem *iyubaItem = [CCMenuItemImage itemFromNormalSprite:[CCSprite spriteWithSpriteFrame:frame] selectedSprite:nil block:^(id sender){
        UIAlertView * alert = nil;
        switch ([ZZNavBar getNumberEnCnJp]) {
            case 1:
                alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Visit iyuba.com?" delegate:self cancelButtonTitle:@"Later" otherButtonTitles:@"Yes", nil];
                break;
            case 2:
                alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定访问爱语吧网站吗?" delegate:self cancelButtonTitle:@"以后再说" otherButtonTitles:@"现在就去", nil];
                break;
            case 3:
                alert = [[UIAlertView alloc] initWithTitle:@"メセッジ" message:@"iyuba.comへ?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
                break;
                
            default:
                break;
        }
        
        alert.tag = ALERT_IYUBA;
        [alert show];
        [alert release];
    }];
    
    CCScaleTo *big = [CCScaleTo actionWithDuration:0.1 scale:1.1];
    CCScaleTo *small = [CCScaleTo actionWithDuration:0.1 scale:0.9];
    CCDelayTime *time = [CCDelayTime actionWithDuration:1];
    CCSequence *bigSmall = [CCSequence actions:big, small, time, nil];
    [iyubaItem runAction:[CCRepeatForever actionWithAction:bigSmall]];
    
    CCMenu *closeMenu = [CCMenu menuWithItems:closeItem, iyubaItem, nil];
    
    if ([ZZNavBar isiPad]) {
        closeItem.position = ccp(630, 745);
        iyubaItem.position = ccp(screenSize.width / 2, 200);
    } else {
        if ([ZZNavBar isiPhone5]) {
            closeItem.position = ccp(255, 373);
            iyubaItem.position = ccp(screenSize.width / 2, 135);
        } else {
            closeItem.position = ccp(260, 342);
            iyubaItem.position = ccp(screenSize.width / 2, 110);
        }
        
    }
    
    closeMenu.position = ccp(0, 0);
    [_aboutPageSprite addChild:closeMenu];
    
}

+(CGPoint) locationFromTouch:(UITouch*)touch
{
	CGPoint touchLocation = [touch locationInView: [touch view]];
	return [[CCDirector sharedDirector] convertToGL:touchLocation];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    
    currentTouchPoint = [MainScene locationFromTouch:touch];

    isTouchEnabled_ = (CGRectContainsPoint(startSprite.boundingBox, currentTouchPoint)/* || CGRectContainsPoint(shareSprite.boundingBox, currentTouchPoint) */|| CGRectContainsPoint(settingsSprite.boundingBox, currentTouchPoint) || CGRectContainsPoint(ballSprite.boundingBox, currentTouchPoint) || CGRectContainsPoint(_rateCloudSprite.boundingBox, currentTouchPoint) || CGRectContainsPoint(aboutSprite.boundingBox, currentTouchPoint) || CGRectContainsPoint(_aboutPageSprite.boundingBox, currentTouchPoint));
    
    if (isTouchEnabled_) {
        if (CGRectContainsPoint(_aboutPageSprite.boundingBox, currentTouchPoint)) {
            
        }/* else if (CGRectContainsPoint(shareSprite.boundingBox, currentTouchPoint)) {
            
        } */else if (CGRectContainsPoint(settingsSprite.boundingBox, currentTouchPoint)) {
            settingsSprite.scale = 1.2;
        } else if (CGRectContainsPoint(ballSprite.boundingBox, currentTouchPoint)) {
            [self ballAnimate];
        } else if (CGRectContainsPoint(aboutSprite.boundingBox, currentTouchPoint)){
            aboutSprite.scale = 1.2;
        } else if (CGRectContainsPoint(startSprite.boundingBox, currentTouchPoint)){
            startSprite.scale = 1.1;
        } else {
            _rateCloudSprite.scale = 1.1;
        }
    }
    
    return isTouchEnabled_;
    
    
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint endPoint = [MainScene locationFromTouch:touch];
    
    if (CGRectContainsPoint(_aboutPageSprite.boundingBox, currentTouchPoint)) {
        
    }/* else if (CGRectContainsPoint(shareSprite.boundingBox, currentTouchPoint)) {
        
    } */else if (CGRectContainsPoint(settingsSprite.boundingBox, currentTouchPoint)) {
        settingsSprite.scale = 1.0;
        if (CGRectContainsPoint(settingsSprite.boundingBox, endPoint)) {
            [self openSettings];
        }
        
    } else if (CGRectContainsPoint(ballSprite.boundingBox, currentTouchPoint)) {
        
    } else if (CGRectContainsPoint(aboutSprite.boundingBox, currentTouchPoint)){
        aboutSprite.scale = 1.0;
        if (CGRectContainsPoint(aboutSprite.boundingBox, endPoint)) {
            [self openAboutPage];
        }
        
    } else if (CGRectContainsPoint(startSprite.boundingBox, currentTouchPoint)){
        startSprite.scale = 1.0;
        
        if (CGRectContainsPoint(startSprite.boundingBox, endPoint)) {
            [self transToPlayBallLayer];
        }
    } else {
        
        _rateCloudSprite.scale = 1.0;
        if (CGRectContainsPoint(_rateCloudSprite.boundingBox, endPoint)) {
            [self rateMe];
        }
        
    }
    
    
}

- (void)rateMe {
    //Jump to appstore to rate me
    [ZZNavBar playBackEffect];
    
    UIAlertView * alert = nil;//[[UIAlertView alloc] initWithTitle:@"提示" message:@"确定打开App Store吗?" delegate:self cancelButtonTitle:@"下次评价" otherButtonTitles:@"现在就去", nil];
    switch ([ZZNavBar getNumberEnCnJp]) {
        case 1:
            alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Visit App Store?" delegate:self cancelButtonTitle:@"Later" otherButtonTitles:@"Yes", nil];
            break;
        case 2:
            alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定打开App Store吗?" delegate:self cancelButtonTitle:@"下次评价" otherButtonTitles:@"现在就去", nil];
            break;
        case 3:
            alert = [[UIAlertView alloc] initWithTitle:@"メセッジ" message:@"App Storeへ?" delegate:self cancelButtonTitle:@"Later" otherButtonTitles:@"Yes", nil];
            break;
            
        default:
            break;
    }

    alert.tag = ALERT_RATE;
    [alert show];
    [alert release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag == ALERT_RATE) {
        if (buttonIndex == 1) {
            //        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/guang-dian-bi-zhi/id511587202?mt=8"]];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=590220714"]];
            
        }
    } else if (alertView.tag == ALERT_IYUBA) {
        if (buttonIndex == 1) {
            //        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/guang-dian-bi-zhi/id511587202?mt=8"]];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.iyuba.com"]];
            
        }
    }
    
}

- (void)openAboutPage {
    [ZZNavBar playBackEffect];
    if (aboutSprite.tag == ABOUT_ON_TAG) {
        [_aboutPageSprite runAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.2 scale:0], [CCHide action], nil]];
        aboutSprite.tag = ABOUT_OFF_TAG;
    } else {
        
        CCScaleTo *small = [CCScaleTo actionWithDuration:0.1 scale:0.8];
        CCScaleTo *big = [CCScaleTo actionWithDuration:0.1 scale:1.2];
        CCScaleTo *nomal = [CCScaleTo actionWithDuration:0.1 scale:1.0];
        CCSequence *action = [CCSequence actions:big, small, nomal, nil];
        
        [_aboutPageSprite runAction:[CCSequence actions:[CCShow action], action, nil]];
        aboutSprite.tag = ABOUT_ON_TAG;
    }
}

- (void)openSettings {
    [ZZNavBar playBackEffect];
    CCScaleTo *small = [CCScaleTo actionWithDuration:0.1 scale:0.8];
    CCScaleTo *big = [CCScaleTo actionWithDuration:0.1 scale:1.2];
    CCScaleTo *nomal = [CCScaleTo actionWithDuration:0.1 scale:1.0];
    CCSequence *action = [CCSequence actions:big, small, nomal, nil];
    [settingsPage runAction:[CCSequence actionOne:[CCShow action] two:action]];
    [[CCTouchDispatcher sharedDispatcher] setPriority:-1 forDelegate:settingsPage];
}

- (void)transToPlayBallLayer {
    [ZZNavBar playBackEffect];
    
    //火山的动画
    CCCallBlock *volcanoRed = [CCCallBlock actionWithBlock:^{
        [volcanoSprite setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"volcano-1.png"]];
    }];
    
    CCCallBlock *jumpToScene = [CCCallBlock actionWithBlock:^{
        //跳转
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[ChooseBallLayer scene] withColor:ccWHITE]];
    }];
    CCScaleTo *big = [CCScaleTo actionWithDuration:0.05 scale:1.1];
    CCScaleTo *small = [CCScaleTo actionWithDuration:0.05 scale:1.0];
    CCSequence *bigSmall = [CCSequence actionOne:big two:small];
    CCRepeat *repeat = [CCRepeat actionWithAction:bigSmall times:4];
    CCSequence *action = [CCSequence actions:volcanoRed, repeat, jumpToScene, nil];
    [volcanoSprite runAction:action];
}

- (void)ballAnimate {
    [[SimpleAudioEngine sharedEngine] playEffect:@"spring.caf"];
    
    CCRotateTo *rotateLeft = [CCRotateTo actionWithDuration:0.1 angle:5];
    CCRotateTo *rotateRight = [CCRotateTo actionWithDuration:0.1 angle:-5];
    CCRotateTo *rotateNormal = [CCRotateTo actionWithDuration:0.1 angle:0];
    CCSequence *rotate = [CCSequence actions:rotateLeft, rotateRight, nil];
    CCRepeat *repeat = [CCRepeat actionWithAction:rotate times:5];
    CCSequence *action = [CCSequence actionOne:repeat two:rotateNormal];
    [ballSprite runAction:action];
    
}




@end
