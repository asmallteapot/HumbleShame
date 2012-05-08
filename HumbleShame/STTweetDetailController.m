//
//  STTweetDetailController.m
//  HumbleShame
//
//  Created by Bill Williams on 07.05.12.
//  Copyright (c) 2012 Momentum Mobile. All rights reserved.
//

#import "STTweetDetailController.h"
#import "Tweet.h"
#import "User.h"

@interface STTweetDetailController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation STTweetDetailController
@synthesize tweet = _tweet;
@synthesize profileImageView = _profileImageView;
@synthesize masterPopoverController = _masterPopoverController;

#pragma mark - Tweet accessor
- (void)setTweet:(Tweet *)newTweet {
	if (_tweet != newTweet) {
		_tweet = newTweet;
		[self configureView];
	}

	if (self.masterPopoverController != nil) {
		[self.masterPopoverController dismissPopoverAnimated:YES];
	}		
}

- (void)configureView {
	if (self.tweet) {
		NSURL *profileImageURL = [NSURL URLWithString:self.tweet.user.profileImageURL];
		[self.profileImageView setImageWithURL:profileImageURL];
	} else {
		self.profileImageView.image = nil;
		// TODO display a placeholder image
	}
}


#pragma mark - View lifecycle
- (void)viewDidLoad {
	[super viewDidLoad];
	[self configureView];
}

- (void)viewDidUnload {
	[super viewDidUnload];
	self.profileImageView = nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
		return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
	} else {
		return YES;
	}
}


#pragma mark - Split View delegate
- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController {
	barButtonItem.title = NSLocalizedString(@"Timeline", @"Timeline");
	[self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
	self.masterPopoverController = popoverController;
}


- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
	// Called when the view is shown again in the split view, invalidating the button and popover controller.
	[self.navigationItem setLeftBarButtonItem:nil animated:YES];
	self.masterPopoverController = nil;
}

@end
