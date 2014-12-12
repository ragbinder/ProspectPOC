//
//  AXCViewController.h
//  Prospect POC
//
//  Created by Steven Jordan Kozmary on 12/6/14.
//  Copyright (c) 2014 HCL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AXCViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;  
@end
