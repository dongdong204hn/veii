//
//  MyTopView.m
//  VOAImage
//
//  Created by zhao song on 13-6-5.
//  Copyright (c) 2013年 Dmitry Kondratyev. All rights reserved.
//

#import "MyTopView.h"

@implementation MyTopView
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

- (IBAction)didListBtnPressed:(id)sender
{
    if ([myDelegate respondsToSelector:@selector(didListBtnPressed:)]) {
        [myDelegate didListBtnPressed:self];
    }
}

- (IBAction)didMoreBtnPressed:(id)sender
{
    if ([myDelegate respondsToSelector:@selector(didMoreBtnPressed:)]) {
        [myDelegate didMoreBtnPressed:self];
    }
}

- (IBAction)didIyubaBtnPressed:(id)sender
{
    if ([myDelegate respondsToSelector:@selector(didIyubaBtnPressed:)]) {
        [myDelegate didIyubaBtnPressed:self];
    }
}

@end
