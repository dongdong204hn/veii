//
//  ListCell.m
//  VOAImage
//
//  Created by zhao song on 13-6-18.
//  Copyright (c) 2013年 Dmitry Kondratyev. All rights reserved.
//

#import "ListCell.h"

@implementation ListCell
@synthesize imgOne;
@synthesize imgTwo;
@synthesize imgThree;

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
