//
//  STTwitterClient.m
//  HumbleShame
//
//  Created by Bill Williams on 07.05.12.
//  Copyright (c) 2012 Momentum Mobile. All rights reserved.
//

#import "STTwitterClient.h"

NSString * const kSTTwitterAPIBaseURLString = @"https://api.twitter.com/1/";

@implementation STTwitterClient

+ (STTwitterClient *)sharedClient {
	static STTwitterClient *_sharedClient = nil;
	static dispatch_once_t oncePredicate;
	dispatch_once(&oncePredicate, ^{
		_sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kSTTwitterAPIBaseURLString]];
	});

	return _sharedClient;
}


- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }

    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
	[self setDefaultHeader:@"Accept" value:@"application/json"];

    return self;
}

@end
