//
//  TouchView.m
//  VOAImage
//
//  Created by 赵松 on 13-7-16.
//  Copyright (c) 2013年 Dmitry Kondratyev. All rights reserved.
//

#import "TouchView.h"

@implementation TouchView

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//    }
//    return self;
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event{
//    if(!self.dragging)
//    {
        [[self nextResponder]touchesBegan:touches withEvent:event];
//    }
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
//    if(!self.dragging)
//    {
        [[self nextResponder]touchesEnded:touches withEvent:event];
//    }
    [super touchesEnded:touches withEvent:event];
}

@end
