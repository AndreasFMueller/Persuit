//
//  LissajousUpdater.m
//  Pursuit
//
//  Created by Andreas Müller on 13.10.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import "LissajousUpdater.h"

@implementation LissajousUpdater

@synthesize a, b, delta, w, h;

- (id)init: (Pursuit*)p {
    self = [super init: p];
    if (self) {
        a = 1.;
        b = 1.;
        delta = M_PI / 2;
        w = 1.;
        h = 1.;
        displayName = @"Lissajous";
    }
    return self;
}

- (CGPoint)update: (double)t {
    double  v = self.speed;
    CGPoint     target = CGPointMake(w * sin(a * t * v + delta), h * sin(b * t * v));
    return target;
}

@end
