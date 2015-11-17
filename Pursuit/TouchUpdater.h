//
//  TouchUpdater.h
//  Pursuit
//
//  Created by Andreas Müller on 13.10.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import "UpdaterBase.h"
#import "PursuitView.h"
#import "UIKit/UIKit.h"
#import "TouchDelegate.h"

@interface TouchUpdater : UpdaterBase<TouchDelegate> {
    PursuitView  *pursuitView;
    CGPoint where;
}

@property (readwrite) PursuitView *pursuitView;
@property (readwrite) CGPoint where;

- (id)init:(Pursuit *)p;
- (CGPoint)update:(double)t;

@end
