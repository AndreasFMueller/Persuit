//
//  ScreenTableViewController.h
//  PDFPresenter
//
//  Created by Andreas Müller on 29.01.11.
//  Copyright 2011 Hochschule Rapperswil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExternalViewController.h"

@interface ScreenTableViewController : UITableViewController {
	NSArray	*screenmodes;
	ExternalViewController	*controller;
	UIPopoverController	*popovercontroller;
	int	activeMode;
}

@property(readwrite,retain) NSArray *screenmodes;
@property(readwrite,retain) ExternalViewController *controller;
@property(readwrite,retain) UIPopoverController *popovercontroller;

@end
