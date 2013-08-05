//
//  CommentView.m
//  VOAImage
//
//  Created by zhao song on 13-6-20.
//  Copyright (c) 2013年 Dmitry Kondratyev. All rights reserved.
//

#import "CommentView.h"
#import "JMWhenTapped.h"

@implementation CommentView
@synthesize myDelegate;
@synthesize backBtn;
@synthesize sendBtn;
@synthesize commChangeBtn;
@synthesize commRecBtn;
@synthesize myView;
@synthesize containerView;
@synthesize commArray;
@synthesize textView;
@synthesize recorderView;
@synthesize peakMeterIV;
@synthesize displayModeBtn;
@synthesize nowPage;
@synthesize totalPage;
@synthesize isResponse;
@synthesize senLabel;
@synthesize userName;
@synthesize userImg;
@synthesize myAudioView;

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

- (void)awakeFromNib {
    nowPage = 1;
    totalPage = 1;
    isResponse = NO;
    commArray = [[NSMutableArray alloc] init];
    UIImage *rawEntryBackground = [UIImage imageNamed:@"MessageEntryInputField.png"];
    UIImage *entryBackground = [rawEntryBackground stretchableImageWithLeftCapWidth:13 topCapHeight:22];
    UIImageView *entryImageView = [[UIImageView alloc] initWithImage:entryBackground];
    
//    myView = [[UIView alloc] initWithFrame:CGRectMake(320*3, 0, 320, 372)];
//    commTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, (isFree?260:310) + kFiveAdd) style:UITableViewStylePlain];
    
    entryImageView.frame = CGRectMake(60, 0, 170, 40);
    commRecBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commRecBtn.frame = CGRectMake(60, 5, 167, 30);
//    containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 332, 320, 40)];
    
    textView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(60, 3, 162, 40)];
    textView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    
	textView.minNumberOfLines = 1;
	textView.maxNumberOfLines = 6;
    [textView setText:kPlayFourte];
	textView.returnKeyType = UIReturnKeyNext; //just as an example
	textView.font = [UIFont systemFontOfSize:15.0f];
	textView.delegate = self;
    textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
    textView.backgroundColor = [UIColor whiteColor];
    
    entryImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    UIImage *rawBackground = [UIImage imageNamed:@"MessageEntryBackground.png"];
    UIImage *background = [rawBackground stretchableImageWithLeftCapWidth:13 topCapHeight:22];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:background];
    imageView.frame = CGRectMake(0, 0, containerView.frame.size.width, containerView.frame.size.height);
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    // view hierachy
    [containerView addSubview:imageView];
    [containerView addSubview:textView];
    [containerView addSubview:entryImageView];
    
    UIImage *sendBtnBackground = [[UIImage imageNamed:@"MessageEntrySendButton.png"] stretchableImageWithLeftCapWidth:13 topCapHeight:0];
    UIImage *selectedSendBtnBackground = [[UIImage imageNamed:@"MessageEntrySendButtonPressed.png"] stretchableImageWithLeftCapWidth:13 topCapHeight:0];
    
    sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	sendBtn.frame = CGRectMake(containerView.frame.size.width - 69, 8, 63, 27);
    sendBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
	[sendBtn setTitle:kPlayFifte forState:UIControlStateNormal];
    
    [sendBtn setTitleShadowColor:[UIColor colorWithWhite:0 alpha:0.4] forState:UIControlStateNormal];
    sendBtn.titleLabel.shadowOffset = CGSizeMake (0.0, -1.0);
    sendBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    
    [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//	[sendBtn addTarget:self action:@selector(doSend) forControlEvents:UIControlEventTouchUpInside];
    [sendBtn setBackgroundImage:sendBtnBackground forState:UIControlStateNormal];
    [sendBtn setBackgroundImage:selectedSendBtnBackground forState:UIControlStateSelected];
	[containerView addSubview:sendBtn];
    
    commChangeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commChangeBtn.frame = CGRectMake(6, 5, 30, 30);
    commChangeBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    [commChangeBtn setImage:[UIImage imageNamed:@"audioComm.png"] forState:UIControlStateNormal];
    [commChangeBtn setImage:[UIImage imageNamed:@"audioCommPres.png"] forState:UIControlStateHighlighted];
    [commChangeBtn setTag:1];
//	[commChangeBtn addTarget:self action:@selector(doCommChange) forControlEvents:UIControlEventTouchUpInside];
	[containerView addSubview:commChangeBtn];
    
    commRecBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    [commRecBtn setTitle:kPlaySixte forState:UIControlStateNormal];
    
    [commRecBtn setTitleShadowColor:[UIColor colorWithWhite:0 alpha:0.4] forState:UIControlStateNormal];
    commRecBtn.titleLabel.shadowOffset = CGSizeMake (0.0, -1.0);
    commRecBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    
    [commRecBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [commRecBtn addTarget:self action:@selector(startCommRecord) forControlEvents:UIControlEventTouchDown];
//    [commRecBtn addTarget:self action:@selector(endCommRecord) forControlEvents:UIControlEventTouchUpInside];
//    [commRecBtn addTarget:self action:@selector(endCommRecord) forControlEvents:UIControlEventTouchUpOutside];
    [commRecBtn setBackgroundImage:sendBtnBackground forState:UIControlStateNormal];
    [commRecBtn setBackgroundImage:selectedSendBtnBackground forState:UIControlStateSelected];
    [containerView addSubview:commRecBtn];
    [commRecBtn setHidden:YES];
    containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    recorderView = [[UIView alloc] initWithFrame:CGRectMake(110, 180, 100, 100)];
    [recorderView setBackgroundColor:[UIColor darkGrayColor]];
    UIImageView *micoImg = [[UIImageView alloc] initWithFrame:CGRectMake(12, 18, 48, 64)];
    [micoImg setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"recordMicro" ofType:@"png"]]];
    peakMeterIV = [[UIImageView alloc] initWithFrame:CGRectMake(69, 29, 19, 53)];
    [peakMeterIV setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"speaker_1" ofType:@"png"]]];
    [recorderView addSubview:micoImg];
    [recorderView addSubview:peakMeterIV];
    [recorderView setHidden:YES];
    [self addSubview:recorderView];
    
    displayModeBtn = [[UIButton alloc] initWithFrame:CGRectMake(80, 320, 160, 35)];
    [displayModeBtn setBackgroundColor:[UIColor blackColor]];
    [displayModeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [displayModeBtn setAlpha:0];
    [self addSubview:displayModeBtn];
    
    /**
     *  播放容器实例初始化前先建立两个对键盘状态的监听器
     */
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    myAudioView = [[AudioTextView alloc] initWithFrame:CGRectMake(0, 0, 320, 188)];
    senLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 188)];
    [senLabel setBackgroundColor:[UIColor clearColor]];
    [senLabel setTextColor:[UIColor whiteColor]];
    [senLabel setFont:[UIFont systemFontOfSize:15]];
    [senLabel setNumberOfLines:0];
    [myAudioView whenTapped:^{
        [myAudioView setHidden:YES];
    }];
    [myAudioView addSubview:senLabel];
    [myAudioView setHidden:YES];
    [self addSubview:myAudioView];
}

