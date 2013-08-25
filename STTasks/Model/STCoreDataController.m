//
//  STCoreDataController.m
//  STTasks
//
//  Created by Sergey Tyo on 8/25/13.
//  Copyright (c) 2013 Sergey Tyo. All rights reserved.
//

#import "STCoreDataController.h"
#import "STTask.h"
@interface STCoreDataController()
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


- (void)saveContext;
@end

@implementation STCoreDataController

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

+ (id)sharedInstance {
    static dispatch_once_t once;
    static STCoreDataController *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (id)init{
    self = [super init];
    if (self) {
        [self copyDbIfNeeded];
    }
    return self;
}

#pragma mark - Methods

- (NSFetchedResultsController *)getFetchResultsTasks{
    NSManagedObjectContext *context=[self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"STTask" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    [fetchRequest setFetchBatchSize:50];
    
    NSFetchedResultsController *fetchResultsController =[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                            managedObjectContext:context
                                                                                              sectionNameKeyPath:nil
                                                                                                       cacheName:@"Root"];
    return fetchResultsController;
}


//  Removing Task
- (void)removeTask:(STTask *)task{
    NSError *error=nil;

    if (task.image&&![task.image isEqualToString:@""]) {
        [[NSFileManager defaultManager] removeItemAtPath:[self imagePath:task.image] error:&error];
    }
    
    NSManagedObjectContext *context=[self managedObjectContext];
    [context deleteObject:task];
    [self saveContext];
}

//  Adding new Task
- (void)addTaskWithTitle:(NSString *)title description:(NSString *)description image:(NSString *)image{
    NSManagedObjectContext *context = [self managedObjectContext];
    STTask *task = [NSEntityDescription insertNewObjectForEntityForName:@"STTask"
                                                 inManagedObjectContext:context];
    task.title=title;
    task.info=description;
    task.image=image;
    task.date=[NSDate date];
    [self saveContext];
}
//  Path for Image
- (NSString *)imagePath:(NSString *)image{
    return [[[self applicationDocumentsDirectory] path] stringByAppendingPathComponent:image];
}
#pragma mark - Core Data stack

- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *persistantStore = [self persistentStoreCoordinator];
    if (persistantStore) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_managedObjectContext performBlockAndWait:^{
            [_managedObjectContext setPersistentStoreCoordinator:persistantStore];
        }];
        
    }
    return _managedObjectContext;
}
- (void)saveContext{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = _managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);

        }
    }
}


// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"STTasks" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
    
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"STTasks.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    
    return _persistentStoreCoordinator;
}


#pragma mark - Files
- (void)copyDbIfNeeded{
    [self copyFile:@"STTasks.sqlite"];
    [self copyFile:@"pic.png"];
}
- (void)copyFile:(NSString *)fileName{
    
    NSURL *fileDocumentsUrl = [self applicationDocumentsDirectory];
    NSString *destinationPath = [fileDocumentsUrl path];
    destinationPath = [destinationPath stringByAppendingPathComponent:fileName];
    
    BOOL isDir;
    if (![[NSFileManager defaultManager] fileExistsAtPath:destinationPath isDirectory:&isDir] || isDir) {
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:[fileName stringByDeletingPathExtension] ofType:[fileName pathExtension]];
        
        NSError *error = nil;
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:destinationPath error:&error];
    }
}

#pragma mark - Application's Documents directory
// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}



@end
