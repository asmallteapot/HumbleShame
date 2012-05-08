//
//  STTweetDetailController.m
//  HumbleShame
//
//  Created by Bill Williams on 07.05.12.
//  Copyright (c) 2012 Momentum Mobile. All rights reserved.
//

#import "STTweetDetailController.h"
#import <Twitter/Twitter.h>
#import "Tweet.h"
#import "User.h"

@interface STTweetDetailController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation STTweetDetailController
@synthesize fullScreen = _fullScreen;
@synthesize tweet = _tweet;
@synthesize profileImageView = _profileImageView;
@synthesize masterPopoverController = _masterPopoverController;

#pragma mark - Property accessors
- (void)setTweet:(Tweet *)newTweet {
	if (_tweet != newTweet) {
		_tweet = newTweet;
		[self configureView];
	}

	if (self.masterPopoverController != nil) {
		[self.masterPopoverController dismissPopoverAnimated:YES];
	}		
}


- (void)setFullScreen:(BOOL)shouldBeFullScreen {
	if (_fullScreen != shouldBeFullScreen) {
		if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
			if (shouldBeFullScreen) {
				self.profileImageView.frame = [[UIScreen mainScreen] applicationFrame];
			} else {
				self.profileImageView.frame = self.view.frame;
			}
		}
		
		[[UIApplication sharedApplication] setStatusBarHidden:shouldBeFullScreen];
		self.navigationController.navigationBarHidden = shouldBeFullScreen;
		_fullScreen = shouldBeFullScreen;
	}
}


#pragma mark - View lifecycle
- (void)viewDidLoad {
	[super viewDidLoad];
	[self configureView];
	
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
		[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
		self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
		self.profileImageView.frame = [[UIScreen mainScreen] applicationFrame];
	}
}

- (void)viewDidUnload {
	[super viewDidUnload];
	self.profileImageView = nil;
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


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
		return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
	} else {
		return YES;
	}
}


#pragma mark - IB Actions
- (IBAction)actionMenu:(id)sender {
	UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Full Screen", @"Tweet", nil];
	[sheet showFromBarButtonItem:self.navigationItem.rightBarButtonItem animated:YES];
}


- (IBAction)sendTweet:(id)sender {
	// As of iOS 5.1, we only need to call this to prompt the user to sign in
	[TWTweetComposeViewController canSendTweet];
	
	TWTweetComposeViewController *tweetComposer = [[TWTweetComposeViewController alloc] init];
	[tweetComposer setInitialText:[NSString stringWithFormat:@"Nice #humblebrag, @%@:", self.tweet.user.screenName]];
	[tweetComposer addURL:[NSURL URLWithString:self.tweet.permalink]];
	[self presentModalViewController:tweetComposer animated:YES];
}


#pragma mark - Action Sheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
	switch (buttonIndex) {
		case 0:
			// Toggle full-screen mode
			self.fullScreen = !self.fullScreen;
			break;
		case 1: 
			// Tweet
			[self sendTweet:actionSheet];
			break;
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