/**
 *  键盘出现时监听响应函数
 */
-(void) keyboardWillShow:(NSNotification *)note{
    // get keyboard size and loctaion
    //    NSLog(@"键盘出");
	CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    //    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // Need to translate the bounds to account for rotation.
    keyboardBounds = [self convertRect:keyboardBounds toView:nil];
    
	// get a rect for the textView frame
	CGRect containerFrame = containerView.frame;
//    containerFrame.origin.y = 40.0f;
    containerFrame.origin.y = self.frame.size.height - (keyboardBounds.size.height + containerFrame.size.height) - 208;
	// animations settings
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    //    [UIView setAnimationCurve:[curve intValue]];
	
	// set views with new info
	containerView.frame = containerFrame;
	
	// commit animations
	[UIView commitAnimations];
}

/**
 *  键盘隐去时监听响应函数
 */
-(void) keyboardWillHide:(NSNotification *)note{
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    //    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
	
	// get a rect for the textView frame
	CGRect containerFrame = containerView.frame;
    containerFrame.origin.y = self.bounds.size.height - containerFrame.size.height - 208;
	
	// animations settings
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    //    [UIView setAnimationCurve:[curve intValue]];
    
	// set views with new info
	containerView.frame = containerFrame;
	
	// commit animations
	[UIView commitAnimations];
}

- (void)doResponse:(UIButton*)sender{
    if ([myDelegate respondsToSelector:@selector(doResponse:)]) {
        [myDelegate doResponse:sender];
    }
}

