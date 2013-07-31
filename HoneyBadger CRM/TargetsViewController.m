//
//  TargetsViewController.m
//  HoneyBadger CRM
//
//  Created by Eugene Chuvyrov on 7/6/13.
//  Copyright (c) 2013 Eugene Chuvyrov. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "TargetsViewController.h"
#import "DnBCompany.h"
#import "DnBCompanyLocation.h"
#import "CompanyInfoViewController.h"

@interface TargetsViewController ()

@end

@implementation TargetsViewController

CLLocationManager *locationManager;
NSArray* events;
NSString* selectedDUNS;

@synthesize geocoder = _geocoder;
@synthesize geocoder2 = _geocoder2;
@synthesize geocoder3 = _geocoder3;
@synthesize dnbCity,dnbIndustry,dnbState;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [self mapEvents];
}

#pragma mark - CLLocationManagerDelegate

- (NSDictionary *)getTargets
{
    NSString* query =  [@"http://dnb-crm.azure-mobile.net/api/firmographics?City=" stringByAppendingString:dnbCity];
    query =  [query stringByAppendingString:@"&State="];
    query =  [query stringByAppendingString:dnbState];
    query =  [query stringByAppendingString:@"&IndustryCode="];
    query =  [query stringByAppendingString:[self getIndustryCode]];
    query = [query stringByAddingPercentEscapesUsingEncoding:
             NSASCIIStringEncoding];
    
    NSData *jsonData = [[NSString stringWithContentsOfURL:[NSURL URLWithString:query] encoding:NSUTF8StringEncoding error:nil] dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *results = jsonData ? [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&error] : nil;
    if (error) NSLog(@"[%@ %@] JSON error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), error.localizedDescription);

    return results;
}


-(NSString*) getIndustryCode
{
    NSString* retVal = @"";

    if([dnbIndustry isEqualToString:@"Agriculture"]) {
        retVal = @"01";
    }
    if([dnbIndustry isEqualToString:@"Mining"]) {
        retVal = @"10";
    }
    if([dnbIndustry isEqualToString:@"Construction"]) {
        retVal = @"15";
    }
    if([dnbIndustry isEqualToString:@"Manufacturing"]) {
        retVal = @"20";
    }
    if([dnbIndustry isEqualToString:@"Transportation"]) {
        retVal = @"40";
    }
    if([dnbIndustry isEqualToString:@"Wholesale Trade"]) {
        retVal = @"50";
    }
    if([dnbIndustry isEqualToString:@"Retail Trade"]) {
        retVal = @"53";
    }
    if([dnbIndustry isEqualToString:@"Finance, Insurance, or Real Estate"]) {
        retVal = @"60";
    }
    if([dnbIndustry isEqualToString:@"Services"]) {
        retVal = @"70";
    }
    if([dnbIndustry isEqualToString:@"Public Administration"]) {
        retVal = @"92";
    }
    
    return retVal;
}

-(void)mapEvents
{
    NSDictionary* targets = [self getTargets];
    
    for (NSMutableDictionary *target in targets) {

        CLLocationCoordinate2D coordinate;
        coordinate.latitude = [[target valueForKey:@"Latitude"] doubleValue];
        coordinate.longitude = [[target valueForKey:@"Longitude"] doubleValue];
        
        MKCoordinateRegion region;
        region.center = coordinate;
        MKCoordinateSpan span;
        span.latitudeDelta = 0.01;
        span.longitudeDelta = 0.01;
        region.span=span;
        [_mapView setRegion:region animated:TRUE];

        /*
        CLLocationCoordinate2D zoomLocation;
        zoomLocation.latitude = [[target valueForKey:@"Latitude"] doubleValue];
        zoomLocation.longitude= [[target valueForKey:@"Longitude"] doubleValue];
        
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 2500, 2500);
        MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
        [_mapView setRegion:adjustedRegion animated:YES];
        */
        
        DnbCompanyLocation *annotation = [[DnbCompanyLocation alloc] initWithName:[target valueForKey:@"Company"] address:[target valueForKey:@"Address"] duns:[target valueForKey:@"DUNSNumber"]  coordinate:coordinate] ;
        [_mapView addAnnotation:annotation];
        
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    static NSString *identifier = @"EventLocation";
    if ([annotation isKindOfClass:[DnbCompanyLocation class]]) {
        
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        } else {
            annotationView.annotation = annotation;
        }
        
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        annotationView.image=[UIImage imageNamed:@"range.png"];//here we use a nice image instead of the default pins
        
        annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        return annotationView;
    }
    
    return nil;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    DnbCompanyLocation *location = (DnbCompanyLocation*)view.annotation;
    selectedDUNS = location.duns;
    
    [self performSegueWithIdentifier:@"ShowCompanyInfo" sender:self];
    
    /*
    NSDictionary *launchOptions = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving};
    [location.mapItem openInMapsWithLaunchOptions:launchOptions];
     */
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowCompanyInfo"])
    {
        CompanyInfoViewController *resultsView = [segue destinationViewController];
        resultsView.dnbDUNSNumber = selectedDUNS;
    }
}

@end
