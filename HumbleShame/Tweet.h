//
//  Tweet.h
//  HumbleShame
//
//  Created by Bill Williams on 07.05.12.
//  Copyright (c) 2012 Momentum Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class User;

@interface Tweet : NSManagedObject
@property (nonatomic, retain) NSString * uniqueID;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) User *user;

- (id)initWithAttributes:(NSDictionary *)attributes;
@end
