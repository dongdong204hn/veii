//
//  MyBottomView.m
//  VOAImage
//
//  Created by zhao song on 13-6-5.
//  Copyright (c) 2013年 Dmitry Kondratyev. All rights reserved.
//

#import "MyBottomView.h"

@implementation MyBottomView
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

- (IBAction)didCommBtnPressed:(id)sender {
    if ([myDelegate respondsToSelector:@selector(didCommBtnPressed:)]) {
        [myDelegate didCommBtnPressed:self];
    }
}

- (IBAction)didShareBtnPressed:(id)sender {
    if ([myDelegate respondsToSelector:@selector(didShareBtnPressed:)]) {
        [myDelegate didShareBtnPressed:self];
    }
}

@end
