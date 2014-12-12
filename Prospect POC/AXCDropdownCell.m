//
//  AXCDropdownCell.m
//  Prospect POC
//
//  Created by Steven Jordan Kozmary on 12/7/14.
//  Copyright (c) 2014 HCL. All rights reserved.
//

#import "AXCDropdownCell.h"

@implementation AXCDropdownCell
@synthesize pickerList;
@synthesize pickerButton;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)pickerButtonPressed:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil];
    for (NSString *str in pickerList)
    {
        [actionSheet addButtonWithTitle:str];
    }
    
    [actionSheet showInView:[[[[UIApplication sharedApplication] keyWindow] rootViewController] view]];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
        NSString *newTitle = [pickerList objectAtIndex:buttonIndex];
        [pickerButton setTitle:newTitle forState:UIControlStateNormal];
}
@end
