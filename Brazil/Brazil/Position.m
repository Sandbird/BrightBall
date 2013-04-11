//
//  Position.m
//  Brazil
//
//  Created by zhaozilong on 13-1-6.
//
//

#import "Position.h"

@implementation Position
@synthesize X = _X;
@synthesize Y = _Y;

+ (Position *)getPosition:(CGPoint)pos {
    return [[[Position alloc] initWithPos:pos] autorelease];
}

- (id)initWithPos:(CGPoint)pos {
    if (self = [super init]) {
        _X = pos.x;
        _Y = pos.y;
    }
    return self;
}

@end
