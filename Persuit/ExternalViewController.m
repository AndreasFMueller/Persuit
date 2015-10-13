//
//  ExternalViewController.m
//  Persuit
//
//  Created by Andreas Müller on 11.10.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import "ExternalViewController.h"
#import "ScreenTableViewController.h"

@implementation ExternalViewController

@synthesize popupView, hasExternalMonitor, persuitView;

-(void)initCommon {
    self.view = nil;
    masterView = nil;
    popupView = nil;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenConnected) name:UIScreenDidConnectNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenDisconnected) name:UIScreenDidDisconnectNotification object:nil];
}

-(id)init {
    self = [super init];
    if (self) {
        NSLog(@"ExternalViewController initialized");
        [self initCommon];
    }
    return self;
}

- (void)curves: (PersuitView*)other {
    if (!hasExternalMonitor) {
        return;
    }
    self.persuitView.target = other.target;
    for (int i = 0; i < [other numberOfCurves]; i++) {
        [self.persuitView addPersuer: [other curveAt: i]];
    }
}

- (void)update: (PersuitView *)master {
    if (!hasExternalMonitor) {
        NSLog(@"no external monitor present");
        return;
    }
    if (master != masterView) {
        [self curves: master];
        persuitView.showCats = master.showCats;
        [persuitView setCenterCoordinates: master.coordinateCenter width: master.coordinateWidth];
        masterView = master;
    }
    [self.persuitView setNeedsDisplay];
}

- (UIScreenMode *)getMode: (CGSize)size fromScreen: (UIScreen *)screen {
    NSArray *modes = [screen availableModes];
    for (int j = 0; j < [modes count]; j++) {
        UIScreenMode    *mode = [modes objectAtIndex: j];
        NSLog(@"mode %@\n", mode.description);
        if ((mode.size.width == size.width) && (mode.size.height == size.height)) {
            return mode;
        }
    }
    NSLog(@"mode of size %.0f x %.0f not found", size.width, size.height);
    return nil;
}

- (void)screenConnected {
    NSLog(@"screen did connect");
    ScreenTableViewController       *screencontroller = [[ScreenTableViewController alloc] initWithStyle: UITableViewStylePlain];
    screencontroller.controller = self;
    UIPopoverController     *popo = [[UIPopoverController alloc] initWithContentViewController: screencontroller];
    CGSize  s;
    s.width = 200;
    s.height = 200;
    popo.popoverContentSize = s;
    
    [popo presentPopoverFromRect: popupView.bounds inView: popupView
        permittedArrowDirections: UIPopoverArrowDirectionAny animated:YES];
    screencontroller.popovercontroller = popo;
}

- (void)screenDisconnected {
    NSLog(@"screen did disconnect");
    [self releaseExternalMonitor];
}

- (void)selectScreenMode: (UIScreenMode *)screenmode {
    NSLog(@"screen mode %@ selected", [screenmode description]);
    [self releaseExternalMonitor];
    (void)[self initializeExternalMonitor: screenmode];
    hasExternalMonitor = YES;
}

- (void)releaseExternalMonitor {
    self.view = nil;
    externalWindow = nil;
    hasExternalMonitor = NO;
}

- (UIScreen *)externalScreen: (UIScreenMode *)mode {
    NSArray *screens = [UIScreen screens];
    for (int i = 0; i < [screens count]; i++) {
        UIScreen        *screen = (UIScreen *)[screens objectAtIndex:i];
        if ([UIScreen mainScreen] != screen) {
            NSLog(@"using this screen as external monitor");
            
            // if we have a mode, we use this one
            if (mode) {
                screen.currentMode = mode;
                return screen;
            }
            
            // find the 1024x768 mode
            CGSize  size = CGSizeMake(1024, 768);
            UIScreenMode    *mode = [self getMode: size fromScreen: screen];
            if (nil != mode) {
                if (screen.currentMode != mode) {
                    screen.currentMode = mode;
                }
                return screen;
            }
            
            // finde the 800x600 mode (normally does not exist, but may exist in the future
            size = CGSizeMake(800, 600);
            mode = [self getMode: size fromScreen: screen];
            if (nil != mode) {
                if (screen.currentMode != mode) {
                    screen.currentMode = mode;
                }
                return screen;
            }
            
            // we try the 800 x 600 mode instead
            size = CGSizeMake(640, 480);
            mode = [self getMode: size fromScreen: screen];
            if (nil != mode) {
                if (screen.currentMode != mode) {
                    screen.currentMode = mode;
                }
                return screen;
            }
        } else {
            NSLog(@"this is the main monitor");
        }
    }
    NSLog(@"no external screen found");
    return nil;
}

- (NSString *)initializeExternalMonitor: (UIScreenMode *)screenmode {
    NSString        *result = @"external monitor initialization:\n";
    UIScreen        *screen = [self externalScreen: screenmode];
    if (nil == screen) {
        return nil;
    }
    [result stringByAppendingFormat: @"found screen %@\n", screen.description];
    // create the main window on this sscreen
    externalWindow = [[UIWindow alloc] init];
    externalWindow.screen = screen;
    externalWindow.frame = screen.applicationFrame;
    externalWindow.hidden = NO;
    externalWindow.rootViewController = self;

    persuitView = [[PersuitView alloc] init];
    persuitView.frame = externalWindow.frame;
    persuitView.backgroundColor = [UIColor whiteColor];
    [externalWindow addSubview: persuitView];
    
    hasExternalMonitor = YES;
    return result;
}

- (void)externalMonitor {
    NSString        *externaldevicelog = [self initializeExternalMonitor: nil];
    if (nil == persuitView) {
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle: @"No external monitor found"
                                   message: [NSString stringWithFormat: @"This application expects an external monitor, but no monitor was found. Please connect the monitor, check your monitor cable and relaunch this application. (initialization messages: %@)", externaldevicelog]
                                  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    } else {
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle: @"External monitor found"
                                   message: [NSString stringWithFormat: @"Initialization messages: %@", externaldevicelog]
                                  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)setNeedsDisplay {
    if (persuitView) {
        [persuitView setNeedsDisplay];
    }
}

- (BOOL)showCats {
    if (persuitView) {
        return persuitView.showCats;
    }
    return NO;
}

- (void)setShowCats:(BOOL)s {
    if (persuitView) {
        persuitView.showCats = s;
        [persuitView setNeedsDisplay];
    }
}

@end
