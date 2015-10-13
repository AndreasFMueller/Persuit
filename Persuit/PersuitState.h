//
//  PersuitState.h
//  Persuit
//
//  Created by Andreas Müller on 23.09.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PersuitState : NSObject {
    double  position[2];
    double  velocity[2];
    double  strength;
}

// setting inertia to zero means that the current velocity is ignored
// when computing an update.
@property(readwrite) double inertia;
@property(readonly) CGPoint where;
@property(readwrite) double strength;

- (id)initX: (double)x Y: (double)y;
- (void)updateX: (double)x Y: (double) y DeltaT: (double)dt;
- (void)update: (CGPoint)p DeltaT: (double)dt;
- (PersuitState *)forceX: (double)x Y: (double) y;

@end
