//
//  explainView.h
//  VOAImage
//
//  Created by 赵松 on 13-7-16.
//  Copyright (c) 2013年 Dmitry Kondratyev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExplainView : UIView

@property (nonatomic, strong) UILabel *wordLabel;
@property (nonatomic, strong) UILabel *pronLabel;
@property (nonatomic, strong) UIButton *audioButton;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UITextView *defTextView;
@property (nonatomic, strong) UITextView *senTextView;

+ (ExplainView *)sharedExplainView;

@end
