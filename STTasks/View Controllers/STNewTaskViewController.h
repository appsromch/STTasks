//
//  STNewTaskViewController.h
//  STTasks
//
//  Created by Sergey Tyo on 8/25/13.
//  Copyright (c) 2013 Sergey Tyo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STNewTaskViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textFieldTitle;
@property (weak, nonatomic) IBOutlet UITextField *textFieldDescription;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewPicture;
- (IBAction)add:(id)sender;
- (IBAction)addImage:(id)sender;
- (IBAction)hideKeyboard:(id)sender;

@end
