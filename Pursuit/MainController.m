//
//  MainController.m
//  Pursuit
//
//  Created by Andreas Müller on 10.10.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import "MainController.h"
#include <sys/time.h>
#import "LissajousUpdater.h"
#import "RandomUpdater.h"
#import "TouchUpdater.h"
#import "PolygonUpdater.h"

@implementation MainController

@synthesize running, pursuit, updater;

static double   now() {
    struct timeval tv;
    gettimeofday(&tv, NULL);
    return tv.tv_sec + 1e-6 * tv.tv_usec;
}

- (void)createCurve {
    Curve *c = [[Curve alloc] init];
    c.maxLength = 30;
    double step = M_PI / 200;
    for (int i = 0; i < 400; i++) {
        double  t = i * step;
        [c addPoint: CGPointMake(cos(t), sin(t))];
    }
    pursuitView.target = c;
    NSLog(@"new curve: %@", [c description]);
    [pursuitView setCenterCoordinates: CGPointMake(0, 0) width: 4];
    pursuitView.showCats = YES;
    
    // prepare pursuit state
    pursuit = [[Pursuit alloc] init];
    pursuit.currentTime = 0;
    [pursuit addPursuer: [[PursuitState alloc] initX:  1 Y:  1]];
    [pursuit addPursuer: [[PursuitState alloc] initX: -1 Y:  1]];
    [pursuit addPursuer: [[PursuitState alloc] initX:  1 Y: -1]];
    [pursuit addPursuer: [[PursuitState alloc] initX: -1 Y: -1]];
    
    [pursuit stateAt: 0].strength =  0.3;
    [pursuit stateAt: 1].strength =  0.3;
    [pursuit stateAt: 2].strength =  0.3;
    [pursuit stateAt: 3].strength =  0.3;
    
    // add four curves
    for (int i = 0; i < 4; i++) {
        Curve *catcurve = [[Curve alloc] init];
        catcurve.maxLength = 20;
        CGPoint p = [pursuit stateAt: i].where;
        NSLog(@"add point %@", NSStringFromCGPoint(p));
        [catcurve addPoint: p];
        [pursuitView addPursuer: catcurve];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"MainController view did load");
    // Do any additional setup after loading the view, typically from a nib.
    // set the background color
    NSLog(@"pursuitView: %@", [pursuitView description]);
    running = NO;
    NSTimer *timer = [NSTimer timerWithTimeInterval: TIME_STEP target: self selector: @selector(update)
                                           userInfo: nil repeats: YES];
    [[NSRunLoop currentRunLoop] addTimer: timer forMode: NSDefaultRunLoopMode];
    starttime = now();
    
    // create a curve add it to the view
    [self createCurve];
    [pursuitView setNeedsDisplay];
    
#if 0
    // create the updater
    LissajousUpdater    *lu = [[LissajousUpdater alloc] init: pursuit];
    lu.a = 7;
    lu.b = 5;
    self.updater = lu;
#endif

#if 0
    RandomUpdater   *ru = [[RandomUpdater alloc] init: pursuit];
    self.updater = ru;
#endif
    
#if 0
    TouchUpdater    *tu = [[TouchUpdater alloc] init: pursuit];
    pursuitView.touchDelegate = tu;
    self.updater = tu;
#endif
    
#if 0
    PolygonUpdater   *pu = [[PolygonUpdater alloc] init: pursuit];
    self.updater = pu;
#endif
    
    updaterView = nil;
    
    // add the external view controller
    externalViewController = [[ExternalViewController alloc] init];
    externalViewController.popupView = pursuitView;
    [externalViewController externalMonitor];
    
    // initialize the updater table view controller
    updaterTableViewController = [[UpdaterTableViewController alloc] init: pursuit];
    updaterTableViewController.tableView = updaterTableView;
    updaterTableViewController.updaterSelectionDelegate = self;
    updaterTableViewController.parentView = self.view;
    pursuitView.touchDelegate = updaterTableViewController;
    NSLog(@"selecting the updater");
    [updaterTableViewController selectUpdaterController: 0];
    updaterTableView.dataSource = updaterTableViewController;
    [updaterTableView reloadData];
    NSLog(@"updater selected");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startAction:(id)sender {
    NSLog(@"start action button pressed: '%@'", startButton.titleLabel.text);
    if (sender != startButton) {
        NSLog(@"wrong sender");
        return;
    }
    NSString    *new_label = nil;
    if (!self.running) {
        new_label = @"stop";
        running = YES;
        starttime = now();
        pursuit.currentTime = 0;
    } else {
        new_label = @"start";
        running = NO;
    }
    [startButton setTitle: new_label forState: UIControlStateNormal];
}

- (void)update {
    if (!self.running) {
        return;
    }
    double t = now() - starttime;
    //NSLog(@"update, %.3f", t);
    [pursuit update:t point: [updater update: t]];
    lasttime = t;

    [pursuitView update: pursuit];
    [externalViewController update: pursuitView];
}

- (IBAction)velocityChanged: (id)sender {
    if (sender != velocitySlider) {
        return;
    }
    double v = velocitySlider.value;
    [pursuit setVelocity: v];
}

- (void)useUpdaterController: (UpdaterController *)u {
    self.updater = u.updater;
    if (updaterView) {
        updaterView.hidden = YES;
        [updaterView removeFromSuperview];
        [updaterView setNeedsDisplay];
    }
    [u activate: self.view];
    updaterView = u.updaterView;
}

- (IBAction)trailChanged:(id)sender {
    if (sender != trailSlider) {
        return;
    }
    int traillength = round(trailSlider.value);
    [pursuitView setTrail: traillength];
}

- (IBAction)catSwitched: (id)sender {
    if (sender != catSwitch) {
        return;
    }
    pursuitView.showCats = catSwitch.on;
    externalViewController.showCats = catSwitch.on;
    [pursuitView setNeedsDisplay];
}

@end
