//
//  LissajousUpdaterController.m
//  Pursuit
//
//  Created by Andreas Müller on 13.10.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import "LissajousUpdaterController.h"
#import "LissajousUpdaterView.h"

@implementation LissajousUpdaterController


- (void)loadView {
    NSLog(@"loading the LissajousUpdaterView");
    [super loadView];
    updaterView = [[LissajousUpdaterView alloc] initWithFrame: CGRectMake(512, 600, 512, 168) updater: updater];
    
    UILabel *aLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 8, 50, 40)];
    aLabel.text = @"a:";
    aLabel.textAlignment = NSTextAlignmentRight;
    [updaterView addSubview: aLabel];
    
    UILabel *bLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 58, 50, 40)];
    bLabel.text = @"b:";
    bLabel.textAlignment = NSTextAlignmentRight;
    [updaterView addSubview: bLabel];
    
    UILabel *deltaLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 108, 50, 40)];
    deltaLabel.text = @"δ:";
    deltaLabel.textAlignment = NSTextAlignmentRight;
    [updaterView addSubview: deltaLabel];
    
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
    
    aSlider = [[UISlider alloc] initWithFrame: CGRectMake(50, 8, 200, 40)];
    aSlider.minimumValue = 1.;
    aSlider.maximumValue = 10.;
    aSlider.value = self.lissajousUpdater.a;
    [aSlider addTarget:self action:@selector(aChanged:) forControlEvents:UIControlEventValueChanged];
    [updaterView addSubview: aSlider];
    
    bSlider = [[UISlider alloc] initWithFrame: CGRectMake(50, 58, 200, 40)];
    bSlider.minimumValue = 1.;
    bSlider.maximumValue = 10.;
    bSlider.value = self.lissajousUpdater.b;
    [bSlider addTarget:self action:@selector(bChanged:) forControlEvents:UIControlEventValueChanged];
    [updaterView addSubview: bSlider];
    
    deltaSlider = [[UISlider alloc] initWithFrame: CGRectMake(50, 108, 200, 40)];
    deltaSlider.minimumValue = 0.;
    deltaSlider.maximumValue = 2 * M_PI;
    deltaSlider.value = self.lissajousUpdater.delta;
    [deltaSlider addTarget:self action:@selector(deltaChanged:) forControlEvents:UIControlEventValueChanged];
    [updaterView addSubview: deltaSlider];
    
    wSlider = [[UISlider alloc] initWithFrame: CGRectMake(306, 8, 200, 40)];
    wSlider.minimumValue = 0.1;
    wSlider.maximumValue = 2.;
    wSlider.value = self.lissajousUpdater.w;
    [wSlider addTarget:self action:@selector(wChanged:) forControlEvents:UIControlEventValueChanged];
    [updaterView addSubview: wSlider];
    
    hSlider = [[UISlider alloc] initWithFrame: CGRectMake(306, 58, 200, 40)];
    hSlider.minimumValue = 0.1;
    hSlider.maximumValue = 1.5;
    hSlider.value = self.lissajousUpdater.h;
    [hSlider addTarget:self action:@selector(hChanged:) forControlEvents:UIControlEventValueChanged];
    [updaterView addSubview: hSlider];
    
    vSlider = [[UISlider alloc] initWithFrame: CGRectMake(306, 108, 200, 40)];
    vSlider.minimumValue = 0.1;
    vSlider.maximumValue = 5;
    vSlider.value = self.lissajousUpdater.speed;
    [vSlider addTarget:self action:@selector(vChanged:) forControlEvents:UIControlEventValueChanged];
    [updaterView addSubview: vSlider];

    self.view = updaterView;
}

- (void)viewDidLoad {
    NSLog(@"LissajousUpdaterView loaded");
    [super viewDidLoad];
}

- (LissajousUpdater*)lissajousUpdater {
    return (LissajousUpdater*)updater;
}

- (void)aChanged: (id)sender {
    if (sender != aSlider) {
        return;
    }
    self.lissajousUpdater.a = round(aSlider.value);
}

- (void)bChanged: (id)sender {
    if (sender != bSlider) {
        return;
    }
    self.lissajousUpdater.b = round(bSlider.value);
}

- (void)deltaChanged: (id)sender {
    if (sender != deltaSlider) {
        return;
    }
    self.lissajousUpdater.delta = deltaSlider.value;
}

- (void)wChanged: (id)sender {
    if (sender != wSlider) {
        return;
    }
    self.lissajousUpdater.w = wSlider.value;
}

- (void)hChanged: (id)sender {
    if (sender != hSlider) {
        return;
    }
    self.lissajousUpdater.h = hSlider.value;
}

- (void)vChanged: (id)sender {
    if (sender != vSlider) {
        return;
    }
    self.lissajousUpdater.speed = vSlider.value;
}


@end
