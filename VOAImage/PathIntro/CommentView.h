//
//  CommentView.h
//  VOAImage
//
//  Created by zhao song on 13-6-20.
//  Copyright (c) 2013年 Dmitry Kondratyev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPGrowingTextView.h"
#import "DDXML.h"
#import "DDXMLElementAdditions.h"
#import "UIImageView+WebCache.h"
#import "AudioTextView.h"

#define kCommTableHeightPh 60.0

@class CommentView;

@protocol CommentViewDelegate <NSObject>
@optional
- (void)catchComments:(NSInteger)commArray;
- (void)doResponse:(UIButton*)sender;
- (void)doSend;
- (void)doAgree:(UIButton*)sender;
- (void)doAgainst:(UIButton*)sender;
- (void)playUserCommRec:(UIButton*)sender;
- (void)didTrumpetBtnPressed:(UIButton*)sender;
@end

@interface CommentView : UIScrollView<HPGrowingTextViewDelegate,ASIHTTPRequestDelegate>

@property (nonatomic, assign) id <CommentViewDelegate> myDelegate;

@property (nonatomic, strong) IBOutlet UIButton* backBtn;
@property (nonatomic, strong) IBOutlet UIImageView *userImg;
@property (nonatomic, strong) IBOutlet UILabel *userName;
@property (nonatomic, strong) UIButton        *sendBtn; //发表评论按钮
@property (nonatomic, strong) UIButton        *commChangeBtn; //发表评论按钮
@property (nonatomic, strong) UIButton        *commRecBtn; //发表评论按钮
@property (nonatomic, strong) IBOutlet UITableView        *commTableView; //评论表视图
@property (nonatomic, strong) IBOutlet UIView        *myView; //发表评论按钮
@property (nonatomic, strong) IBOutlet UIView        *containerView; //评论页面的底部视图，包含输入框及发表按钮
@property (nonatomic, strong) NSMutableArray *commArray;    //存放评论内容的数组
@property (nonatomic, strong) HPGrowingTextView *textView; //可换行的输入框控件

@property (nonatomic, strong) UIImageView *peakMeterIV;
@property (nonatomic, strong) UIView *recorderView;
@property (nonatomic, strong) UIButton  *displayModeBtn;   //播放模式展示
@property (nonatomic, strong) UILabel  *senLabel;   //录音时展示当前新闻的英文句子
@property (nonatomic, strong) AudioTextView *myAudioView; //senLabel的渐变背景视图
@property (nonatomic, assign) NSInteger nowPage;    //记录当前获取的评论的页数
@property (nonatomic, assign) NSInteger totalPage;  //记录评论总页数
@property (nonatomic) BOOL isResponse; //标识当前评论是否是回复

- (IBAction)didTrumpetBtnPressed:(id)sender;

@end
