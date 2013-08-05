//
//  explainView.m
//  VOAImage
//
//  Created by 赵松 on 13-7-16.
//  Copyright (c) 2013年 Dmitry Kondratyev. All rights reserved.
//

#import "ExplainView.h"

@implementation ExplainView
@synthesize wordLabel;
@synthesize pronLabel;
@synthesize audioButton;
@synthesize closeButton;
@synthesize senTextView;
@synthesize defTextView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        UIFont *Courier = [UIFont fontWithName:@"Arial" size:20];
        UIFont *CourierT = [UIFont fontWithName:@"Arial" size:16];
        UIFont *CourierTh = [UIFont fontWithName:@"Arial" size:14];
//        UIFont *CourierP = [UIFont fontWithName:@"Arial" size:23];
//        UIFont *CourierTP = [UIFont fontWithName:@"Arial" size:19];
//        UIFont *CourierThP = [UIFont fontWithName:@"Arial" size:17];
        
        // Initialization code
        wordLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 180, 30)];
        [wordLabel setFont :Courier];
        [wordLabel setTextAlignment:UITextAlignmentLeft];
        wordLabel.text = @"word";
        wordLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:wordLabel];
        
        //    UILabel *pronLabel = [[UILabel alloc]initWithFrame:CGRectMake(40+[myWord.key sizeWithFont:Courier].width, 5, [[NSString stringWithFormat:@"[%@]", myWord.pron] sizeWithFont:Courier].width+10, 20)];
        pronLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 30, 180, 20)];
        [pronLabel setFont: CourierT];
        [pronLabel setTextAlignment:UITextAlignmentLeft];
        pronLabel.text = @"pron";
        pronLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:pronLabel];
        
//        if (wordPlayer) {
//            //        [wordPlayer release];
//            wordPlayer = nil;
//        }
//        wordPlayer =[[AVPlayer alloc]initWithURL:[NSURL URLWithString:myWord.audio]];
//        [wordPlayer play];
        
        audioButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
//        if (isiPhone) {
            [audioButton setImage:[UIImage imageNamed:@"wordSound.png"] forState:UIControlStateNormal];
//        } else {
//            [audioButton setImage:[UIImage imageNamed:@"wordSound-iPad.png"] forState:UIControlStateNormal];
//        }
//        [audioButton addTarget:self action:@selector(playWord:) forControlEvents:UIControlEventTouchUpInside];
        //    [audioButton setFrame:CGRectMake(250, 10, 30, 30)];
//        if (isiPhone) {
            [audioButton setFrame:CGRectMake(250,5, 30, 30)];
//        } else {
//            [audioButton setFrame:CGRectMake(385,5, 40, 40)];
//        }
        //    [audioButton setFrame:CGRectMake(50+[myWord.key sizeWithFont:Courier].width + [[NSString stringWithFormat:@"[%@]", myWord.pron] sizeWithFont:Courier].width, 5, 20, 20)];
        [self addSubview:audioButton];
        
        closeButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
//        if (isiPhone) {
            [closeButton setImage:[UIImage imageNamed:@"wordClose.png"] forState:UIControlStateNormal];
//        } else {
//            [closeButton setImage:[UIImage imageNamed:@"wordClose-ipad.png"] forState:UIControlStateNormal];
//        }
        [closeButton addTarget:self action:@selector(closeExplaView) forControlEvents:UIControlEventTouchUpInside];
//        if (isiPhone) {
            [closeButton setFrame:CGRectMake(285, 5, 30, 30)];
//        } else {
//            [closeButton setFrame:CGRectMake(435, 5, 40, 40)];   
//        }
        [self addSubview:closeButton];
        
        defTextView = [[UITextView alloc] init];
        //    defTextView.delegate = self;
        defTextView.text = @"define";
        [defTextView setFrame:CGRectMake(5, 50, self.frame.size.width-35, 20)];
//        if ([myWord.def isEqualToString:@" "]) {
//            defTextView.text = kPlaySeven;
//            [defTextView setFrame:CGRectMake(5,(isiPhone?50:70), explainView.frame.size.width-35, 20)];
//            //        [defTextView setContentSize:CGSizeMake(explainView.frame.size.width-10, 20)];
//            //                    NSLog(@"未联网无法查看释义!");
//        }else{
//            defTextView.text = myWord.def;
//            CGSize enSize = [myWord.def sizeWithFont:(isiPhone?CourierTh:CourierThP) constrainedToSize:CGSizeMake(explainView.frame.size.width-50, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
//            [defTextView setFrame:CGRectMake(5, (isiPhone?50:70), explainView.frame.size.width-35, (enSize.height+10 < 70? enSize.height+10: 70))];
//            //        [defTextView setContentSize:CGSizeMake(explainView.frame.size.width-10, enSize.height)];
//        }
        [defTextView setTag:arc4random()%1000];
        [defTextView setEditable:NO];
        [defTextView setFont:CourierTh];
        defTextView.backgroundColor = [UIColor clearColor];
        [defTextView setContentOffset:CGPointMake(0, 5)];
        [self addSubview:defTextView];
        //    [senButton setTag:defTextView.frame.size.height];//***
        //    [explainView setAlpha:1];
        
        senTextView = [[UITextView alloc] initWithFrame:CGRectMake(5,50 + defTextView.frame.size.height, self.frame.size.width-10, 190 - defTextView.frame.size.height)];
        [senTextView setFrame:CGRectMake(5, 50 + defTextView.frame.size.height, self.frame.size.width-10, 190 - defTextView.frame.size.height)];
        senTextView.text = @"sentence";
        [senTextView setTag:arc4random()%1000];
        [senTextView setEditable:NO];
        [senTextView setFont: CourierTh];
        senTextView.backgroundColor = [UIColor clearColor];
        [senTextView setContentOffset:CGPointMake(0, 10)];
        [self addSubview:senTextView];
        
        //    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"showSen"]) {
//        if (isiPhone) {
//            [explainView setFrame:CGRectMake(0, 50, 320, 240)];
//        } else {
//            [explainView setFrame:CGRectMake(144, 220, 480, 360)];
//        }
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

/**
 *  关闭单词翻译标签
 */
- (void)closeExplaView {
    [self setHidden:YES];
}

#pragma mark - static method
/**
 *  获取播放界面容器单子实例
 */
+ (ExplainView *)sharedExplainView
{
    static ExplainView *explainView;
    
    @synchronized(self)
    {
        if (!explainView){
            explainView = [[ExplainView alloc] initWithFrame:CGRectMake(0, 64, 320, 240)]; //进行一些必须的初始化操作，例如添加监听器
            [explainView setHidden:YES];
            //            sharedPlayer.voa = voa;
        }
        else{
            
        }
        
        return explainView;
    }
}


@end
