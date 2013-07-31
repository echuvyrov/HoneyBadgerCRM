//
//  Event.h
//  weCompete
//
//  Created by Eugene Chuvyrov on 10/1/12.
//  Copyright (c) 2012 We Compete. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DnBCompany : NSObject
@property(nonatomic,retain)NSString *DUNSNumber;
@property(nonatomic,retain)NSString *CompanyName;
@property(nonatomic,retain)NSString *WebAddress;
@property(nonatomic,retain)NSString *EndPointAddress;
@property (nonatomic, retain) NSString *CompanyId;

+(DnBCompany*)getInstance;

@property (nonatomic) NSUInteger campaigns;
@property (nonatomic) NSUInteger pointsUsed;
@property (nonatomic, strong) NSString *Name;
@property (nonatomic, strong) NSString *Description;
@property (nonatomic, strong) NSString *Location;
@property (nonatomic, strong) NSString *Address;
@property (nonatomic, strong) NSString *Address2;
@property (nonatomic, strong) NSString *City;
@property (nonatomic, strong) NSString *State;
@property (nonatomic, strong) NSString *ZipCode;

@end
