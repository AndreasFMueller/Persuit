//
//  Persuit.h
//  Persuit
//
//  Created by Andreas Müller on 11.10.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersuitState.h"

@interface Persuit : NSObject {
    NSMutableArray  *persuers;
    CGPoint target;
    double  currentTime;
}

@property (readwrite) double currentTime;
@property (readwrite) CGPoint target;

- (int)numberOfPersuers;
- (PersuitState *)stateAt: (int)i;
- (void)addPersuer: (PersuitState *)persuer;
- (void)update: (double) t x: (double)x y: (double)y;
- (void)update: (double) t point: (CGPoint)p;
- (void)setVelocity: (double)v;

@end
