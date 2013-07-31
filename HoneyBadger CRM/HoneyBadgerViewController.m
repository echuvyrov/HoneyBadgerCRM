//
//  HoneyBadgerViewController.m
//  HoneyBadger CRM
//
//  Created by Eugene Chuvyrov on 7/6/13.
//  Copyright (c) 2013 Eugene Chuvyrov. All rights reserved.
//

#import "HoneyBadgerViewController.h"

@interface HoneyBadgerViewController ()

@end

@implementation HoneyBadgerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //set background image and separator colors
    self.tableView.separatorColor = [UIColor clearColor];
    //self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blue-gradient.jpg"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)lookAroundPressed:(id)sender {
    
    [self.tabBarController setSelectedIndex: 1];
}
@end
