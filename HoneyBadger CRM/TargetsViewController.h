//
//  TargetsViewController.h
//  HoneyBadger CRM
//
//  Created by Eugene Chuvyrov on 7/6/13.
//  Copyright (c) 2013 Eugene Chuvyrov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface TargetsViewController : UIViewController<CLLocationManagerDelegate>
{
}

@property (nonatomic, strong) CLGeocoder *geocoder;
@property (nonatomic, strong) CLGeocoder *geocoder2;
@property (nonatomic, strong) CLGeocoder *geocoder3;
@property (nonatomic, strong) CLGeocoder *geocoder4;
@property (nonatomic, strong) CLGeocoder *geocoder5;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property(nonatomic, strong) NSString* dnbState;
@property(nonatomic, strong) NSString* dnbCity;
@property(nonatomic, strong) NSString* dnbIndustry;

@end
