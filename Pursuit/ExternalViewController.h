//
//  ExternalViewController.h
//  Pursuit
//
//  Created by Andreas Müller on 11.10.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PursuitView.h"

@interface ExternalViewController : UIViewController {
    UIView  *popupView;
    PursuitView *masterView;
    PursuitView *pursuitView;
    BOOL hasExternalMonitor;
    UIWindow    *externalWindow;
}

@property (readwrite) UIView *popupView;
@property (readonly) PursuitView *pursuitView;
@property (readonly) BOOL hasExternalMonitor;
@property (readwrite) BOOL showCats;

- (void)update: (PursuitView *)master;

- (void)screenConnected;
- (void)screenDisconnected;
- (void)selectScreenMode: (UIScreenMode *)screenmode;
- (void)releaseExternalMonitor;
- (void)externalMonitor;
- (void)setNeedsDisplay;

@end
