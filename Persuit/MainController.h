//
//  MainController.h
//  Persuit
//
//  Created by Andreas Müller on 10.10.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersuitView.h"
#import "Persuit.h"
#import "ExternalViewController.h"
#import "UpdaterBase.h"
#import "UpdaterTableViewController.h"
#import "UpdaterSelectionDelegate.h"

@interface MainController : UIViewController<UpdaterSelectionDelegate> {
    IBOutlet PersuitView *persuitView;
    IBOutlet UIButton   *startButton;
    IBOutlet UISlider   *velocitySlider;
    IBOutlet UISlider   *trailSlider;
    IBOutlet UISwitch   *catSwitch;
    UpdaterTableViewController *updaterTableViewController;
    IBOutlet UITableView    *updaterTableView;
    BOOL    running;
    double  starttime;
    double  lasttime;
    Persuit *persuit;
    ExternalViewController  *externalViewController;
    UpdaterBase *updater;
    UpdaterView *updaterView;
}

@property (readonly) BOOL running;
@property (readonly) Persuit *persuit;
@property (readwrite) UpdaterBase *updater;

- (IBAction)startAction:(id)sender;

- (void)update;

- (IBAction)velocityChanged: (id)sender;
- (IBAction)trailChanged: (id)sender;
- (IBAction)catSwitched: (id)sender;

@end
