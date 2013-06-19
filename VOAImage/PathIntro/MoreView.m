//
//  MoreView.m
//  VOAImage
//
//  Created by zhao song on 13-6-17.
//  Copyright (c) 2013年 Dmitry Kondratyev. All rights reserved.
//

#import "MoreView.h"

@implementation MoreView
@synthesize backBtn;
@synthesize myDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)didSettingBtnPressed:(id)sender {
    if ([myDelegate respondsToSelector:@selector(didSettingBtnPressed)]) {
        [myDelegate didSettingBtnPressed];
    }
}


@end
