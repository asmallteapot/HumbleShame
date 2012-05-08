//
//  STTimelineController.m
//  HumbleShame
//
//  Created by Bill Williams on 07.05.12.
//  Copyright (c) 2012 Momentum Mobile. All rights reserved.
//

#import "STTimelineController.h"
#import "STTweetDetailController.h"
#import "STTwitterClient.h"
#import "SVPullToRefresh.h"
#import "Tweet.h"
#import "User.h"


NSString * const kSTTimelineTweetsCache = @"STTimelineTweetsCache";


@interface STTimelineController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end


@implementation STTimelineController
@synthesize detailViewController = _detailViewController;
@synthesize fetchedResultsController = _fetchedResultsController;


#pragma mark - View lifecycle
- (void)awakeFromNib {
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
		self.clearsSelectionOnViewWillAppear = NO;
		self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
	}
	[super awakeFromNib];
}


- (void)viewDidLoad {
	[super viewDidLoad];
	
	// Configure fetched results controller
	self.fetchedResultsController = [Tweet fetchAllSortedBy:@"createdAt" ascending:NO withPredicate:nil groupBy:nil delegate:self];
	
	// Configure iPad detail controller
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
		self.detailViewController = (STTweetDetailController *)[[self.splitViewController.viewControllers lastObject] topViewController];
	}
	
	// Configure pull-to-refresh
	[self.tableView addPullToRefreshWithActionHandler:^{
		[[STTwitterClient sharedClient] downloadTweets:^(NSSet *tweets){
			[self.tableView.pullToRefreshView stopAnimating];
			
			NSDate *lastUpdated = [[NSUserDefaults standardUserDefaults] objectForKey:kSTTwitterClientLastSync];
			self.tableView.pullToRefreshView.lastUpdatedDate = lastUpdated;
			[self.tableView reloadData];
			
		} failure:^(NSError *error){
			[self.tableView.pullToRefreshView stopAnimating];
			// TODO handle errors
		}];
	}];
	[self.tableView.pullToRefreshView triggerRefresh];
}


- (void)viewDidUnload {
	[super viewDidUnload];
	// Release any retained subviews of the main view.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([[segue identifier] isEqualToString:@"DisplayTweet"]) {
		NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
		Tweet *tweet = [self.fetchedResultsController objectAtIndexPath:indexPath];
		
		STTweetDetailController *detailController = segue.destinationViewController;
		detailController.tweet = tweet;
	}
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
		return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
	} else {
		return YES;
	}
}


#pragma mark - Table View data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [self.fetchedResultsController.sections count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	id<NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController.sections objectAtIndex:section];
	return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
	[self configureCell:cell atIndexPath:indexPath];
	return cell;
}


#pragma mark - Table View delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// iPad doesn’t support displaying detail items via segues
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
		Tweet *tweet = [self.fetchedResultsController objectAtIndexPath:indexPath];
		self.detailViewController.tweet = tweet;
	}
}


#pragma mark - Fetched results controller
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
	[self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
		   atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
	switch(type) {
		case NSFetchedResultsChangeInsert:
			[self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
			break;
			
		case NSFetchedResultsChangeDelete:
			[self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
			break;
	}
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
	   atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
	  newIndexPath:(NSIndexPath *)newIndexPath {
	
	switch(type) {
		case NSFetchedResultsChangeInsert:
			[self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
			break;
			
		case NSFetchedResultsChangeDelete:
			[self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
			break;
			
		case NSFetchedResultsChangeUpdate:
			[self configureCell:[self.tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
			break;
			
		case NSFetchedResultsChangeMove:
			[self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
			[self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
			break;
	}
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
	[self.tableView endUpdates];
}


- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
	Tweet *tweet = [self.fetchedResultsController objectAtIndexPath:indexPath];
	cell.textLabel.text = tweet.text;
	cell.detailTextLabel.text = tweet.user.screenName;
}

@end
