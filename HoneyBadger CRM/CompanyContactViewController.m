//
//  CompanyContactViewController.m
//  HoneyBadger CRM
//
//  Created by Eugene Chuvyrov on 7/24/13.
//  Copyright (c) 2013 Eugene Chuvyrov. All rights reserved.
//

#import "CompanyContactViewController.h"
#import "honeyBadgerService.h"

@interface CompanyContactViewController ()

// Private properties
@property (strong, nonatomic)   honeyBadgerService   *honeyBadgerService;
@property (nonatomic)           BOOL            useRefreshControl;

@end

@implementation CompanyContactViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.honeyBadgerService = [honeyBadgerService defaultService];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (IBAction)onadd:(id)sender {

    if (self.type.text.length  == 0)
    {
        return;
    }
    
    NSDictionary *item = @{ @"DUNSNumber" : self.dnbDUNSNumber, @"CompanyName" : self.dnbCompanyName, @"Type" : self.type.text, @"Date" : self.date.text, @"Notes" : self.notes.text, @"Cost" : @"10", @"User":self.honeyBadgerService.client.currentUser.userId};
    
    __weak typeof(self) weakSelf = self;
    [self.honeyBadgerService addItem:item completion:^(NSUInteger index)
    {
        [weakSelf performSegueWithIdentifier:@"ShowCampaigns" sender:nil];
    }];
}


@end
