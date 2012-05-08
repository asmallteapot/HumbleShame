//
//  User.h
//  HumbleShame
//
//  Created by Bill Williams on 07.05.12.
//  Copyright (c) 2012 Momentum Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Tweet;

@interface User : NSManagedObject
@property (nonatomic, retain) NSString * userID;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * bio;
@property (nonatomic, retain) NSString * screenName;
@property (nonatomic, retain) NSString * profileImageURL;
@property (nonatomic, retain) NSSet *tweets;

+ (id)createEntityWithAttributes:(NSDictionary *)attributes;

// Friendlier Core Data accessors
- (void)addTweet:(Tweet *)newTweet;
- (void)removeTweet:(Tweet *)aTweet;
@end

@interface User (CoreDataGeneratedAccessors)
- (void)addTweetsObject:(Tweet *)value;
- (void)removeTweetsObject:(Tweet *)value;
- (void)addTweets:(NSSet *)values;
- (void)removeTweets:(NSSet *)values;
@end
