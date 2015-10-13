//
//  PolygonUpdaterController.h
//  Persuit
//
//  Created by Andreas Müller on 13.10.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import "UpdaterController.h"
#import "PolygonUpdater.h"

@interface PolygonUpdaterController : UpdaterController {
    UISlider    *nSlider;
    UISlider    *skipSlider;
    UISlider    *wSlider;
    UISlider    *hSlider;
    UISlider    *vSlider;
}

@property(readonly) PolygonUpdater *polygonUpdater;

- (void)nChanged: (id)sender;
- (void)skipChanged: (id)sender;
- (void)wChanged: (id)sender;
- (void)hChanged: (id)sender;
- (void)vChanged: (id)sender;

@end
