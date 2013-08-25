//
//  STNewTaskViewController.m
//  STTasks
//
//  Created by Sergey Tyo on 8/25/13.
//  Copyright (c) 2013 Sergey Tyo. All rights reserved.
//

#import "STNewTaskViewController.h"
#import "STCoreDataController.h"
@interface STNewTaskViewController ()

@end

@implementation STNewTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)add:(id)sender {
    [[STCoreDataController sharedInstance] addTaskWithTitle:self.textFieldTitle.text
                                                description:self.textFieldDescription.text
                                                      image:@"pic_1.png"];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
