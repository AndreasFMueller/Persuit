//
//  PersuitView.m
//  Persuit
//
//  Created by Andreas Müller on 10.10.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import "PersuitView.h"

@implementation PersuitView

@synthesize showCats, target, radius, coordinateCenter, coordinateWidth, touchDelegate;

- (void)initCommon {
    radius = 5;
    persuers = [[NSMutableArray alloc] init];
    touchDelegate = nil;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (nil != self) {
        NSLog(@"initWithFrame: %@", [self description]);
        [self initCommon];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (nil != self) {
        NSLog(@"initWithCoder: %@", [self description]);
        [self initCommon];
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        NSLog(@"init: %@", [self description]);
        [self initCommon];
    }
    return self;
}

- (CGRect)visibleRectangle {
    double w = coordinateWidth;
    double h = w * self.bounds.size.height / self.bounds.size.width;
    return CGRectMake(coordinateCenter.x - w/2, coordinateCenter.y - h/2, w, h);
}

- (NSInteger)numberOfCurves {
    return [persuers count];
}

- (Curve *)curveAt: (int)i {
    return (Curve *)[persuers objectAtIndex: i];
}

/**
 * \brief Convert a point from the curve into the view coordinate system
 */
- (CGPoint)map: (CGPoint)p {
    CGRect  vr = self.visibleRectangle;
    //NSLog(@"aspect: %f %f", vr.size.width / vr.size.height, self.bounds.size.width / self.bounds.size.height);
    double x = self.bounds.size.width * (p.x - vr.origin.x) / vr.size.width;
    double y = self.bounds.size.height * (p.y - vr.origin.y) / vr.size.height;
    CGPoint result = CGPointMake(x, y);
    //NSLog(@"%@ -> %@", NSStringFromCGPoint(p), NSStringFromCGPoint(result));
    return result;
}

- (CGPoint)invmap: (CGPoint)p {
    CGRect  vr = self.visibleRectangle;
    double x = p.x * vr.size.width / self.bounds.size.width + vr.origin.x;
    double y = p.y * vr.size.height / self.bounds.size.height + vr.origin.y;
    CGPoint result = CGPointMake(x, y);
    return result;
}

#define u   0.5

- (void)drawCat: (CGPoint)center withColor: (UIColor *)color direction: (double)angle {

    CGAffineTransform   transform = CGAffineTransformRotate(CGAffineTransformMakeTranslation(center.x, center.y), angle);
    CGContextRef    ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, color.CGColor);
    CGMutablePathRef    catPath = CGPathCreateMutable();
    CGPathMoveToPoint(catPath, &transform,                                               -40 * u, -50 * u);
    CGPathAddCurveToPoint(catPath, &transform, -45 * u, -45 * u,    -50 * u, -30 * u,    -50 * u, -25 * u);
    CGPathAddCurveToPoint(catPath, &transform, -50 * u,  10 * u,    -20 * u,  30 * u,          0,  30 * u);
    CGPathAddCurveToPoint(catPath, &transform,  20 * u,  30 * u,     50 * u,  10 * u,     50 * u, -25 * u);
    CGPathAddCurveToPoint(catPath, &transform,  50 * u, -30 * u,     45 * u, -45 * u,     40 * u, -50 * u);
    CGPathAddLineToPoint(catPath, &transform,                                             25 * u, -30 * u);
    CGPathAddCurveToPoint(catPath, &transform,  10 * u, -40 * u,    -10 * u, -40 * u,    -25 * u, -30 * u);
    CGPathCloseSubpath(catPath);
    CGContextAddPath(ctx, catPath);
    CGContextFillPath(ctx);

    CGContextSetRGBFillColor(ctx, 1, 1, 1, 1);

    catPath = CGPathCreateMutable();
    CGPathMoveToPoint(catPath, &transform,                                             -6 * u,   0 * u);
    CGPathAddLineToPoint(catPath, &transform,                                         -16 * u,  -5 * u);
    CGPathAddLineToPoint(catPath, &transform,                                         -21 * u,   2 * u);
    CGPathAddLineToPoint(catPath, &transform,                                         -20 * u,  -7 * u);
    CGPathAddLineToPoint(catPath, &transform,                                         -30 * u, -10 * u);
    CGPathAddCurveToPoint(catPath, &transform, -30 * u,   4 * u,    -16 * u, 10 * u,   -6 * u,   0 * u);
    CGPathCloseSubpath(catPath);
    CGContextAddPath(ctx, catPath);
    
    catPath = CGPathCreateMutable();
    CGPathMoveToPoint(catPath, &transform,                                              6 * u,   0 * u);
    CGPathAddLineToPoint(catPath, &transform,                                          16 * u,  -5 * u);
    CGPathAddLineToPoint(catPath, &transform,                                          21 * u,   2 * u);
    CGPathAddLineToPoint(catPath, &transform,                                          20 * u,  -7 * u);
    CGPathAddLineToPoint(catPath, &transform,                                          30 * u, -10 * u);
    CGPathAddCurveToPoint(catPath, &transform,  30 * u,   4 * u,     16 * u, 10 * u,    6 * u,   0 * u);
    CGPathCloseSubpath(catPath);
    CGContextAddPath(ctx, catPath);

    CGContextFillPath(ctx);
}

