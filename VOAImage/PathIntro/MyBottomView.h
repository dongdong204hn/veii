//
//  MyBottomView.h
//  VOAImage
//
//  Created by zhao song on 13-6-5.
//  Copyright (c) 2013年 Dmitry Kondratyev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyBottomView;

@protocol MyBottomViewDelegate <NSObject>
@optional
- (void)didCommBtnPressed:(MyBottomView *)myBottomView ;
- (void)didShareBtnPressed:(MyBottomView *)myBottomView ;
@end

@interface MyBottomView : UIView

@property (nonatomic, assign) id <MyBottomViewDelegate> myDelegate;

- (IBAction)didCommBtnPressed:(id)sender;
- (IBAction)didShareBtnPressed:(id)sender;

@end
