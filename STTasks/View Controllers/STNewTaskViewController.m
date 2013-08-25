//
//  STNewTaskViewController.m
//  STTasks
//
//  Created by Sergey Tyo on 8/25/13.
//  Copyright (c) 2013 Sergey Tyo. All rights reserved.
//

#import "STNewTaskViewController.h"
#import "STCoreDataController.h"
@interface STNewTaskViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

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

}

#pragma mark - Actions
- (IBAction)add:(id)sender {
    [self.textFieldTitle resignFirstResponder];
    [self.textFieldDescription resignFirstResponder];
    if ([self.textFieldTitle.text isEqualToString:@""]||[self.textFieldDescription.text isEqualToString:@""]) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"New Task"
                                                      message:@"Enter title and description"
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    
    NSString *imgName=@"";
    if (self.imageViewPicture.image) {
        imgName=[NSString stringWithFormat:@"%d_%d.png",arc4random()%10000,arc4random()%10000];
        NSData *imgData=UIImagePNGRepresentation(self.imageViewPicture.image);
        [imgData writeToFile:[[STCoreDataController sharedInstance] imagePath:imgName] atomically:YES];
    }
    
    [[STCoreDataController sharedInstance] addTaskWithTitle:self.textFieldTitle.text
                                                description:self.textFieldDescription.text
                                                      image:imgName];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addImage:(id)sender {
    [self.textFieldTitle resignFirstResponder];
    [self.textFieldDescription resignFirstResponder];
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (IBAction)hideKeyboard:(id)sender {
    [self.textFieldTitle resignFirstResponder];
    [self.textFieldDescription resignFirstResponder];
}

#pragma mark - imagePickerController delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    self.imageViewPicture.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

@end
