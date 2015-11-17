//
//  PursuitState.m
//  Pursuit
//
//  Created by Andreas Müller on 23.09.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import "PursuitState.h"

@implementation PursuitState

@synthesize strength;

- (id)initX: (double)x Y: (double)y {
    self = [super init];
    if (self) {
        position[0] = x;
        position[1] = y;
        velocity[0] = 0;
        velocity[1] = 0;
        strength = 1;
    }
    return self;
}

- (CGPoint)where {
    return CGPointMake(position[0], position[1]);
}

- (void)updateX: (double)x Y: (double) y DeltaT: (double)dt {
    // compute force
    PursuitState    *change = [self forceX: x Y: y];
    position[0] += dt * (self.inertia * velocity[0] + change->position[0]) + 0.5 * dt * dt * change->velocity[0];
    position[1] += dt * (self.inertia * velocity[1] + change->position[1]) + 0.5 * dt * dt * change->velocity[1];
    velocity[0] += dt * change->velocity[0];
    velocity[1] += dt * change->velocity[1];
}

- (void)update: (CGPoint)p DeltaT: (double)dt {
    [self updateX: p.x Y: p.y DeltaT: dt];
}


// computes the "force", override in derived classes to implement different behaviour
- (PursuitState *)forceX: (double)x Y: (double) y {
    PursuitState    *change = [[PursuitState alloc] init];
    double  deltax = x - position[0];
    double  deltay = y - position[1];
    double  l = hypot(deltax, deltay);
    change->position[0] = strength * deltax / l;
    change->position[1] = strength * deltay / l;
    change->velocity[0] = 0;
    change->velocity[1] = 0;
    return change;
}

@end
