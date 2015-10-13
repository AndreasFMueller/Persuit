//
//  TouchUpdater.h
//  Persuit
//
//  Created by Andreas Müller on 13.10.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import "UpdaterBase.h"
#import "PersuitView.h"
#import "UIKit/UIKit.h"
#import "TouchDelegate.h"

@interface TouchUpdater : UpdaterBase<TouchDelegate> {
    PersuitView  *persuitView;
    CGPoint where;
}

@property (readwrite) PersuitView *persuitView;
@property (readwrite) CGPoint where;

- (id)init:(Persuit *)p;
- (CGPoint)update:(double)t;

@end
