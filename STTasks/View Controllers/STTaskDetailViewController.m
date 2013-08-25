//
//  STDetailViewController.m
//  STTasks
//
//  Created by Sergey Tyo on 8/25/13.
//  Copyright (c) 2013 Sergey Tyo. All rights reserved.
//

#import "STTaskDetailViewController.h"
#import "STTask.h"
#import "STCoreDataController.h"

@interface STTaskDetailViewController ()
- (void)configureView;
@end

@implementation STTaskDetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
}

-(void)setTask:(STTask *)task{
    _task=task;
    [self configureView];
}
#pragma mark - Methods

- (void)configureView
{
    if (_task) {
        self.title=self.task.title;
        self.labelTitle.text=self.task.title;
        self.labelDescription.text=self.task.info;
        self.imageViewPicture.image=[UIImage imageWithContentsOfFile:[[STCoreDataController sharedInstance] imagePath:self.task.image]];

    }
}




@end
