//
//  Persuit.m
//  Persuit
//
//  Created by Andreas Müller on 11.10.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import "Persuit.h"
#import "PersuitState.h"

@implementation Persuit

@synthesize currentTime, target;

- (id)init {
    self = [super init];
    if (self) {
        persuers = [[NSMutableArray alloc] init];
    }
    return self;
}

- (int)numberOfPersuers {
    return [persuers count];
}

- (PersuitState *)stateAt: (int)i {
    return (PersuitState *)[persuers objectAtIndex:i];
}

- (void)addPersuer: (PersuitState *)persuer {
    [persuers addObject: persuer];
}

- (void)update: (double) t x: (double)x y: (double)y {
    target = CGPointMake(x, y);
    for (int i = 0; i < [self numberOfPersuers]; i++) {
        PersuitState    *state = [self stateAt: i];
        [state updateX: x Y: y DeltaT: t - currentTime];
    }
    currentTime = t;
}

- (void)update: (double) t point: (CGPoint)p {
    [self update: t x: p.x y: p.y];
}

- (void)setVelocity: (double)v {
    for (int i = 0; i < [self numberOfPersuers]; i++) {
        [self stateAt: i].strength = v;
    }
}

@end
