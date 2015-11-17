//
//  UpdaterBase.m
//  Pursuit
//
//  Created by Andreas Müller on 13.10.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import "UpdaterBase.h"

@implementation UpdaterBase

@synthesize pursuit, displayName, speed;

- (id)init: (Pursuit *)p {
    self = [super init];
    if (self) {
        self.pursuit = p;
        displayName = @"Base";
        speed = 1;
    }
    return self;
}

- (CGPoint)update: (double)t {
    NSLog(@"update in updater base class, should override");
    return CGPointMake(0, 0);
}

@end
