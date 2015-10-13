//
//  PolygonUpdater.h
//  Persuit
//
//  Created by Andreas Müller on 13.10.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import "UpdaterBase.h"

@interface PolygonUpdater : UpdaterBase {
    int n;
    int skip;
    double w;
    double h;
}

@property(readwrite) int n;
@property(readwrite) int skip;
@property(readwrite) double w;
@property(readwrite) double h;

- (id)init:(Persuit *)p;
- (CGPoint)update:(double)t;

@end
