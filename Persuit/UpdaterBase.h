//
//  UpdaterBase.h
//  Persuit
//
//  Created by Andreas Müller on 13.10.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Persuit.h"

@interface UpdaterBase : NSObject {
    Persuit *persuit;
    NSString    *displayName;
    double  speed;
}

@property (readwrite) Persuit *persuit;
@property (readonly) NSString *displayName;
@property (readwrite) double speed;

- (id)init: (Persuit *)p;
- (CGPoint)update: (double)t;

@end
