//
//  STTaskCell.m
//  STTasks
//
//  Created by Sergey Tyo on 8/26/13.
//  Copyright (c) 2013 Sergey Tyo. All rights reserved.
//

#import "STTaskCell.h"

@implementation STTaskCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    if (editing&&!self.showingDeleteConfirmation) {
        [UIView animateWithDuration:0.3
                         animations:^{
                             self.imageViewPicture.transform=CGAffineTransformMakeTranslation(80, 0);
                             self.labelTitle.transform=CGAffineTransformMakeTranslation(80, 0);
                             self.labelInfo.transform=CGAffineTransformMakeTranslation(80, 0);
                         }];
    }
    else{
        [UIView animateWithDuration:0.3
                         animations:^{
                             self.imageViewPicture.transform=CGAffineTransformIdentity;
                             self.labelTitle.transform=CGAffineTransformIdentity;
                             self.labelInfo.transform=CGAffineTransformIdentity;
                         }];
    }
}

                                
@end
