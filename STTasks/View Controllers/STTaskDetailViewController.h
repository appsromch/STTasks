//
//  STDetailViewController.h
//  STTasks
//
//  Created by Sergey Tyo on 8/25/13.
//  Copyright (c) 2013 Sergey Tyo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STTaskDetailViewController : UIViewController

@property (strong, nonatomic) NSDictionary *info;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewPicture;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelDescription;


@end
