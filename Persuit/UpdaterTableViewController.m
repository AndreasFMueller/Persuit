//
//  UpdaterTableViewController.m
//  Persuit
//
//  Created by Andreas Müller on 13.10.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import "UpdaterTableViewController.h"
#import "LissajousUpdater.h"
#import "TouchUpdater.h"
#import "RandomUpdater.h"
#import "PolygonUpdater.h"
#import "LissajousUpdaterController.h"
#import "TouchUpdaterController.h"
#import "RandomUpdaterController.h"
#import "PolygonUpdaterController.h"

@implementation UpdaterTableViewController

@synthesize updaterSelectionDelegate, parentView;

- (id)init: (Persuit *)p {
    self = [super init];
    if (self) {
        updaters = [[NSMutableArray alloc] init];
        
        TouchUpdater    *touchUpdater = [[TouchUpdater alloc] init: p];
        TouchUpdaterController       *touchUpdaterController = [[TouchUpdaterController alloc] init: touchUpdater];
        [self addUpdaterController: touchUpdaterController];
        
        LissajousUpdater    *lissajousUpdater = [[LissajousUpdater alloc] init: p];
        LissajousUpdaterController  *lissajousUpdaterController = [[LissajousUpdaterController alloc] init: lissajousUpdater];
        [self addUpdaterController: lissajousUpdaterController];
        
        RandomUpdater   *randomUpdater = [[RandomUpdater alloc] init: p];
        RandomUpdaterController   *randomUpdaterController = [[RandomUpdaterController alloc] init: randomUpdater];
        [self addUpdaterController: randomUpdaterController];
        
        PolygonUpdater  *polygonUpdater = [[PolygonUpdater alloc] init: p];
        PolygonUpdaterController   *polygonUpdaterController = [[PolygonUpdaterController alloc] init: polygonUpdater];
        [self addUpdaterController: polygonUpdaterController];
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
                  cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cell for row %d", indexPath.row);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"updaters"];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] init];
    }
    cell.textLabel.text = [self updaterControllerAt: indexPath.row].displayName;

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"numberOfRowsInSection: %d", [self numberOfUpdaterControllers]);
    return [self numberOfUpdaterControllers];
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSLog(@"selecting element %d", indexPath.row);
    [self selectUpdaterController: indexPath.row];
}

- (NSInteger)numberOfUpdaterControllers {
    return [updaters count];
}

- (UpdaterController *)updaterControllerAt: (int)i {
    return (UpdaterController *)[updaters objectAtIndex: i];
}

- (void)selectUpdaterController: (int)i {
    NSLog(@"updater %d requested", i);
    if ((i >= 0) && (i < [self numberOfUpdaterControllers])) {
        if (updaterSelectionDelegate) {
            UpdaterController *updater = [self updaterControllerAt: i];
            [updaterSelectionDelegate useUpdaterController: updater];
        } else {
            NSLog(@"no updaterSelectionDelegate defined");
        }
    } else {
        NSLog(@"updater index %d out of ragen 0-%d", i, [self numberOfUpdaterControllers]-1);
    }
}

- (void)addUpdaterController:(UpdaterController *)updater {
    NSLog(@"adding updater %@", [updater description]);
    [updaters addObject: updater];
}

-(void)position: (CGPoint)where {
    NSLog(@"got update");
    TouchUpdater    *touchUpdater = (TouchUpdater*)[self updaterControllerAt: 0].updater;
    [touchUpdater position: where];
}

@end
