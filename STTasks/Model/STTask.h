//
//  STTask.h
//  STTasks
//
//  Created by Sergey Tyo on 8/25/13.
//  Copyright (c) 2013 Sergey Tyo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface STTask : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * info;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSDate * date;

@end
