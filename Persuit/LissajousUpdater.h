//
//  LissajousUpdater.h
//  Pursuit
//
//  Created by Andreas Müller on 13.10.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import "UpdaterBase.h"

@interface LissajousUpdater : UpdaterBase {
    double a;
    double b;
    double delta;
    double w;
    double h;
}

@property (readwrite) double a;
@property (readwrite) double b;
@property (readwrite) double delta;
@property (readwrite) double w;
@property (readwrite) double h;

- (id)init: (Pursuit*)p;
- (CGPoint)update: (double)t;

@end
