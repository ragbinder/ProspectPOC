//
//  AXCDropdownCell.h
//  Prospect POC
//
//  Created by Steven Jordan Kozmary on 12/7/14.
//  Copyright (c) 2014 HCL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AXCDropdownCell : UITableViewCell <UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *pickerButton;
@property NSArray *pickerList;
@property id<UIActionSheetDelegate> delegate;

- (IBAction)pickerButtonPressed:(id)sender;

@end
