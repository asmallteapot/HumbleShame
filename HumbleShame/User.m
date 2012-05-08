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
		
	// map JSON dictionary to Core Data properties
	self.userID = [attributes objectForKey:@"id_str"];
	self.bio = [attributes objectForKey:@"description"];
	self.screenName = [attributes objectForKey:@"screen_name"];
	self.profileImageURL = [attributes objectForKey:@"profile_image_url"];
	
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
