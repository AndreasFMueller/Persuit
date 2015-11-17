//
//  RandomUpdater.m
//  Pursuit
//
//  Created by Andreas Müller on 13.10.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import "RandomUpdater.h"
#import "UIKit/UIKit.h"
#include <stdlib.h>

@implementation RandomUpdater

@synthesize sigma, where, radius;

- (id)init:(Pursuit *)p {
    self = [super init:p];
    if (self) {
        sigma = 0.2;
        where = CGPointMake(0, 0);
        radius = 1.5;
        displayName = @"Random";
    }
    return self;
}

- (CGPoint)update:(double)t {
    where.x += [self random];
    where.y += [self random];
    double s = hypot(where.x, where.y) / radius;
    if (s > 1) {
        where.x /= (2 - 1/s);
        where.y /= (2 - 1/s);
    }
    return where;
}

- (double)random {
    double  r = random();
    double  y = (r + 1) / (double)2147483649.; // ensure values +-1 are not used
    // solve for the x value
    double  delta = 2 * (y - 0.5);
    double  eta = 1 - fabs(delta);
    double  xalt = 0, xneu = 0;
    double  error;
    double  c = log(sqrt(M_PI)/2);
    int counter = 0;
    do {
        xneu = xalt + exp(log(erfc(xalt) - eta) + c + xalt * xalt);
        error = fabs(xalt - xneu);
        xalt = xneu;
        counter++;
        //NSLog(@"%d: %f", counter, xneu);
    } while ((counter < 20) && (error > 1e-5
                                ));
    //NSLog(@"random: %f, %d iterations, error = %f", xneu, counter, error);
    if (!(xneu == xneu)) {
        NSLog(@"nan found");
        return 0;
    }
    return xneu * sigma * sqrt(2) * ((delta > 0) ? 1 : -1);
}

@end
