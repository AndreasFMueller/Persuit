//
//  UpdaterController.m
//  Pursuit
//
//  Created by Andreas Müller on 13.10.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import "UpdaterController.h"

@implementation UpdaterController

@synthesize updater, updaterView;

- (id)init: (UpdaterBase *)u {
    self = [super init];
    if (self) {
        updaterView = nil;
        updater = u;
    }
    return self;
}

- (NSString *)displayName {
    return updater.displayName;
}

- (void)activate: (UIView *)parentView {
    NSLog(@"activating %@ / %@ in %@", [self description], [updaterView description], [parentView description]);
    updaterView.hidden = NO;
    if (nil == updaterView) {
        [self loadView];
    }
    [parentView addSubview: updaterView];
    [updaterView setNeedsDisplay];
}

@end
