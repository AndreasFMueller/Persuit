//
//  TouchUpdaterController.m
//  Pursuit
//
//  Created by Andreas Müller on 13.10.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import "TouchUpdaterController.h"
#import "TouchUpdaterView.h"

@implementation TouchUpdaterController

- (void)loadView {
    NSLog(@"loading the TouchUpdaterView");
    [super loadView];
    updaterView = [[TouchUpdaterView alloc] initWithFrame: CGRectMake(512, 600, 512, 168) updater: updater];
    
    self.view = updaterView;
}

- (void)viewDidLoad {
    NSLog(@"TouchUpdaterView loaded");
    [super viewDidLoad];
}

- (TouchUpdater*)touchUpdater {
    return (TouchUpdater*)updater;
}

@end
