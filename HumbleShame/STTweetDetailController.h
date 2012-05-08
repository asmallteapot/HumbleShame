//
//  STTweetDetailController.h
//  HumbleShame
//
//  Created by Bill Williams on 07.05.12.
//  Copyright (c) 2012 Momentum Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Tweet;

@interface STTweetDetailController : UIViewController <UISplitViewControllerDelegate>
@property (strong, nonatomic) Tweet *tweet;
@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@end
