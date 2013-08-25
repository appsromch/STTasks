//
//  STDetailViewController.m
//  STTasks
//
//  Created by Sergey Tyo on 8/25/13.
//  Copyright (c) 2013 Sergey Tyo. All rights reserved.
//

#import "STTaskDetailViewController.h"

@interface STTaskDetailViewController ()
- (void)configureView;
@end

@implementation STTaskDetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
}

-(void)setInfo:(NSDictionary *)info{
    _info=info;
    [self configureView];
}

#pragma mark - Methods

- (void)configureView
{
    if (_info) {
        self.labelTitle.text=_info[@"title"];
        self.labelDescription.text=_info[@"description"];
        [self.imageViewPicture setImage:[UIImage imageNamed:_info[@"image"]]];
    }
}




@end
