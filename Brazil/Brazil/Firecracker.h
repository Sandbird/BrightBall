//
//  Firecracker.h
//  Brazil
//
//  Created by zhaozilong on 13-1-18.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Firecracker : CCSprite <CCTargetedTouchDelegate> {
    CCSpriteFrameCache *frameCache;
    CCSpriteFrame *bombFrame;
}

+ (id)firecrackerWithPos:(CGPoint)point zorder:(int)zorder rotate:(CGFloat)rotate isFlip:(BOOL)isFlip;

@end
