//
//  STTwitterClient.h
//  HumbleShame
//
//  Created by Bill Williams on 07.05.12.
//  Copyright (c) 2012 Momentum Mobile. All rights reserved.
//

#import "AFHTTPClient.h"

@interface STTwitterClient : AFHTTPClient

+ (STTwitterClient *)sharedClient;
@end
