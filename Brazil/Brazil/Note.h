//
//  Note.h
//  Brazil
//
//  Created by zhaozilong on 12-12-16.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "NoteScene.h"
#import "SimpleAudioEngine.h"

@interface Note : NSObject <CCTargetedTouchDelegate> {
    
    NSString *noteStr;
    NSString *abStr;
    
    CCSpriteFrameCache *frameCache;
    CCSpriteFrame *frame;
    
    CCSprite *noteSprite;
    CCSprite *abSprite;
    
    BOOL isTouchHandled;
    
    CGPoint defaultPosition;
	CGPoint lastTouchLocation;
    
}

+ (id)noteWithParentNode:(CCNode *)parentNode abPos:(CGPoint)abPoint notePos:(CGPoint)notePoint alphabet:(NSString *)abStr noteName:(NSString *)noteStr;

@end
