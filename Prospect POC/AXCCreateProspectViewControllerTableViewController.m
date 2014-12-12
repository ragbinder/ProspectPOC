//
//  AXCCreateProspectViewControllerTableViewController.m
//  Prospect POC
//
//  Created by Steven Jordan Kozmary on 12/7/14.
//  Copyright (c) 2014 HCL. All rights reserved.
//

#import "AXCCreateProspectViewControllerTableViewController.h"
#import "AXCCreateProspectTableViewCell.h"
#import "AXCDropdownCell.h"
#import "AXCAppDelegate.h"
#import <CoreData/CoreData.h>

@interface AXCCreateProspectViewControllerTableViewController ()
{
    AXCAppDelegate *_delegate;
}
@end

@implementation AXCCreateProspectViewControllerTableViewController
@synthesize cellArray;
@synthesize cells;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _delegate = [[UIApplication sharedApplication] delegate];
    cells = [[NSMutableArray alloc] initWithCapacity:12];
    
    // Build the array from the plist
    NSString *path = [[NSBundle mainBundle] pathForResource: @"CreateProspectCells" ofType:@"plist"];
    cellArray = [[NSMutableArray alloc] initWithContentsOfFile:path];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [cellArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    if([[cellArray objectAtIndex:[indexPath row]] valueForKey:@"pickerList"]){
        cell = [self tableView:tableView configureDropdownCellForIndexPath:indexPath];
    }
    else {
        cell = [self tableView:tableView configureTextFieldCellForIndexPath:indexPath];
    }
    
    return cell;
}

- (AXCDropdownCell *)tableView:(UITableView*) tableView configureDropdownCellForIndexPath:(NSIndexPath *)indexPath
{
    if([cells count] < [indexPath row] && [cells objectAtIndex:[indexPath row]])
    {
        return [cells objectAtIndex:[indexPath row]];
    }
    NSString *cellReuseIdentifier = @"createProspectPickerCell";
    AXCDropdownCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
    
    NSString *cellDescriptionLabel = [[cellArray objectAtIndex:[indexPath row]] valueForKey:@"descriptionLabel"];
    BOOL isRequired = [[[cellArray objectAtIndex:[indexPath row]] valueForKey:@"isRequired"] boolValue];
    if(isRequired)
    {
        cellDescriptionLabel = [cellDescriptionLabel stringByAppendingString:@" *"];
    }
    NSArray *cellPickerArray = [[cellArray objectAtIndex:[indexPath row]] valueForKey:@"pickerList"];
    
    [[cell descriptionLabel] setText:cellDescriptionLabel];
    [cell setPickerList:cellPickerArray];
    
    return cell;
}

- (AXCCreateProspectTableViewCell *)tableView:(UITableView*) tableView configureTextFieldCellForIndexPath:(NSIndexPath *)indexPath
{
    if([cells count] < [indexPath row] && [cells objectAtIndex:[indexPath row]])
    {
        return [cells objectAtIndex:[indexPath row]];
    }
    NSString *cellReuseIdentifier = @"createProspectTextFieldCell";
    AXCCreateProspectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
    
    NSString *cellDescriptionLabel = [[cellArray objectAtIndex:[indexPath row]] valueForKey:@"descriptionLabel"];
    BOOL isRequired = [[[cellArray objectAtIndex:[indexPath row]] valueForKey:@"isRequired"] boolValue];
    if(isRequired)
    {
        cellDescriptionLabel = [cellDescriptionLabel stringByAppendingString:@" *"];
    }
    
    [[cell descriptionLabel] setText:cellDescriptionLabel];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cells setObject:cell atIndexedSubscript:[indexPath row]];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveButton:(id)sender {
    NSArray *objectKeys = @[@"firstName",
                            @"middleName",
                            @"lastName",
                            @"currency",
                            @"phone",
                            @"email",
                            @"country",
                            @"state",
                            @"city",
                            @"address",
                            @"zipCode"];
    
    NSMutableDictionary *objectDictionary = [[NSMutableDictionary alloc] init];
    for (NSInteger i = 0; i < [cellArray count]; i++)
    {
//        NSLog(@"Cell Array: %@",[[cellArray objectAtIndex:i] valueForKey:@"descriptionLabel"]);
        if ([[cells objectAtIndex:i] isKindOfClass:[AXCDropdownCell class]]) {
            [objectDictionary setValue:[[[cells objectAtIndex:i] pickerButton] titleForState:UIControlStateNormal] forKey:[objectKeys objectAtIndex:i]];
            NSLog(@"Value: %@",[[[cells objectAtIndex:i] pickerButton] titleForState:UIControlStateNormal]);
        }
        else {
            [objectDictionary setValue:[[[cells objectAtIndex:i] textField] text] forKey:[objectKeys objectAtIndex:i]];
            NSLog(@"Value:%@\n %@",[objectKeys objectAtIndex:i],[[[cells objectAtIndex:i] textField] text]);
        }
    }
    
    if ([self validateData]) {
        NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:@"Prospect" inManagedObjectContext:[_delegate managedObjectContext]];
        [object setValue:@"Prospect" forKey:@"type"];

        [object setValuesForKeysWithDictionary:objectDictionary];
        
        [_delegate saveContext];
        
        NSLog(@"%@",object);
    }
}

- (BOOL)validateData
{
#pragma warning implement validation
    //Make sure all required fields are entered
    
    //Validate that all fields are of a valid type
    
    //Make sure no duplicate value of this exists
    return YES;
}
@end
