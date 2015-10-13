//
//  UpdaterSelectionDelegate.h
//  Persuit
//
//  Created by Andreas Müller on 13.10.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UpdaterController.h"

@protocol UpdaterSelectionDelegate

- (void)useUpdaterController: (UpdaterController *)updater;

@end
