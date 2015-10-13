//
//  MainController.m
//  Persuit
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

@synthesize running, persuit, updater;

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
    persuitView.target = c;
    NSLog(@"new curve: %@", [c description]);
    [persuitView setCenterCoordinates: CGPointMake(0, 0) width: 4];
    persuitView.showCats = YES;
    
    // prepare persuit state
    persuit = [[Persuit alloc] init];
    persuit.currentTime = 0;
    [persuit addPersuer: [[PersuitState alloc] initX:  1 Y:  1]];
    [persuit addPersuer: [[PersuitState alloc] initX: -1 Y:  1]];
    [persuit addPersuer: [[PersuitState alloc] initX:  1 Y: -1]];
    [persuit addPersuer: [[PersuitState alloc] initX: -1 Y: -1]];
    
    [persuit stateAt: 0].strength =  0.3;
    [persuit stateAt: 1].strength =  0.3;
    [persuit stateAt: 2].strength =  0.3;
    [persuit stateAt: 3].strength =  0.3;
    
    // add four curves
    for (int i = 0; i < 4; i++) {
        Curve *catcurve = [[Curve alloc] init];
        catcurve.maxLength = 20;
        CGPoint p = [persuit stateAt: i].where;
        NSLog(@"add point %@", NSStringFromCGPoint(p));
        [catcurve addPoint: p];
        [persuitView addPersuer: catcurve];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"MainController view did load");
    // Do any additional setup after loading the view, typically from a nib.
    // set the background color
    NSLog(@"persuitView: %@", [persuitView description]);
    running = NO;
    NSTimer *timer = [NSTimer timerWithTimeInterval: 0.05 target: self selector: @selector(update)
                                           userInfo: nil repeats: YES];
    [[NSRunLoop currentRunLoop] addTimer: timer forMode: NSDefaultRunLoopMode];
    starttime = now();
    
    // create a curve add it to the view
    [self createCurve];
    [persuitView setNeedsDisplay];
    
#if 0
    // create the updater
    LissajousUpdater    *lu = [[LissajousUpdater alloc] init: persuit];
    lu.a = 7;
    lu.b = 5;
    self.updater = lu;
#endif

#if 0
    RandomUpdater   *ru = [[RandomUpdater alloc] init: persuit];
    self.updater = ru;
#endif
    
#if 0
    TouchUpdater    *tu = [[TouchUpdater alloc] init: persuit];
    persuitView.touchDelegate = tu;
    self.updater = tu;
#endif
    
#if 0
    PolygonUpdater   *pu = [[PolygonUpdater alloc] init: persuit];
    self.updater = pu;
#endif
    
    updaterView = nil;
    
    // add the external view controller
    externalViewController = [[ExternalViewController alloc] init];
    externalViewController.popupView = persuitView;
    [externalViewController externalMonitor];
    
    // initialize the updater table view controller
    updaterTableViewController = [[UpdaterTableViewController alloc] init: persuit];
    updaterTableViewController.tableView = updaterTableView;
    updaterTableViewController.updaterSelectionDelegate = self;
    updaterTableViewController.parentView = self.view;
    persuitView.touchDelegate = updaterTableViewController;
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
        persuit.currentTime = 0;
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
    [persuit update:t point: [updater update: t]];
    lasttime = t;

    [persuitView update: persuit];
    [externalViewController update: persuitView];
}

- (IBAction)velocityChanged: (id)sender {
    if (sender != velocitySlider) {
        return;
    }
    double v = velocitySlider.value;
    [persuit setVelocity: v];
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
    [persuitView setTrail: traillength];
}

- (IBAction)catSwitched: (id)sender {
    if (sender != catSwitch) {
        return;
    }
    persuitView.showCats = catSwitch.on;
    externalViewController.showCats = catSwitch.on;
    [persuitView setNeedsDisplay];
}

@end