- (void)doSend{
    if ([myDelegate respondsToSelector:@selector(doSend)]) {
        [myDelegate doSend];
    }
}

- (void)doAgainst:(UIButton*)sender {
    if ([myDelegate respondsToSelector:@selector(doAgainst:)]) {
        [myDelegate doAgainst:sender];
    }
//    [sender setTitle:[NSString stringWithFormat:@"%d", sender.titleLabel.text.integerValue+1] forState:UIControlStateNormal];
}

- (void)doAgree:(UIButton*)sender {
    if ([myDelegate respondsToSelector:@selector(doAgree:)]) {
        [myDelegate doAgree:sender];
    }
//    [sender setTitle:[NSString stringWithFormat:@"%d", sender.titleLabel.text.integerValue+1] forState:UIControlStateNormal];
}

- (void)playUserCommRec:(UIButton*)sender {
    if ([myDelegate respondsToSelector:@selector(playUserCommRec:)]) {
        [myDelegate playUserCommRec:sender];
    }
}

- (IBAction)didTrumpetBtnPressed:(id)sender {
    if ([myDelegate respondsToSelector:@selector(didTrumpetBtnPressed:)]) {
        [myDelegate didTrumpetBtnPressed:sender];
    }
}

#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView //明确cell数目
 numberOfRowsInSection:(NSInteger)section {
    return ([commArray count]/9 + 1);
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    if (row == [commArray count]/9) {
        static NSString *ThirdLevelCell= @"NewCellTwo";
        UITableViewCell *cellThree = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:ThirdLevelCell];
        if (!cellThree) {
            cellThree = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ThirdLevelCell];
        }
        [cellThree setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cellThree setHidden:YES];
        if (nowPage < totalPage) {
            if ([myDelegate respondsToSelector:@selector(catchComments:)]) {
                [myDelegate catchComments:++nowPage];
            }
        }
        return cellThree;
    } else {
        UIFont *Courier = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:12];
        UIFont *CourierF = [UIFont systemFontOfSize:12];
//        UIFont *Couriera = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:15];
//        UIFont *CourieraF = [UIFont systemFontOfSize:15];
        static NSString *FirstLevelCell= @"CommentCell";
        UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:FirstLevelCell];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FirstLevelCell];
            
            UIImageView *cellBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"commCellBg.png"]];
            [cellBg setFrame:CGRectMake(0, 0, 320, kCommTableHeightPh)];
            [cell setBackgroundView:cellBg];
//            [cell addSubview:cellBg];[[NSBundle mainBundle] pathForResource:@"commCellBg" ofType:@"png"]]
            
            UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 120, 15)];
            [nameLabel setBackgroundColor:[UIColor clearColor]];
            [nameLabel setFont:Courier];
            [nameLabel setTag:1];
            [nameLabel setTextColor:[UIColor colorWithRed:71.0/255 green:71.0/255 blue:72.0/255 alpha:1.0f]];
            [nameLabel setNumberOfLines:2];
            [cell addSubview:nameLabel];
//            [nameLabel release];
            
            UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(210, 0, 65, 15)];
            [dateLabel setBackgroundColor:[UIColor clearColor]];
            [dateLabel setFont:CourierF];
            [dateLabel setTag:2];
            [dateLabel setTextColor:[UIColor colorWithRed:71.0/255 green:71.0/255 blue:72.0/255 alpha:1.0f]];
            [dateLabel setNumberOfLines:2];
            [cell addSubview:dateLabel];
//            [dateLabel release];
            
            UILabel *comLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 15, 246, 45)];
            [comLabel setBackgroundColor:[UIColor clearColor]];
            [comLabel setFont:CourierF];
            [comLabel setTag:3];
            [comLabel setTextColor:[UIColor colorWithRed:71.0/255 green:71.0/255 blue:72.0/255 alpha:1.0f]];
            [comLabel setNumberOfLines:4];
            [comLabel setLineBreakMode:UILineBreakModeWordWrap];
            [cell addSubview:comLabel];
//            [comLabel release];
            
            UIImageView *userImgOne = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
            [userImgOne setTag:4];
