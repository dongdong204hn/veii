//
//  AudioTextView.m
//  VOAImage
//
//  Created by 赵松 on 13-8-2.
//  Copyright (c) 2013年 Dmitry Kondratyev. All rights reserved.
//

#import "AudioTextView.h"

@implementation AudioTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setTextColor:[UIColor whiteColor]];
        [self setText:@"11111111111111111111111"];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGFloat colors[] = {
        19/255.0f, 17/255.0f, 19/255.0f, 1.0f,
        82/255.0f, 72/255.0f, 82/255.0f, 1.0f
    };
    
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colors, NULL, 2);
    
    CGContextDrawLinearGradient(context, gradient,
                                CGPointMake(CGRectGetMinX(rect),
                                            CGRectGetMinY(rect)),
                                CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect)), 0);
    CGColorSpaceRelease(colorSpace);
}

@end
