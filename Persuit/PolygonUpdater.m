//
//  PolygonUpdater.m
//  Persuit
//
//  Created by Andreas Müller on 13.10.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import "PolygonUpdater.h"

@implementation PolygonUpdater

@synthesize n, skip, w, h;

- (id)init:(Persuit *)p {
    self = [super init:p];
    if (self) {
        n = 5;
        skip = 3;
        w = 1;
        h = 1;
        displayName = @"Polygon";
    }
    return self;
}
- (CGPoint)update:(double)t {
    double T = 2 * M_PI * skip * round(t * self.speed) / n;
    return CGPointMake(w * cos(T), h * sin(T));
}

@end
