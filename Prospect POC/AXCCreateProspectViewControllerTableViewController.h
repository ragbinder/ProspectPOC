//
//  AXCCreateProspectViewControllerTableViewController.h
//  Prospect POC
//
//  Created by Steven Jordan Kozmary on 12/7/14.
//  Copyright (c) 2014 HCL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AXCCreateProspectViewControllerTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>
//Holds the data from the plist
@property NSArray *cellArray;

//Holds strong references to the cells in the table view.
@property (strong, nonatomic) NSMutableArray *cells;
- (IBAction)saveButton:(id)sender;

@end
