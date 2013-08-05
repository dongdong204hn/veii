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
- (void)didTrumpetBtnPressed:(UIButton*)sender ;
@end

@interface MyBottomView : UIView

@property (nonatomic, assign) id <MyBottomViewDelegate> myDelegate;
@property (nonatomic, strong) IBOutlet UIImageView *userImg;
@property (nonatomic, strong) IBOutlet UILabel *userName;

- (IBAction)didCommBtnPressed:(id)sender;
- (IBAction)didShareBtnPressed:(id)sender;
- (IBAction)didTrumpetBtnPressed:(id)sender;
@end
