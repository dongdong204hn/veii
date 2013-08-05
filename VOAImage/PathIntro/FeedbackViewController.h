//
//  FeedbackViewController.h
//  VOAImage
//
//  Created by 赵松 on 13-7-28.
//  Copyright (c) 2013年 Dmitry Kondratyev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h> //操作layer
#import "ASIFormDataRequest.h"
#import "DDXML.h"
#import "DDXMLElementAdditions.h"
#import "Reachability.h"//isExistenceNetwork

@interface FeedbackViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate>

@property (nonatomic, strong) IBOutlet UIScrollView *mainScroll;
@property (nonatomic, strong) IBOutlet UIButton *submitBtn;
@property (nonatomic, strong) IBOutlet UITextView *feedback;
@property (nonatomic, strong) IBOutlet UILabel *mailLabel;
@property (nonatomic, strong) IBOutlet UITextField *mail;
@property (nonatomic) BOOL sendLock;
@property (nonatomic, strong) UIAlertView *alert;

- (IBAction) didBackBtnPressed:(id)sender;
- (IBAction) didSubmitBtnPressed:(id)sender;

@end
