//
//  CampaignsViewController.m
//  HoneyBadger CRM
//
//  Created by Eugene Chuvyrov on 7/24/13.
//  Copyright (c) 2013 Eugene Chuvyrov. All rights reserved.
//

#import "CampaignsViewController.h"
#import "CompanyCampaignsViewController.h"
#import "honeyBadgerService.h"
#import "DnBCompany.h"

@interface CampaignsViewController ()

@property (strong, nonatomic)   honeyBadgerService   *honeyBadgerService;

@end

@implementation CampaignsViewController

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

- (void)viewDidAppear:(BOOL)animated
{
    [self refresh];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) refresh
{
    [self.honeyBadgerService refreshDataOnSuccess:^
    {
         [self.tableView reloadData];
    }];
}

#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Set the label on the cell and make sure the label color is black (in case this cell
    // has been reused and was previously greyed out
    UILabel *labelCoName = (UILabel *)[cell viewWithTag:1];
    labelCoName.textColor = [UIColor blackColor];
    
    DnBCompany *dnb = [self.honeyBadgerService.companies objectAtIndex:indexPath.row];
    labelCoName.text = [NSString stringWithFormat:@"%@", dnb.CompanyName];

    UILabel *label = (UILabel *)[cell viewWithTag:2];
    label.textColor = [UIColor blueColor];

    label.text = [NSString stringWithFormat:@"%d campaigns, %d points", dnb.campaigns, dnb.pointsUsed];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.honeyBadgerService.companies count];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"iphone" bundle:nil];
    CompanyCampaignsViewController *detailViewController = [storyboard instantiateViewControllerWithIdentifier:@"CompanyCampaigns"];
    detailViewController.dnbDUNSNumber = [[self.honeyBadgerService.companies objectAtIndex:indexPath.row] DUNSNumber];

    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end
