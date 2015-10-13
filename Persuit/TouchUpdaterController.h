//
//  TouchUpdaterController.h
//  Persuit
//
//  Created by Andreas Müller on 13.10.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import "UpdaterController.h"
#import "TouchUpdater.h"

@interface TouchUpdaterController : UpdaterController {
}

@property(readonly) TouchUpdater *touchUpdater;

@end
