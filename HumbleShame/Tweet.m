//
//  Tweet.m
//  HumbleShame
//
//  Created by Bill Williams on 07.05.12.
//  Copyright (c) 2012 Momentum Mobile. All rights reserved.
//

#import "Tweet.h"


@implementation Tweet
@dynamic uniqueID;
@dynamic createdAt;
@dynamic text;
@dynamic user;

- (id)initWithAttributes:(NSDictionary *)attributes {
	self = [super init];
	if (!self) {
		return nil;
	}
	
	// TODO map JSON dictionary to Core Data properties
	
	return self;
}

@end
