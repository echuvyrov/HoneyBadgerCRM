//
//  Event.m
//  weCompete
//
//  Created by Eugene Chuvyrov on 10/1/12.
//  Copyright (c) 2012 We Compete. All rights reserved.
//

#import "DnBCompany.h"
#import <CommonCrypto/CommonHMAC.h>
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation DnBCompany

@synthesize Name, Description, Address, City, State, ZipCode;
@synthesize EndPointAddress;

static DnBCompany *instance =nil;
+(DnBCompany *)getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            instance= [DnBCompany new];
        }
    }
    return instance;
}

@end
