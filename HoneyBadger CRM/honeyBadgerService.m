// ----------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// ----------------------------------------------------------------------------
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "honeyBadgerService.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>
#import "DnBCompany.h"

#pragma mark * Private interace
@interface honeyBadgerService() <MSFilter>

@property (nonatomic, strong)   MSTable *table;
@property (nonatomic)           NSInteger busyCount;

@end

#pragma mark * Implementation
@implementation honeyBadgerService
@synthesize companies, campaigns;

+ (honeyBadgerService *)defaultService
{
    // Create a singleton instance of QSTodoService
    static honeyBadgerService* service;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[honeyBadgerService alloc] init];
    });
    
    return service;
}

-(honeyBadgerService *)init
{
    self = [super init];
    
    if (self)
    {
        // Initialize the Mobile Service client with your URL and key
        MSClient *client = [MSClient clientWithApplicationURLString:@"https://dnb-crm.azure-mobile.net/"
                                                     applicationKey:@"<YOUR APPLICATION KEY>"];
        
        // Add a Mobile Service filter to enable the busy indicator
        self.client = [client clientWithFilter:self];
        self.table = [_client tableWithName:@"campaign"];
        
        self.companies = [[NSMutableArray alloc] init];
        self.campaigns = [[NSMutableArray alloc] init];
        self.busyCount = 0;
    }
    
    return self;
}

- (void)refreshDataOnSuccess:(QSCompletionBlock)completion
{
    // Query the Campaigns table
    [self.table readWithCompletion:^(NSArray *results, NSInteger totalCount, NSError *error)
    {
        [self logErrorIfNotNil:error];
        
        NSMutableArray* businesses = [NSMutableArray new];
        
        //scan through all objects in the array--do we already have this business?
        for(NSDictionary* duns in results){
            BOOL busExists = FALSE;
            
            for(DnBCompany* bus in businesses){
                NSString* itemDnB = [duns valueForKey:@"DUNSNumber"];
                
                if([bus.DUNSNumber isEqualToString:itemDnB]){
                    bus.campaigns += 1;
                    NSUInteger itemsPoints = [[duns valueForKey:@"Cost"] integerValue];
                    bus.pointsUsed += itemsPoints;
                    busExists = TRUE;
                }
            }
            
            if(busExists == FALSE) {
                //new business, add
                DnBCompany* bus = [[DnBCompany alloc] init];
                bus.DUNSNumber = [duns valueForKey:@"DUNSNumber"];
                bus.CompanyName = [duns valueForKey:@"CompanyName"];
                bus.campaigns = 1;
                NSUInteger itemsPoints = [[duns valueForKey:@"Cost"] integerValue];
                bus.pointsUsed = itemsPoints;
                
                [businesses addObject:bus];
            }
        }
        
        companies = [businesses mutableCopy];
        // Let the caller know that we finished
        completion();
    }];
}

- (void)getCampaignsForDUNSNumber:(NSString*)dunsNumber completion:(QSCompletionBlock)completion
{
    // Create a predicate that finds items where complete is false
    NSString* searchString = [@"DUNSNumber == " stringByAppendingString:dunsNumber];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:searchString];
    
    // Query the TodoItem table and update the items property with the results from the service
    [self.table readWithPredicate:predicate completion:^(NSArray *results, NSInteger totalCount, NSError *error)
     {
         [self logErrorIfNotNil:error];
         campaigns = [results mutableCopy];
         completion();
     }];
}

-(void)addItem:(NSDictionary *)item completion:(QSCompletionWithIndexBlock)completion
{
    // Insert the item into the TodoItem table and add to the items array on completion
    [self.table insert:item completion:^(NSDictionary *result, NSError *error)
    {
        [self logErrorIfNotNil:error];
        
        NSUInteger index = [campaigns count];
        [(NSMutableArray *)campaigns insertObject:result atIndex:index];
        
        // Let the caller know that we finished
        completion(index);
    }];
}

- (void)busy:(BOOL)busy
{
    // assumes always executes on UI thread
    if (busy)
    {
        if (self.busyCount == 0 && self.busyUpdate != nil)
        {
            self.busyUpdate(YES);
        }
        self.busyCount ++;
    }
    else
    {
        if (self.busyCount == 1 && self.busyUpdate != nil)
        {
            self.busyUpdate(FALSE);
        }
        self.busyCount--;
    }
}

- (void)logErrorIfNotNil:(NSError *) error
{
    if (error)
    {
        NSLog(@"ERROR %@", error);
    }
}

#pragma mark * MSFilter methods

- (void)handleRequest:(NSURLRequest *)request
                 next:(MSFilterNextBlock)next
             response:(MSFilterResponseBlock)response
{
    // A wrapped response block that decrements the busy counter
    MSFilterResponseBlock wrappedResponse = ^(NSHTTPURLResponse *innerResponse, NSData *data, NSError *error)
    {
        [self busy:NO];
        response(innerResponse, data, error);
    };
    
    // Increment the busy counter before sending the request
    [self busy:YES];
    next(request, wrappedResponse);
}

@end
