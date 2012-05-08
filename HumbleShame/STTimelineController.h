//
//  STTimelineController.h
//  HumbleShame
//
//  Created by Bill Williams on 07.05.12.
//  Copyright (c) 2012 Momentum Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@class STTweetDetailController;


@interface STTimelineController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) STTweetDetailController *detailViewController;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@end
