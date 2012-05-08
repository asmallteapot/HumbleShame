//
//  STTweetDetailController.h
//  HumbleShame
//
//  Created by Bill Williams on 07.05.12.
//  Copyright (c) 2012 Momentum Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Tweet;

@interface STTweetDetailController : UIViewController <UIActionSheetDelegate, UISplitViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) Tweet *tweet;
@property (nonatomic) BOOL fullScreen;

- (IBAction)actionMenu:(id)sender;
@end
