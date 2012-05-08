//
//  STTwitterClient.h
//  HumbleShame
//
//  Created by Bill Williams on 07.05.12.
//  Copyright (c) 2012 Momentum Mobile. All rights reserved.
//

#import "AFHTTPClient.h"

extern NSString * const kSTTwitterAPIBaseURLString;
extern NSString * const kSTTwitterClientSyncCompleted;
extern NSString * const kSTTwitterClientSyncFailed;
extern NSString * const kSTTwitterClientLastSync;

typedef void (^STTwitterClientSyncSuccessBlock)(NSSet *tweets);
typedef void (^STTwitterClientSyncFailureBlock)(NSError *error);


@interface STTwitterClient : AFHTTPClient
+ (STTwitterClient *)sharedClient;

- (void)downloadTweets;
- (void)downloadTweets:(STTwitterClientSyncSuccessBlock)successBlock;
- (void)downloadTweets:(STTwitterClientSyncSuccessBlock)successBlock failure:(STTwitterClientSyncFailureBlock)failureBlock;
@end
