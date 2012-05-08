//
//  Tweet.m
//  HumbleShame
//
//  Created by Bill Williams on 07.05.12.
//  Copyright (c) 2012 Momentum Mobile. All rights reserved.
//

#import "Tweet.h"
#import "User.h"

@implementation Tweet
@dynamic uniqueID;
@dynamic createdAt;
@dynamic permalink;
@dynamic text;
@dynamic user;

+ (id)createEntityWithAttributes:(NSDictionary *)attributes {
	Tweet *newTweet = [Tweet createEntity];
	if (!newTweet) {
		return nil;
	}
	
	// create a date formatter for Twitter
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"EEE MMM dd HH:mm:ss ZZZ yyyy"];
	
	// extract basic data
	NSDictionary *retweetData = [attributes objectForKey:@"retweeted_status"];
	NSDictionary *authorData = [retweetData objectForKey:@"user"];
	
	// find or create the user for this tweet
	User *originalAuthor = [User findFirstByAttribute:@"userID" withValue:[authorData objectForKey:@"id_str"]];
	if (!originalAuthor) {
		originalAuthor = [User createEntityWithAttributes:authorData];
	}
	newTweet.user = originalAuthor;
	
	// now save data about the original tweet itself
	newTweet.uniqueID = [retweetData objectForKey:@"id_str"];
	newTweet.createdAt = [dateFormatter dateFromString:[retweetData objectForKey:@"created_at"]];
	newTweet.permalink = [retweetData objectForKey:@""]; // not provided by API?
	newTweet.text = [retweetData objectForKey:@"text"];
	
	return newTweet;
}

@end
