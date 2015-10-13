//
//  LissajousUpdaterController.h
//  Persuit
//
//  Created by Andreas Müller on 13.10.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import "UpdaterController.h"
#import "LissajousUpdater.h"

@interface LissajousUpdaterController : UpdaterController {
    UISlider    *aSlider;
    UISlider    *bSlider;
    UISlider    *deltaSlider;
    UISlider    *wSlider;
    UISlider    *hSlider;
    UISlider    *vSlider;
}

@property(readonly) LissajousUpdater *lissajousUpdater;

- (void)aChanged: (id)sender;
- (void)bChanged: (id)sender;
- (void)deltaChanged: (id)sender;
- (void)wChanged: (id)sender;
- (void)hChanged: (id)sender;
- (void)vChanged: (id)sender;

@end
