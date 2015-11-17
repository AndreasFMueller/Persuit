//
//  PolygonUpdater.m
//  Pursuit
//
//  Created by Andreas Müller on 13.10.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import "PolygonUpdater.h"

@implementation PolygonUpdater

@synthesize n, skip, w, h, continuous;

- (id)init:(Pursuit *)p {
    self = [super init:p];
    if (self) {
        n = 5;
        skip = 3;
        w = 1;
        h = 1;
        displayName = @"Polygon";
        continuous = YES;
    }
    return self;
}

- (CGPoint)pointAt: (double)k {
    double T = 2 * M_PI * skip * k / n;
    return CGPointMake(w * cos(T), h * sin(T));
}

- (CGPoint)update:(double)t {
    double k = trunc(t * self.speed);
    CGPoint p1 = [self pointAt: k];
    if (continuous) {
        CGPoint p2 = [self pointAt: k+1];
        double deltat = t * self.speed - k;
        return CGPointMake((1-deltat)*p1.x + deltat*p2.x, (1-deltat)*p1.y + deltat*p2.y);
    }
    return p1;
}

@end
