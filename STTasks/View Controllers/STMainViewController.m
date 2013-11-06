//
//  STMasterViewController.m
//  STTasks
//
//  Created by Sergey Tyo on 8/25/13.
//  Copyright (c) 2013 Sergey Tyo. All rights reserved.
//

#import "STMainViewController.h"

#import "STTaskDetailViewController.h"
#import "STCoreDataController.h"
#import "STTask.h"


@interface STMainViewController ()<NSFetchedResultsControllerDelegate> 
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@end

@implementation STMainViewController


- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createNewTask)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    
    NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	}
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }

}

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    self.fetchedResultsController = [[STCoreDataController sharedInstance] getFetchResultsTasks];
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
    
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id  sectionInfo = [[_fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    STTask *task = [_fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text=task.title;
    cell.detailTextLabel.text=task.info;
    cell.imageView.image=[UIImage imageWithContentsOfFile:[[STCoreDataController sharedInstance] imagePath:task.image]];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        STTask *task = [_fetchedResultsController objectAtIndexPath:indexPath];
        [[STCoreDataController sharedInstance] removeTask:task];
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}


#pragma mark - Actions
- (void)createNewTask
{
    [self performSegueWithIdentifier:@"addNewTask" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        STTask *task = [_fetchedResultsController objectAtIndexPath:indexPath];
        [[segue destinationViewController] setTask:task];
    }
}

#pragma mark - FetchResultController delegate
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray
                                               arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray
                                               arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

@end
