//
//  RandomUpdaterController.m
//  Persuit
//
//  Created by Andreas Müller on 13.10.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import "RandomUpdaterController.h"
#import "RandomUpdaterView.h"

@implementation RandomUpdaterController

- (void)loadView {
    NSLog(@"loading the RandomUpdaterView");
    [super loadView];
    updaterView = [[RandomUpdaterView alloc] initWithFrame: CGRectMake(512, 600, 512, 168) updater: updater];
    
    UILabel *sigmaLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 58, 50, 40)];
    sigmaLabel.text = @"σ:";
    sigmaLabel.textAlignment = NSTextAlignmentRight;
    [updaterView addSubview: sigmaLabel];
    
    UILabel *radiusLabel = [[UILabel alloc] initWithFrame: CGRectMake(256, 58, 50, 40)];
    radiusLabel.text = @"r:";
    radiusLabel.textAlignment = NSTextAlignmentRight;
    [updaterView addSubview: radiusLabel];

    sigmaSlider = [[UISlider alloc] initWithFrame: CGRectMake(50, 58, 200, 40)];
    sigmaSlider.minimumValue = 0.01;
    sigmaSlider.maximumValue = 1.;
    sigmaSlider.value = self.randomUpdater.sigma;
    [sigmaSlider addTarget:self action:@selector(sigmaChanged:) forControlEvents:UIControlEventValueChanged];
    [updaterView addSubview: sigmaSlider];
    
    radiusSlider = [[UISlider alloc] initWithFrame: CGRectMake(306, 58, 200, 40)];
    radiusSlider.minimumValue = 0.1;
    radiusSlider.maximumValue = 2.;
    radiusSlider.value = self.randomUpdater.radius;
    [radiusSlider addTarget:self action:@selector(radiusChanged:) forControlEvents:UIControlEventValueChanged];
    [updaterView addSubview: radiusSlider];

    self.view = updaterView;
}

- (void)viewDidLoad {
    NSLog(@"LissajousUpdaterView loaded");
    [super viewDidLoad];
}

- (RandomUpdater*)randomUpdater {
    return (RandomUpdater*)updater;
}

- (void)sigmaChanged: (id)sender {
    if (sender != sigmaSlider) {
        return;
    }
    self.randomUpdater.sigma = sigmaSlider.value;
}

- (void)radiusChanged: (id)sender {
    if (sender != radiusSlider) {
        return;
    }
    self.randomUpdater.radius = radiusSlider.value;
}


@end