- (void)drawPoint: (CGPoint)p withColor: (UIColor *)color {
    CGContextRef    ctx = UIGraphicsGetCurrentContext();
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, p.x + radius, p.y);
    double  step = M_PI / 20;
    for (int i = 0; i < 39; i++) {
        CGContextAddLineToPoint(ctx, p.x + radius * cos(i * step), p.y + radius * sin(i * step));
    }
    CGContextClosePath(ctx);
    CGContextSetFillColorWithColor(ctx, color.CGColor);
    CGContextFillPath(ctx);
    CGContextStrokePath(ctx);

}

- (void)drawCurve: (Curve *)curve withColor: (UIColor *)color {
    if ([curve numberOfPoints] == 0) {
        return;
    }
    //NSLog(@"drawing curve %@", [curve description]);
    CGContextRef    ctx = UIGraphicsGetCurrentContext();
#if 0
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGFloat colorcomponents[4] = { 0.9, 0.9, 0.9, 1.0 };
    CGColorRef    bgColor = CGColorCreate(colorspace, colorcomponents);
    CGContextSetFillColorWithColor(ctx, bgColor);
    CGContextFillRect(ctx, self.bounds);
#endif
    CGContextSetLineWidth(ctx, 3);
    
    CGFloat red, green, blue, alpha;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    // curve needs to be displayed
    CGPoint p = [self map: [curve pointAt: 0]];
    if ([curve numberOfPoints] > 1) {
        for (int i = 0; i < [curve numberOfPoints] - 1; i++) {
            CGContextBeginPath(ctx);
            CGContextSetStrokeColorWithColor(ctx, color.CGColor);
            p = [self map: [curve pointAt: i]];
            CGContextMoveToPoint(ctx, p.x, p.y);
            p = [self map: [curve pointAt: i + 1]];
            CGContextAddLineToPoint(ctx, p.x, p.y);
            UIColor    *newcolor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha * (1 - i/(double)[curve numberOfPoints])];
            CGContextSetStrokeColorWithColor(ctx, newcolor.CGColor);
            CGContextStrokePath(ctx);
        }
    }
    //NSLog(@"curve drawn");
}

- (void)drawHead: (Curve *)curve withColor: (UIColor *)color withCat: (BOOL)cat {
    // display the curve head as a point/cat
    CGPoint p = [self map: [curve pointAt: 0]];
    if (cat) {
        double  angle = 0;
        if ([curve numberOfPoints] > 1) {
            CGPoint q = [self map: [curve pointAt: 1]];
            angle = (M_PI / 2) + atan2(q.y - p.y, q.x - p.x);
            //NSLog(@"%@ %@ angle = %f", NSStringFromCGPoint(p), NSStringFromCGPoint(q), 2 * angle / M_PI);
        }
        [self drawCat: p withColor: color direction: angle];
    } else {
        [self drawPoint: p withColor: color];
    }
}

- (void)drawHeads {
    for (int i = 0; i < [self numberOfCurves]; i++) {
        Curve   *curve = [self curveAt: i];
        [self drawHead: curve withColor: [UIColor blackColor] withCat: showCats];
    }
    [self drawHead: target withColor: [UIColor redColor] withCat: NO];
}

- (void)drawCurves {
    //NSLog(@"drawing %d curves", [self numberOfCurves] + 1);
    [self drawCurve: target withColor: [UIColor redColor]];
    for (int i = 0; i < [self numberOfCurves]; i++) {
        Curve   *curve = [self curveAt: i];
        [self drawCurve: curve withColor: [UIColor blackColor] ];
    }
    [self drawHeads];
}

- (void)drawRect:(CGRect)rect {
    [self drawCurves];
}

- (void)setCenterCoordinates: (CGPoint)center width: (double)w {
    self.coordinateCenter = center;
    self.coordinateWidth = w;
    NSLog(@"visibleRectangle = %@", NSStringFromCGRect(self.visibleRectangle));
}

- (void)addPersuer: (Curve *)curve {
    NSLog(@"adding curve");
    [persuers addObject: curve];
}

- (void)update: (Persuit *)persuit {
    [target addPoint: persuit.target];
    
    for (int i = 0; i < [persuit numberOfPersuers]; i++) {
        CGPoint p = [persuit stateAt:i].where;
        [[self curveAt: i] addPoint:p];
    }
    [self setNeedsDisplay];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan: %d", [touches count]);
    if (touchDelegate) {
        if ([touches count] == 1) {
            UITouch *touch = [touches anyObject];
            CGPoint p = [self invmap:[touch locationInView: self]];
            NSLog(@"touch begins: %@", NSStringFromCGPoint(p));
            [touchDelegate position: p];
        }
    } else {
        [super touchesBegan:touches withEvent:event];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent: (UIEvent *)event {
    NSLog(@"touchesMoved: %d", [touches count]);
    if (touchDelegate) {
        if ([touches count] == 1) {
            UITouch *touch = [touches anyObject];
            CGPoint p = [self invmap:[touch locationInView: self]];
            NSLog(@"touch moves: %@", NSStringFromCGPoint(p));
            [touchDelegate position: p];
        }
    } else {
        [super touchesMoved:touches withEvent:event];
    }
}

- (void)setTrail: (int)l {
    target.maxLength = l;
    for (int i = 0; i < [self numberOfCurves]; i++) {
        [self curveAt:i].maxLength = l;
    }
}


@end
