//
//  STCoreDataController.h
//  STTasks
//
//  Created by Sergey Tyo on 8/25/13.
//  Copyright (c) 2013 Sergey Tyo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class STTask;
@interface STCoreDataController : NSObject

+ (id)sharedInstance;

- (NSFetchedResultsController *)getFetchResultsTasks;
- (void)removeTask:(STTask *)task;
- (void)addTaskWithTitle:(NSString *)title description:(NSString *)description image:(NSString *)image;

@end
