//
//  LookAroundViewController.m
//  HoneyBadger CRM
//
//  Created by Eugene Chuvyrov on 7/7/13.
//  Copyright (c) 2013 Eugene Chuvyrov. All rights reserved.
//

#import "LookAroundViewController.h"
#import "TargetsViewController.h"

@interface LookAroundViewController ()

@property (strong, nonatomic) NSDictionary *stateZips;
@property (strong, nonatomic) NSArray *states;

@end

@implementation LookAroundViewController
@synthesize statePicker, pickerView, txtCity;
NSString* selectedState;
NSString* selectedIndustry;
NSString* selectedCity;

NSMutableArray *myLoadedArray;

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
    //set background image
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blue-gradient.jpg"]];
    [self loadStates];
    [self loadIndustries];

}

-(void) loadStates {
    // Do any additional setup after loading the view.
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *plistURL = [bundle URLForResource:@"statedictionary"
                               withExtension:@"plist"];
    
    //load states from the list
    NSDictionary *dictionary = [NSDictionary
                                dictionaryWithContentsOfURL:plistURL];
    self.stateZips = dictionary;
    
    NSArray *components = [self.stateZips allKeys];
    NSArray *sorted = [components sortedArrayUsingSelector:
                       @selector(compare:)];
    self.states = sorted;
    [statePicker selectRow:0 inComponent:0 animated:NO];
}

- (void) loadIndustries {
    
    myLoadedArray = [[NSMutableArray alloc] init];
    NSString* industry1 = @"Agriculture";
    [myLoadedArray addObject:industry1];
    NSString* industry2 = @"Mining";
    [myLoadedArray addObject:industry2];
    NSString* industry3 = @"Construction";
    [myLoadedArray addObject:industry3];
    NSString* industry4 = @"Manufacturing";
    [myLoadedArray addObject:industry4];
    NSString* industry5 = @"Transportation";
    [myLoadedArray addObject:industry5];
    NSString* industry6 = @"Wholesale Trade";
    [myLoadedArray addObject:industry6];
    NSString* industry7 = @"Retail Trade";
    [myLoadedArray addObject:industry7];
    NSString* industry8 = @"Finance, Insurance, or Real Estate";
    [myLoadedArray addObject:industry8];
    NSString* industry9 = @"Services";
    [myLoadedArray addObject:industry9];
    NSString* industry10 = @"Public Administration";
    [myLoadedArray addObject:industry10];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)picker numberOfRowsInComponent:(NSInteger)component {
    if(picker == statePicker){
        if (self.states != nil) {
            return [self.states count];
        }        
    }
    else {
        if (myLoadedArray!=nil) {
            return [myLoadedArray count];
        }
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)picker titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if(picker == statePicker){
        return [self.states objectAtIndex:row];
    }
    else {
        return [myLoadedArray objectAtIndex:row];
    }
}

- (void)pickerView:(UIPickerView *)picker
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component
{
    if(picker == statePicker){
        selectedState = [self.states objectAtIndex:row];
    }
    else{
        selectedIndustry = [myLoadedArray objectAtIndex:row];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowSearchResults"])
    {
        TargetsViewController *resultsView = [segue destinationViewController];
        resultsView.dnbState = selectedState;
        resultsView.dnbIndustry = selectedIndustry;
        resultsView.dnbCity = self.txtCity.text;
    }
}

- (IBAction)hideKeyboard:(id)sender {
    if([txtCity isFirstResponder])
    {
        [txtCity resignFirstResponder];
    }
}

@end
