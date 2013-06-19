//
//  MoreView.h
//  VOAImage
//
//  Created by zhao song on 13-6-17.
//  Copyright (c) 2013年 Dmitry Kondratyev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MoreView;

@protocol MoreViewDelegate <NSObject>
@optional
- (void)didSettingBtnPressed;
@end

@interface MoreView : UIScrollView

@property (nonatomic, strong) IBOutlet UIButton* backBtn;
@property (nonatomic, assign) id <MoreViewDelegate> myDelegate;


- (IBAction)didSettingBtnPressed:(id)sender;

@end
