//
//  Position.h
//  Brazil
//
//  Created by zhaozilong on 13-1-6.
//
//

#import <Foundation/Foundation.h>

@interface Position : NSObject

@property CGFloat X;
@property CGFloat Y;

+ (Position *)getPosition:(CGPoint)pos;

@end
