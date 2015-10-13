//
//  Curve.m
//  Persuit
//
//  Created by Andreas Müller on 23.09.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import "Curve.h"

@implementation Curve

@synthesize maxLength;

#define CHUNK_SIZE  100

- (id)init {
    self = [super init];
    if (self) {
        points = calloc(CHUNK_SIZE, sizeof(CGPoint));
        current_size = CHUNK_SIZE;
        maxLength = -1;
    }
    return self;
}

- (int)numberOfPoints {
    return n;
}

- (CGPoint)pointAt: (int)i {
    if ((i < 0) || (i >= n)) {
        // throw an exception
        NSLog(@"index out of range: %d (max = %d)", i, n);
    }
    return points[i];
}

- (void)addPoint: (CGPoint)p {
    if ((n + 1) > current_size) {
        current_size += CHUNK_SIZE;
        points = realloc(points, current_size * sizeof(CGPoint));
    }
    n = n + 1;
    if (maxLength > 0) {
        if (n > maxLength) {
            n = maxLength;
        }
    }
    // move points back
    for (int i = n - 1; i >= 0; i--) {
        points[i + 1] = points[i];
    }
    // add the new point
    points[0] = p;
};

- (void)trimTo:(int)length {
    if (length <= n) {
        n = length;
    }
}

- (NSString *)description {
    return [NSString stringWithFormat: @"%@: %d points", [super description], n];
}

@end
