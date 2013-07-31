//
//  CompanyInfoViewController.m
//  HoneyBadger CRM
//
//  Created by Eugene Chuvyrov on 7/24/13.
//  Copyright (c) 2013 Eugene Chuvyrov. All rights reserved.
//

#import "CompanyInfoViewController.h"
#import "LoginViewController.h"

@interface CompanyInfoViewController ()

@end

@implementation CompanyInfoViewController
@synthesize dnbDUNSNumber;
NSString* dnbCompanyName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getCompanyInfo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getCompanyInfo
{
    NSString* query =  [@"http://dnb-crm.azure-mobile.net/api/companydetails?DUNSNumber=" stringByAppendingString:dnbDUNSNumber];
    query = [query stringByAddingPercentEscapesUsingEncoding:
             NSASCIIStringEncoding];
    
    NSData *jsonData = [[NSString stringWithContentsOfURL:[NSURL URLWithString:query] encoding:NSUTF8StringEncoding error:nil] dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *results = jsonData ? [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&error] : nil;
    if (error) NSLog(@"[%@ %@] JSON error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), error.localizedDescription);
    
    NSArray* coResults = [results valueForKeyPath:@"d.results"];
    NSMutableDictionary* co = [coResults objectAtIndex:0];
    self.lblName.text = [co valueForKey:@"Company"];
    dnbCompanyName = self.lblName.text;
    
    self.lblAddress.text = [co valueForKey:@"Address"];
    self.lblCEO.text = [co valueForKey:@"CEOName"];
    if([[co valueForKey:@"Phone"] isKindOfClass:[NSNull class]]){
        
    }
    else{
         self.lblPhoneNumber.text = [co valueForKey:@"Phone"];   
    }
    self.lblYearsInBus.text = [co valueForKey:@"CompanyStartYear"];
}

- (IBAction)honeyBadgerThem:(id)sender {

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowCampaignContact"])
    {
        LoginViewController *resultsView = [segue destinationViewController];
        resultsView.dnbDUNSNumber = dnbDUNSNumber;
        resultsView.dnbCompanyName = dnbCompanyName;
    }
}

@end
