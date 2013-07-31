//
//  EventLocation.h
//  Geocoding
//
//  Created by Eugene Chuvyrov on 10/1/12.
//  Copyright (c) 2012 Code Foundry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface DnbCompanyLocation : NSObject <MKAnnotation> {
    NSString *_name;
    NSString *_address;
    CLLocationCoordinate2D _coordinate;
}

@property (copy) NSString *duns;
@property (copy) NSString *name;
@property (copy) NSString *address;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (id)initWithName:(NSString*)name address:(NSString*)address duns:(NSString*)duns coordinate:(CLLocationCoordinate2D)coordinate;
- (MKMapItem*)mapItem;

@end
