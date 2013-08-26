//
//  STTaskCell.h
//  STTasks
//
//  Created by Sergey Tyo on 8/26/13.
//  Copyright (c) 2013 Sergey Tyo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STTaskCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageViewPicture;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelInfo;

@end
