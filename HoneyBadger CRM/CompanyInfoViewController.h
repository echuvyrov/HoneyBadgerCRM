//
//  CompanyInfoViewController.h
//  HoneyBadger CRM
//
//  Created by Eugene Chuvyrov on 7/24/13.
//  Copyright (c) 2013 Eugene Chuvyrov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompanyInfoViewController : UITableViewController
@property(nonatomic, strong) NSString* dnbDUNSNumber;

@property (weak, nonatomic) IBOutlet UILabel *lblName;

@property (weak, nonatomic) IBOutlet UILabel *lblYearsInBus;

@property (weak, nonatomic) IBOutlet UILabel *lblCEO;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblPhoneNumber;
@property (weak, nonatomic) IBOutlet UIButton *btnHoneyBadger;
- (IBAction)honeyBadgerThem:(id)sender;

@end
