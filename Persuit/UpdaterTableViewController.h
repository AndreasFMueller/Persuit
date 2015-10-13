//
//  UpdaterTableViewController.h
//  Persuit
//
//  Created by Andreas Müller on 13.10.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UpdaterController.h"
#import "UpdaterBase.h"
#import "UpdaterSelectionDelegate.h"
#import "TouchDelegate.h"

@interface UpdaterTableViewController : UITableViewController<UITableViewDataSource, TouchDelegate> {
    NSMutableArray *updaters;
    NSObject<UpdaterSelectionDelegate>    *updaterSelectionDelegate;
    UIView  *parentView;
}

@property (readwrite) NSObject<UpdaterSelectionDelegate>    *updaterSelectionDelegate;
@property (readwrite) UIView *parentView;

- (id)init: (Persuit *)p;
- (NSInteger)numberOfUpdaterControllers;
- (UpdaterController *)updaterControllerAt: (int)i;
- (void)addUpdaterController: (UpdaterController *)updater;
- (void)selectUpdaterController: (int)i;

@end
