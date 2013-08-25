//
//  STDetailViewController.h
//  STTasks
//
//  Created by Sergey Tyo on 8/25/13.
//  Copyright (c) 2013 Sergey Tyo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STTaskViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