//            [userImg whenTapped:^{
//                //                        NSLog(@"发信 %i", userImg.superview.tag);
//                for (int i = 0; i < [commArray count]/7; i++) {
//                    if (i == userImg.superview.tag) {
//                        int fromUserId = [[[NSUserDefaults standardUserDefaults] objectForKey:@"nowUser"] integerValue];
//                        UserMessage *userMsg = [[UserMessage alloc] initWithFromUserId:fromUserId fromUserName:[MyUser findNameById:fromUserId] toUserId:[[commArray objectAtIndex:i*7+5] integerValue] toUserName:(NSString *) [commArray objectAtIndex:i*7+1] comment:[commArray objectAtIndex:i*7+3] topicId:voa._voaid];
//                        SendMessageController *sendMsgController = [[SendMessageController alloc] init];
//                        sendMsgController.userMsg = userMsg;
//                        [userMsg release];
//                        [self.navigationController pushViewController:sendMsgController animated:YES];
//                        [sendMsgController release], sendMsgController = nil;
//                        //                                NSLog(@"发信 %@", [NSString stringWithFormat:@"回复%@:", [commArray objectAtIndex:i*6+1]]);
//                    }
//                }
//                //                        NSLog(@"发信 %@", [commArray objectAtIndex:row*6+1]);
//            }];
            [cell addSubview:userImgOne];
//            [userImg release];
            
            UIButton *reponseBtn = [[UIButton alloc] initWithFrame:CGRectMake(290, 0, 30, 15)];
            [reponseBtn addTarget:self action:@selector(doResponse:) forControlEvents:
             UIControlEventTouchUpInside];
            [reponseBtn setImage:[UIImage imageNamed:@"commResp.png"] forState:UIControlStateNormal];
            [reponseBtn setTag:5];
            [cell addSubview:reponseBtn];
//            [reponseBtn release];
            
            UIButton *playCommBtn = [[UIButton alloc] initWithFrame:CGRectMake(70, 30, 52, 21)];
            [playCommBtn addTarget:self action:@selector(playUserCommRec:) forControlEvents:UIControlEventTouchUpInside];
            [playCommBtn setImage:[UIImage imageNamed:@"commSpeak.png"] forState:UIControlStateNormal];
            [playCommBtn setTag:6];
            [playCommBtn setHidden:YES];
            [cell addSubview:playCommBtn];
