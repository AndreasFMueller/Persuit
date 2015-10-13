//
//  ExternalViewController.h
//  Persuit
//
//  Created by Andreas Müller on 11.10.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersuitView.h"

@interface ExternalViewController : UIViewController {
    UIView  *popupView;
    PersuitView *masterView;
    PersuitView *persuitView;
    BOOL hasExternalMonitor;
    UIWindow    *externalWindow;
}

@property (readwrite) UIView *popupView;
@property (readonly) PersuitView *persuitView;
@property (readonly) BOOL hasExternalMonitor;
@property (readwrite) BOOL showCats;

- (void)update: (PersuitView *)master;

- (void)screenConnected;
- (void)screenDisconnected;
- (void)selectScreenMode: (UIScreenMode *)screenmode;
- (void)releaseExternalMonitor;
- (void)externalMonitor;
- (void)setNeedsDisplay;

@end
