//
//  MyTopView.h
//  VOAImage
//
//  Created by zhao song on 13-6-5.
//  Copyright (c) 2013年 Dmitry Kondratyev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyTopView;

@protocol MyTopViewDelegate <NSObject>
@optional
- (void)didListBtnPressed:(MyTopView *)myTopView ;
- (void)didMoreBtnPressed:(MyTopView *)myTopView ;
- (void)didIyubaBtnPressed:(MyTopView *)myTopView ;
@end


@interface MyTopView : UIView

@property (nonatomic, assign) id <MyTopViewDelegate> myDelegate;

- (IBAction)didListBtnPressed:(id)sender;
- (IBAction)didMoreBtnPressed:(id)sender;
- (IBAction)didIyubaBtnPressed:(id)sender;

@end
