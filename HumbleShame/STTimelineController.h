//
//  STTimelineController.h
//  HumbleShame
//
//  Created by Bill Williams on 07.05.12.
//  Copyright (c) 2012 Momentum Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@class STDetailViewController;


@interface STTimelineController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) STDetailViewController *detailViewController;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@end
