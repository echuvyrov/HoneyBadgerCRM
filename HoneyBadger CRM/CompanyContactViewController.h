//
//  CompanyContactViewController.h
//  HoneyBadger CRM
//
//  Created by Eugene Chuvyrov on 7/24/13.
//  Copyright (c) 2013 Eugene Chuvyrov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompanyContactViewController : UITableViewController
@property(nonatomic, strong) NSString* dnbDUNSNumber;
@property(nonatomic, strong) NSString* dnbCompanyName;
@property (weak, nonatomic) IBOutlet UITextField *type;
@property (weak, nonatomic) IBOutlet UITextField *date;
@property (weak, nonatomic) IBOutlet UITextView *notes;
- (IBAction)onadd:(id)sender;

@end
