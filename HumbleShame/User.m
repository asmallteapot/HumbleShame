//
//  User.m
//  HumbleShame
//
//  Created by Bill Williams on 07.05.12.
//  Copyright (c) 2012 Momentum Mobile. All rights reserved.
//

#import "User.h"
#import "Tweet.h"


@implementation User
@dynamic userID;
@dynamic name;
@dynamic bio;
@dynamic screenName;
@dynamic profileImageURL;
@dynamic tweets;

- (id)initWithAttributes:(NSDictionary *)attributes {
	self = [super init];
	if (!self) {
		return nil;
	}
	
	// TODO map JSON dictionary to Core Data properties
	
	return self;
}


#pragma mark - Friendlier Core Data accessors
- (void)addTweet:(Tweet *)newTweet {
	[self addTweetsObject:newTweet];
}

- (void)removeTweet:(Tweet *)aTweet {
	[self removeTweetsObject:aTweet];
}

@end
