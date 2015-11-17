//
//  Curve.h
//  Pursuit
//
//  Created by Andreas Müller on 23.09.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Curve : NSObject {
    CGPoint *points;
    int n;
    int current_size;
    int maxLength;
}

@property (readwrite) int maxLength;

- (id)init;
- (int)numberOfPoints;
- (CGPoint)pointAt: (int)i;
- (void)addPoint: (CGPoint)p;
- (void)trimTo: (int)length;
- (NSString *)description;

@end
