//
//  PolygonUpdaterController.m
//  Pursuit
//
//  Created by Andreas Müller on 13.10.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import "PolygonUpdaterController.h"
#import "PolygonUpdaterView.h"

@implementation PolygonUpdaterController

- (void)loadView {
    NSLog(@"loading the PolygonUpdaterView");
    [super loadView];
    updaterView = [[PolygonUpdaterView alloc] initWithFrame: CGRectMake(512, 600, 512, 168) updater: updater];
    
    UILabel *nLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 8, 50, 40)];
    nLabel.text = @"n:";
    nLabel.textAlignment = NSTextAlignmentRight;
    [updaterView addSubview: nLabel];
    
    UILabel *skipLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 58, 50, 40)];
    skipLabel.text = @"skip:";
    skipLabel.textAlignment = NSTextAlignmentRight;
    [updaterView addSubview: skipLabel];
    
    UILabel *continuousLabel = [[UILabel alloc] initWithFrame: CGRectMake(-60, 108, 110, 40)];
    continuousLabel.text = @"continous:";
    continuousLabel.textAlignment = NSTextAlignmentRight;
    [updaterView addSubview: continuousLabel];
    
    UILabel *wLabel = [[UILabel alloc] initWithFrame: CGRectMake(256, 8, 50, 40)];
    wLabel.text = @"w:";
    wLabel.textAlignment = NSTextAlignmentRight;
    [updaterView addSubview: wLabel];
    
    UILabel *hLabel = [[UILabel alloc] initWithFrame: CGRectMake(256, 58, 50, 40)];
    hLabel.text = @"h:";
    hLabel.textAlignment = NSTextAlignmentRight;
    [updaterView addSubview: hLabel];
    
    UILabel *vLabel = [[UILabel alloc] initWithFrame: CGRectMake(256, 108, 50, 40)];
    vLabel.text = @"v:";
    vLabel.textAlignment = NSTextAlignmentRight;
    [updaterView addSubview: vLabel];
    
    nSlider = [[UISlider alloc] initWithFrame: CGRectMake(50, 8, 200, 40)];
    nSlider.minimumValue = 1.;
    nSlider.maximumValue = 20.;
    nSlider.value = self.polygonUpdater.n;
    [nSlider addTarget:self action:@selector(nChanged:) forControlEvents:UIControlEventValueChanged];
    [updaterView addSubview: nSlider];
    
    skipSlider = [[UISlider alloc] initWithFrame: CGRectMake(50, 58, 200, 40)];
    skipSlider.minimumValue = 1.;
    skipSlider.maximumValue = 20.;
    skipSlider.value = self.polygonUpdater.skip;
    [skipSlider addTarget:self action:@selector(skipChanged:) forControlEvents:UIControlEventValueChanged];
    [updaterView addSubview: skipSlider];
    
    continuousSwitch = [[UISwitch alloc] initWithFrame: CGRectMake(50, 108, 200, 40)];
    continuousSwitch.on = YES;
    [continuousSwitch addTarget:self action:@selector(continuousChanged:) forControlEvents: UIControlEventValueChanged];
    [updaterView addSubview: continuousSwitch];
    
    wSlider = [[UISlider alloc] initWithFrame: CGRectMake(306, 8, 200, 40)];
    wSlider.minimumValue = 0.1;
    wSlider.maximumValue = 2.;
    wSlider.value = self.polygonUpdater.w;
    [wSlider addTarget:self action:@selector(wChanged:) forControlEvents:UIControlEventValueChanged];
    [updaterView addSubview: wSlider];
    
    hSlider = [[UISlider alloc] initWithFrame: CGRectMake(306, 58, 200, 40)];
    hSlider.minimumValue = 0.1;
    hSlider.maximumValue = 1.5;
    hSlider.value = self.polygonUpdater.h;
    [hSlider addTarget:self action:@selector(hChanged:) forControlEvents:UIControlEventValueChanged];
    [updaterView addSubview: hSlider];
    
    vSlider = [[UISlider alloc] initWithFrame: CGRectMake(306, 108, 200, 40)];
    vSlider.minimumValue = 0.1;
    vSlider.maximumValue = 5;
    vSlider.value = self.polygonUpdater.speed;
    [vSlider addTarget:self action:@selector(vChanged:) forControlEvents:UIControlEventValueChanged];
    [updaterView addSubview: vSlider];
    
    self.view = updaterView;
}

- (void)viewDidLoad {
    NSLog(@"PolygonUpdaterView loaded");
    [super viewDidLoad];
}

- (PolygonUpdater*)polygonUpdater {
    return (PolygonUpdater*)updater;
}

- (void)nChanged: (id)sender {
    if (sender != nSlider) {
        return;
    }
    self.polygonUpdater.n = round(nSlider.value);
}

- (void)skipChanged: (id)sender {
    if (sender != skipSlider) {
        return;
    }
    self.polygonUpdater.skip = round(skipSlider.value);
}

- (void)wChanged: (id)sender {
    if (sender != wSlider) {
        return;
    }
    self.polygonUpdater.w = wSlider.value;
}

- (void)hChanged: (id)sender {
    if (sender != hSlider) {
        return;
    }
    self.polygonUpdater.h = hSlider.value;
}

- (void)vChanged: (id)sender {
    if (sender != vSlider) {
        return;
    }
    self.polygonUpdater.speed = vSlider.value;
}

- (void)continuousChanged:(id)sender {
    if (sender != continuousSwitch) {
        return;
    }
    self.polygonUpdater.continuous = continuousSwitch.isOn;
}

@end
