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

+ (id)createEntityWithAttributes:(NSDictionary *)attributes {
	User *newUser = [User createEntity];
	if (!newUser) {
		return nil;
	}
		
	// map JSON dictionary to Core Data properties
	newUser.userID = [attributes objectForKey:@"id_str"];
	newUser.bio = [attributes objectForKey:@"description"];
	newUser.screenName = [attributes objectForKey:@"screen_name"];
	newUser.profileImageURL = [attributes objectForKey:@"profile_image_url"];
	
	return newUser;
}


#pragma mark - Friendlier Core Data accessors
- (void)addTweet:(Tweet *)newTweet {
	[self addTweetsObject:newTweet];
}

- (void)removeTweet:(Tweet *)aTweet {
	[self removeTweetsObject:aTweet];
}

@end
