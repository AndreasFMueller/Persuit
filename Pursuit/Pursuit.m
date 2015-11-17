//
//  Pursuit.m
//  Pursuit
//
//  Created by Andreas Müller on 11.10.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import "Pursuit.h"
#import "PursuitState.h"

@implementation Pursuit

@synthesize currentTime, target;

- (id)init {
    self = [super init];
    if (self) {
        pursuers = [[NSMutableArray alloc] init];
    }
    return self;
}

- (int)numberOfPursuers {
    return [pursuers count];
}

- (PursuitState *)stateAt: (int)i {
    return (PursuitState *)[pursuers objectAtIndex:i];
}

- (void)addPursuer: (PursuitState *)pursuer {
    [pursuers addObject: pursuer];
}

- (void)update: (double) t x: (double)x y: (double)y {
    target = CGPointMake(x, y);
    for (int i = 0; i < [self numberOfPursuers]; i++) {
        PursuitState    *state = [self stateAt: i];
        [state updateX: x Y: y DeltaT: t - currentTime];
    }
    currentTime = t;
}

- (void)update: (double) t point: (CGPoint)p {
    [self update: t x: p.x y: p.y];
}

- (void)setVelocity: (double)v {
    for (int i = 0; i < [self numberOfPursuers]; i++) {
        [self stateAt: i].strength = v;
    }
}

@end
