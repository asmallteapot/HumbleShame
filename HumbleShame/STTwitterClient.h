//
//  STTwitterClient.h
//  HumbleShame
//
//  Created by Bill Williams on 07.05.12.
//  Copyright (c) 2012 Momentum Mobile. All rights reserved.
//

#import "AFHTTPClient.h"

typedef void (^STTwitterClientSyncSuccessBlock)(NSSet *tweets);
typedef void (^STTwitterClientSyncFailureBlock)(NSError *error);

@interface STTwitterClient : AFHTTPClient

+ (STTwitterClient *)sharedClient;

- (void)downloadTweets;
- (void)downloadTweets:(STTwitterClientSyncSuccessBlock)successBlock;
- (void)downloadTweets:(STTwitterClientSyncSuccessBlock)successBlock failure:(STTwitterClientSyncFailureBlock)failureBlock;
@end
