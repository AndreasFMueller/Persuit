//
//  UpdaterView.m
//  Pursuit
//
//  Created by Andreas Müller on 13.10.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import "UpdaterView.h"

@implementation UpdaterView

@synthesize updater;

- (id)initWithFrame:(CGRect)frame updater: (UpdaterBase *)u {
    self = [super initWithFrame:frame];
    if (self) {
        updater = u;
    }
    return self;
}

@end
