//
//  TouchUpdaterView.m
//  Pursuit
//
//  Created by Andreas Müller on 13.10.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import "TouchUpdaterView.h"

@implementation TouchUpdaterView

- (id)initWithFrame:(CGRect)frame updater: (UpdaterBase*) u {
    self = [super initWithFrame: frame updater: u];
    if (self) {
        NSLog(@"TouchUpdaterView initialized");
    }
    return self;
}


@end