//            [playCommBtn release];
            
            UIButton *upImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(140, 0, 15, 15)];
            [upImgBtn setImage:[UIImage imageNamed:@"zan.png"] forState:UIControlStateNormal];
            [upImgBtn setTag:9];
            [cell addSubview:upImgBtn];
            
            UIButton *upBtn = [[UIButton alloc] initWithFrame:CGRectMake(140, 0, 35, 15)];
            [upBtn setBackgroundColor:[UIColor clearColor]];
            [upBtn.titleLabel setFont:CourierF];
            [upBtn setTag:7];
            [upBtn addTarget:self action:@selector(doAgree:) forControlEvents:UIControlEventTouchUpInside];
            [upBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [upBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
//            [upBtn setNumberOfLines:1];
            [cell addSubview:upBtn];
            
            
            UIButton *downImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(175, 0, 15, 15)];
            [downImgBtn setImage:[UIImage imageNamed:@"cai.png"] forState:UIControlStateNormal];
            [downImgBtn setTag:10];
            [cell addSubview:downImgBtn];
            
            UIButton *downBtn = [[UIButton alloc] initWithFrame:CGRectMake(175, 0, 35, 15)];
            [downBtn setBackgroundColor:[UIColor clearColor]];
            [downBtn.titleLabel setFont:CourierF];
            [downBtn addTarget:self action:@selector(doAgainst:) forControlEvents:UIControlEventTouchUpInside];
            [downBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
            [downBtn setTag:8];
            [downBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//            [downBtn.titleLabel setTextAlignment:NSTextAlignmentLeft];
//            [downBtn.titleLabel setTextColor:[UIColor colorWithRed:71.0/255 green:71.0/255 blue:72.0/255 alpha:1.0f]];
//            [dateLabel setNumberOfLines:1];
            [cell addSubview:downBtn];
            
        }
        for (UIView *nLabel in [cell subviews]) {
            if (nLabel.tag == 1) {
                [(UILabel*)nLabel setText:[commArray objectAtIndex:row*9+2]];
            }
            if (nLabel.tag == 2) {
                [(UILabel*)nLabel setText:[commArray objectAtIndex:row*9+8]];
            }
            if (nLabel.tag == 4) {
                [(UIImageView*)nLabel setImageWithURL:[commArray objectAtIndex:row*9+3]  placeholderImage:[UIImage imageNamed:@"userDefault.png"]];
            }
            if ([[commArray objectAtIndex:row*9+4] integerValue] == 1) {
                if (nLabel.tag == 3) {
                    [nLabel setHidden:YES];
                }
                if (nLabel.tag == 6) {
                    [nLabel setHidden:NO];
                }
                if (nLabel.tag == 7) {
                    [nLabel setHidden:NO];
                }
                if (nLabel.tag == 8) {
                    [nLabel setHidden:NO];
                }
                if (nLabel.tag == 9) {
                    [nLabel setHidden:NO];
                }
                if (nLabel.tag == 10) {
                    [nLabel setHidden:NO];
                }
            } else {
                if (nLabel.tag == 3) {
                    [nLabel setHidden:NO];
                    [(UILabel*)nLabel setText:[commArray objectAtIndex:row*9+5]];
                }
                if (nLabel.tag == 6) {
                    [nLabel setHidden:YES];
                }
                if (nLabel.tag == 7) {
                    [nLabel setHidden:YES];
                }
                if (nLabel.tag == 8) {
                    [nLabel setHidden:YES];
                }
                if (nLabel.tag == 9) {
                    [nLabel setHidden:YES];
                }
                if (nLabel.tag == 10) {
                    [nLabel setHidden:YES];
                }
            }
            if (nLabel.tag == 7) {
                [(UIButton*)nLabel setTitle:[commArray objectAtIndex:row*9+6] forState:UIControlStateNormal];
            }
            if (nLabel.tag == 8) {
                [(UIButton*)nLabel setTitle: [commArray objectAtIndex:row*9+7] forState:UIControlStateNormal];
                NSLog(@"caishu:%@", [commArray objectAtIndex:row*9+7]);
            }
            
        }
        
        //            [cell.imageView setImageWithURL:[commArray objectAtIndex:row*5+2] placeholderImage:[UIImage imageNamed:@"acquiesce.png"]];
        //            [cell setTag:[[commArray objectAtIndex:row*7] integerValue]];
        [cell setTag: row];
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    //    }
    
    return nil;
}



#pragma mark MyTextViewDelegate
//- (void)catchTouches:(NSSet *)touches myTextView:(MyTextView *)myTextView {
//    wordTouches = touches;
//    if (nowTextView.tag != myTextView.tag) {
//        nowTextView = myTextView;
//    }
//}

#pragma mark -
#pragma mark TableView Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [indexPath row] < [commArray count]/9 ? kCommTableHeightPh : 1;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    if ([keyCommFd isFirstResponder]) {
    [self endEditing:YES];
    //    }
//    if (![explainView isHidden]) {
//        [explainView setHidden:YES];
//        [myHighLightWord setHidden:YES];
//    }
}

#pragma mark - HPGrowingTextViewDelegate
//-(void)resignTextView
//{
//	[textView resignFirstResponder];
//}

//Code from Brett Schumann
/**
 *  评论输入框换行响应协议
 */
- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
    float diff = (growingTextView.frame.size.height - height);
    
	CGRect r = containerView.frame;
    r.size.height -= diff;
    r.origin.y += diff;
	containerView.frame = r;
}

/**
 *  评论输入框开始编辑时响应协议
 */
- (void)growingTextViewDidBeginEditing:(HPGrowingTextView *)growingTextView {
//    int nowUserID = [[[NSUserDefaults standardUserDefaults] objectForKey:@"nowUser"] integerValue];
    if ([[growingTextView text] isEqualToString:kPlayFourte]) {
        [growingTextView setText:@""];
    }
//    if (nowUserID > 0) {
//        if ([[growingTextView text] length] > 0 && [[growingTextView text] rangeOfString:kPlayNine].location == NSNotFound) {
//            [self sendComments:0];
//        }
//    } else {
//        [growingTextView setText:@""];
//    }
    
}

/**
 *  用户按下键盘上return时响应
 */
//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{//当用户按下return，把焦点从textField移开那么键盘就会消失了
//    [self endEditing:YES];
//    return YES;
//    
//}

#pragma mark - Touch screen
/**
 *  点击主视图
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
//    if (fixTimeView.alpha > 0.5) {
//        [Constants beginAnimationWithName:@"Switch" duration:.5];
//        [fixTimeView setAlpha:0];
//        [UIView commitAnimations];
//    }
//    if (![explainView isHidden]) {
//        [explainView setHidden:YES];
//        [myHighLightWord setHidden:YES];
//    }
}
@end
