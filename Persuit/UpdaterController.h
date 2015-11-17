//
//  UpdaterController.h
//  Pursuit
//
//  Created by Andreas Müller on 13.10.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UpdaterBase.h"
#import "UpdaterView.h"

@interface UpdaterController : UIViewController {
    UpdaterBase *updater;
    UpdaterView *updaterView;
}

@property(readonly) UpdaterBase *updater;
@property(readonly) UpdaterView *updaterView;
@property(readonly) NSString *displayName;

- (id)init: (UpdaterBase *)u;
- (void)activate: (UIView *)parentView;

@end
