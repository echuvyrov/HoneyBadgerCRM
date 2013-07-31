//
//  EventLocation.m
//  Geocoding
//
//  Created by Eugene Chuvyrov on 10/1/12.
//  Copyright (c) 2012 Code Foundry. All rights reserved.
//

#import "DnBCompanyLocation.h"
#import <AddressBook/AddressBook.h>

@implementation DnbCompanyLocation
@synthesize name = _name;
@synthesize address = _address;
@synthesize coordinate = _coordinate;

- (id)initWithName:(NSString*)name address:(NSString*)address duns:(NSString*)duns  coordinate:(CLLocationCoordinate2D)coordinate {
    if ((self = [super init])) {
        _name = [name copy];
        _address = [address copy];
        _coordinate = coordinate;
        _duns = duns;
    }
    return self;
}

- (NSString *)title {
    if ([_name isKindOfClass:[NSNull class]])
        return @"Unknown";
    else
        return _name;
}

- (NSString *)subtitle {
    return _address;
}

- (MKMapItem*)mapItem {
    NSDictionary *addressDict = @{(NSString*)kABPersonAddressStreetKey : _address};
    
    MKPlacemark *placemark = [[MKPlacemark alloc]
                              initWithCoordinate:self.coordinate
                              addressDictionary:addressDict];
    
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    mapItem.name = self.title;
    
    return mapItem;
}

@end
