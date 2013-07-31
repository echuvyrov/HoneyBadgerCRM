//
//  HoneyBadgerViewController.h
//  HoneyBadger CRM
//
//  Created by Eugene Chuvyrov on 7/6/13.
//  Copyright (c) 2013 Eugene Chuvyrov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HoneyBadgerViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIButton *lookAround;
- (IBAction)lookAroundPressed:(id)sender;

@end
