//
//  LissajousUpdaterView.m
//  Pursuit
//
//  Created by Andreas Müller on 13.10.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import "LissajousUpdaterView.h"

@implementation LissajousUpdaterView

- (id)initWithFrame:(CGRect)frame updater: (UpdaterBase*) u {
    self = [super initWithFrame: frame updater: u];
    if (self) {
        NSLog(@"LissajousUpdaterView initialized");
    }
    return self;
}

@end
