//
//  STTwitterClient.m
//  HumbleShame
//
//  Created by Bill Williams on 07.05.12.
//  Copyright (c) 2012 Momentum Mobile. All rights reserved.
//

#import "STTwitterClient.h"
#import "Tweet.h"

NSString * const kSTTwitterAPIBaseURLString = @"https://api.twitter.com/1/";
NSString * const kSTTwitterClientSyncCompleted = @"STTwitterClientSyncCompleted";
NSString * const kSTTwitterClientSyncFailed = @"STTwitterClientSyncFailed";
NSString * const kSTTwitterClientLastSync = @"STTwitterClientLastSync";


@implementation STTwitterClient

#pragma mark - Singleton
+ (STTwitterClient *)sharedClient {
	static STTwitterClient *_sharedClient = nil;
	static dispatch_once_t oncePredicate;
	dispatch_once(&oncePredicate, ^{
		_sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kSTTwitterAPIBaseURLString]];
	});

	return _sharedClient;
}


#pragma mark - Object lifecycle
- (id)initWithBaseURL:(NSURL *)url {
	self = [super initWithBaseURL:url];
	if (!self) {
		return nil;
	}

	// Always use JSON for everything
	[self registerHTTPOperationClass:[AFJSONRequestOperation class]];
	[self setDefaultHeader:@"Accept" value:@"application/json"];

	return self;
}


#pragma mark - Tweets
- (void)downloadTweets {
	[self downloadTweets:nil failure:nil];
}


- (void)downloadTweets:(STTwitterClientSyncSuccessBlock)successBlock {
	[self downloadTweets:successBlock failure:nil];
}


- (void)downloadTweets:(STTwitterClientSyncSuccessBlock)successBlock failure:(STTwitterClientSyncFailureBlock)failureBlock {
	NSMutableDictionary *timelineParams = [NSMutableDictionary dictionary];
	[timelineParams setObject:@"humblebrag" forKey:@"screen_name"];
	[timelineParams setObject:@"10" forKey:@"count"];
	[timelineParams setObject:@"true" forKey:@"include_entities"];

	[self.class.sharedClient getPath:@"statuses/retweeted_by_user.json" parameters:timelineParams success:^(AFHTTPRequestOperation *operation, id JSON) {
		NSMutableSet *newTweets = [NSMutableSet set];
		// TODO handle errors
		// the top-level JSON object should be a dictionary.
		// Twitter might changed the API though.
		for (NSDictionary *tweetData in JSON) {
			Tweet *tweet = [[Tweet alloc] initWithAttributes:tweetData];
			[newTweets addObject:tweet];
		}
		
		// save the last-sync time to the defaults
		[[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:kSTTwitterClientLastSync];
		
		// TODO only send notification if block isn't provided?
		// TODO check if sending newTweets slows anything down
		if (successBlock) successBlock(newTweets);
		[[NSNotificationCenter defaultCenter] postNotificationName:kSTTwitterClientSyncCompleted object:newTweets];
		
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		// TODO only sending notification if block isn't provided?
		if (failureBlock) failureBlock(error);
		[[NSNotificationCenter defaultCenter] postNotificationName:kSTTwitterClientSyncFailed object:error];
	}];
}

@end
