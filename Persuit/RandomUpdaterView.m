//
//  RandomUpdaterView.m
//  Persuit
//
//  Created by Andreas Müller on 13.10.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import "RandomUpdaterView.h"

@implementation RandomUpdaterView

- (id)initWithFrame:(CGRect)frame updater: (UpdaterBase*) u {
    self = [super initWithFrame: frame updater: u];
    if (self) {
        NSLog(@"RandomUpdaterView initialized");
    }
    return self;
}

@end
