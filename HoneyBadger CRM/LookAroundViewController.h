//
//  LookAroundViewController.h
//  HoneyBadger CRM
//
//  Created by Eugene Chuvyrov on 7/7/13.
//  Copyright (c) 2013 Eugene Chuvyrov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LookAroundViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *statePicker;
@property (weak, nonatomic) IBOutlet UITextField *txtCity;
- (IBAction)hideKeyboard:(id)sender;

@end
