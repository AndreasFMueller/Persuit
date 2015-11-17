//
//  UpdaterBase.h
//  Pursuit
//
//  Created by Andreas Müller on 13.10.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pursuit.h"

@interface UpdaterBase : NSObject {
    Pursuit *pursuit;
    NSString    *displayName;
    double  speed;
}

@property (readwrite) Pursuit *pursuit;
@property (readonly) NSString *displayName;
@property (readwrite) double speed;

- (id)init: (Pursuit *)p;
- (CGPoint)update: (double)t;

@end
