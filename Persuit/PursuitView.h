//
//  PursuitView.h
//  Pursuit
//
//  Created by Andreas Müller on 10.10.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Curve.h"
#import "Pursuit.h"
#import "TouchDelegate.H"

@interface PursuitView : UIView {
    BOOL    showCats;
    Curve   *target;
    CGPoint coordinateCenter;
    CGFloat coordinateWidth;
    NSMutableArray  *pursuers;
    double  radius;
    NSObject<TouchDelegate>   *touchDelegate;
}

@property (readwrite) BOOL showCats;
@property (readwrite) Curve *target;
@property (readwrite) CGPoint coordinateCenter;
@property (readwrite) CGFloat coordinateWidth;
@property (readwrite) double radius;
@property (readonly) CGRect visibleRectangle;
@property (readwrite) NSObject<TouchDelegate> *touchDelegate;

- (id)init;
- (id)initWithFrame:(CGRect)frame;
- (id)initWithCoder:(NSCoder *)aDecoder;
- (NSInteger)numberOfCurves;
- (Curve *)curveAt: (int)i;
- (CGPoint)map: (CGPoint)p;
- (CGPoint)invmap: (CGPoint)p;
- (void)addPursuer: (Curve *)curve;

- (void)drawCurve: (Curve *)curve withColor: (UIColor *)color;
- (void)drawCurves;

- (void)drawHead: (Curve *)curve withColor: (UIColor *)color withCat: (BOOL)cat;
- (void)drawHeads;

- (void)drawRect:(CGRect)rect;
- (void)setCenterCoordinates: (CGPoint)center width: (double)w;

- (void)update: (Pursuit *)pursuit;

- (void)setTrail: (int)l;

@end
