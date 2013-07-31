//
//  LoginViewController.m
//  HoneyBadger CRM
//
//  Created by Eugene Chuvyrov on 7/27/13.
//  Copyright (c) 2013 Eugene Chuvyrov. All rights reserved.
//

#import "LoginViewController.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>
#import "honeyBadgerService.h"
#import "CompanyContactViewController.h"

@interface LoginViewController ()

@property (strong, nonatomic)   honeyBadgerService   *honeyBadgerService;

@end

@implementation LoginViewController

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
    self.honeyBadgerService = [honeyBadgerService defaultService];
	// Do any additional setup after loading the view.
}

-(void)login:(NSString*) provider
{
    MSClient *client = self.honeyBadgerService.client;
    
    if (client.currentUser != nil) {
        if(self.dnbDUNSNumber != nil){
            [self performSegueWithIdentifier:@"ShowCampaignView" sender:nil];
        }
        else{
            [self performSegueWithIdentifier:@"MyCampaigns" sender:nil];
        }
    }
    
    [client loginWithProvider:provider controller:self animated:YES completion:^(MSUser *user, NSError *error){
        
        if(self.dnbDUNSNumber != nil){
            [self performSegueWithIdentifier:@"ShowCampaignView" sender:nil];
        }
        else{
            [self performSegueWithIdentifier:@"MyCampaigns" sender:nil];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginFacebook:(id)sender {
    [self login:@"facebook"];
}

- (IBAction)loginTwitter:(id)sender {
    [self login:@"twitter"];
}

- (IBAction)loginGoogle:(id)sender {
    [self login:@"google"];
}

- (IBAction)loginWindows:(id)sender {
    [self login:@"microsoftaccount"];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowCampaignView"])
    {
        CompanyContactViewController *resultsView = [segue destinationViewController];
        resultsView.dnbDUNSNumber = self.dnbDUNSNumber;
        resultsView.dnbCompanyName = self.dnbCompanyName;
    }
}
@end
