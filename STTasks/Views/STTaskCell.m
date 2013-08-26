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
@end
