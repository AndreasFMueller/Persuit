//
//  RandomUpdater.h
//  Persuit
//
//  Created by Andreas Müller on 13.10.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import "UpdaterBase.h"

@interface RandomUpdater : UpdaterBase {
    double sigma;
    CGPoint where;
    double radius;
}

@property (readwrite) double sigma;
@property (readwrite) CGPoint where;
@property (readwrite) double radius;

- (id)init:(Persuit *)p;
- (CGPoint)update:(double)t;
- (double)random;

@end
