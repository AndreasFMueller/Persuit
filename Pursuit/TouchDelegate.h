//
//  TouchDelegate.h
//  Pursuit
//
//  Created by Andreas Müller on 13.10.15.
//  Copyright © 2015 Andreas Müller. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TouchDelegate <NSObject>

-(void)position: (CGPoint)where;

@end
