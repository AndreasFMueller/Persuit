//
//  PolygonUpdaterView.m
//  Pursuit
//
//  Created by Andreas Müller on 13.10.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import "PolygonUpdaterView.h"

@implementation PolygonUpdaterView

- (id)initWithFrame:(CGRect)frame updater: (UpdaterBase*) u {
    self = [super initWithFrame: frame updater: u];
    if (self) {
        NSLog(@"PolygonUpdaterView initialized");
    }
    return self;
}

@end
