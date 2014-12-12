//
//  AXCManageProspectViewController.h
//  Prospect POC
//
//  Created by Steven Jordan Kozmary on 12/8/14.
//  Copyright (c) 2014 HCL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AXCManageProspectViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedContol;
@property (weak, nonatomic) NSArray *fetchedObjects;

@end
