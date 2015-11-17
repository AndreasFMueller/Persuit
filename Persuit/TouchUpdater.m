//
//  TouchUpdater.m
//  Pursuit
//
//  Created by Andreas Müller on 13.10.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import "TouchUpdater.h"

@implementation TouchUpdater

@synthesize pursuitView, where;

- (id)init:(Pursuit *)p {
    self = [super init: p];
    if (self) {
        where = CGPointMake(0, 0);
        displayName = @"Touch";
    }
    return self;
}

- (CGPoint)update:(double)t {
    return where;
}

- (void)position:(CGPoint)w {
    where = w;
    NSLog(@"new position: %@", NSStringFromCGPoint(where));
}

@end
