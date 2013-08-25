//
//  STDetailViewController.m
//  STTasks
//
//  Created by Sergey Tyo on 8/25/13.
//  Copyright (c) 2013 Sergey Tyo. All rights reserved.
//

#import "STTaskDetailViewController.h"
#import "STTask.h"

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
        self.labelTitle.text=_task.title;
        self.labelDescription.text=_task.info;
        [self.imageViewPicture setImage:[UIImage imageNamed:_task.image]];
    }
}




@end
