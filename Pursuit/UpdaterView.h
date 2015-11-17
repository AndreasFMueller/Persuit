//
//  UpdaterView.h
//  Pursuit
//
//  Created by Andreas Müller on 13.10.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UpdaterBase.h"

@interface UpdaterView : UIView {
    UpdaterBase *updater;
}

@property(readonly) UpdaterBase *updater;

- (id)initWithFrame:(CGRect)frame updater: (UpdaterBase *)u;

@end
