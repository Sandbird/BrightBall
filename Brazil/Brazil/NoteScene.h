//
//  NoteScene.h
//  Brazil
//
//  Created by zhaozilong on 12-12-16.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Note.h"
#import "ZZNavBar.h"

@interface NoteScene : CCLayer {
    
}

@property (nonatomic, retain) ZZNavBar *navBar;

+(CGPoint) locationFromTouch:(UITouch*)touch;

+ (id)scene;

+ (NoteScene *)sharedNoteScene;

@end
