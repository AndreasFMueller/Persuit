//
//  RandomUpdaterController.h
//  Persuit
//
//  Created by Andreas Müller on 13.10.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import "UpdaterController.h"
#import "RandomUpdater.h"

@interface RandomUpdaterController : UpdaterController {
    UISlider    *sigmaSlider;
    UISlider    *radiusSlider;
}

@property(readonly) RandomUpdater *randomUpdater;

- (void)sigmaChanged: (id)sender;
- (void)radiusChanged: (id)sender;

@end
