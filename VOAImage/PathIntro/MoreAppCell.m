//
//  MoreAppCell.m
//  VOAImage
//
//  Created by 赵松 on 13-7-31.
//  Copyright (c) 2013年 Dmitry Kondratyev. All rights reserved.
//

#import "MoreAppCell.h"

@implementation MoreAppCell
@synthesize appImg;
@synthesize titleLabel;
@synthesize descLabel;

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
