//
//  Pursuit.h
//  Pursuit
//
//  Created by Andreas Müller on 11.10.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PursuitState.h"

@interface Pursuit : NSObject {
    NSMutableArray  *pursuers;
    CGPoint target;
    double  currentTime;
}

@property (readwrite) double currentTime;
@property (readwrite) CGPoint target;

- (int)numberOfPursuers;
- (PursuitState *)stateAt: (int)i;
- (void)addPursuer: (PursuitState *)pursuer;
- (void)update: (double) t x: (double)x y: (double)y;
- (void)update: (double) t point: (CGPoint)p;
- (void)setVelocity: (double)v;

@end
