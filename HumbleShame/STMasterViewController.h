//
//  STMasterViewController.h
//  HumbleShame
//
//  Created by Bill Williams on 07.05.12.
//  Copyright (c) 2012 Momentum Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STDetailViewController;

#import <CoreData/CoreData.h>

@interface STMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) STDetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
