//
//  LoginViewController.h
//  HoneyBadger CRM
//
//  Created by Eugene Chuvyrov on 7/27/13.
//  Copyright (c) 2013 Eugene Chuvyrov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UITableViewController
@property(nonatomic, strong) NSString* dnbDUNSNumber;
@property(nonatomic, strong) NSString* dnbCompanyName;
- (IBAction)loginFacebook:(id)sender;
- (IBAction)loginTwitter:(id)sender;
- (IBAction)loginGoogle:(id)sender;

- (IBAction)loginWindows:(id)sender;


@end
