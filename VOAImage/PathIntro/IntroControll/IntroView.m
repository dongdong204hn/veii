#import "IntroView.h"
//#import "JMWhenTapped.h"
#import <QuartzCore/QuartzCore.h>
#import "ROUtility.h"

@implementation IntroView
//@synthesize wordPlayer;
//@synthesize titleLabel;
//@synthesize descriptionLabel;

//- (id)initWithFrame:(CGRect)frame model:(IntroModel*)model
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        titleLabel = [[UITextView alloc] init];
//        [titleLabel setText:model.titleText];
//        [titleLabel setTextColor:[UIColor colorWithRed:163/255.0 green:144/255.0 blue:167/255.0 alpha:1.0]];
//        [titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
////        [titleLabel setShadowColor:[UIColor blackColor]];
////        [titleLabel setShadowOffset:CGSizeMake(1, 1)];
//        [titleLabel setBackgroundColor:[UIColor clearColor]];
//        [titleLabel sizeToFit];
////        [titleLabel setCenter:CGPointMake(frame.size.width/2, frame.size.height*3/5)];
//        [titleLabel setEditable:NO]; 
//        
//        descriptionLabel = [[UITextView alloc] init];
//        [descriptionLabel setText:model.descriptionText];
//        [descriptionLabel setFont:[UIFont systemFontOfSize:16]];
//        [descriptionLabel setTextColor:[UIColor colorWithRed:222/255.0 green:210/255.0 blue:224/255.0 alpha:1.0]];
////        [descriptionLabel setShadowColor:[UIColor blackColor]];
////        [descriptionLabel setShadowOffset:CGSizeMake(1, 1)];
////        [descriptionLabel setNumberOfLines:0];
//        [descriptionLabel setBackgroundColor:[UIColor clearColor]];
//        [descriptionLabel setTextAlignment:NSTextAlignmentCenter];
//        [descriptionLabel setEditable:NO];
//        
//      CGSize s = descriptionLabel.text != Nil ?[descriptionLabel.text sizeWithFont:descriptionLabel.font constrainedToSize:CGSizeMake(frame.size.width-25, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping] :CGSizeZero;
//        
//        CGSize t = titleLabel.text != Nil ?[titleLabel.text sizeWithFont:titleLabel.font constrainedToSize:CGSizeMake(frame.size.width-25, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping] :CGSizeZero;
//        
////        descriptionLabel.frame = CGRectMake((self.frame.size.width-s.width)/2, titleLabel.frame.origin.y+titleLabel.frame.size.height+4,s.width, s.height);
//        
////        //three lines height
//        CGSize four = [@"1 \n 2 \n 3 \n 4" sizeWithFont:descriptionLabel.font constrainedToSize:CGSizeMake(frame.size.width-25, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
//        
//        CGSize seven = [@"1 \n 2 \n 3 \n 4 \n 5 \n 6 \n 7" sizeWithFont:descriptionLabel.font constrainedToSize:CGSizeMake(frame.size.width-25, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
////
////        descriptionLabel.frame = CGRectMake((self.frame.size.width-s.width)/2, titleLabel.frame.origin.y+titleLabel.frame.size.height+4,s.width, MIN(s.height, three.height));
//        
//        descriptionLabel.frame = CGRectMake((self.frame.size.width-s.width)/2, frame.size.height-MIN(MAX(four.height, s.height), seven.height)-25, s.width + 25, MIN(MAX(four.height, s.height), seven.height));
//        [descriptionLabel setContentOffset:CGPointMake(0, 10)];
//        
////        NSLog(@"%f", s.height);
////        [titleLabel setCenter:CGPointMake(50, frame.size.height-MIN(s.height, three.height)-80)];
//        titleLabel.frame = CGRectMake(10, frame.size.height-MIN(MAX(four.height, s.height), seven.height)-45, t.width + 25, 20);
//        [titleLabel setContentSize:CGSizeMake(t.width + 25, 20)];
//        [titleLabel setContentOffset:CGPointMake(0, 10)]; 
//        [self addSubview:titleLabel];
//        
//        
//        UIButton *enBtn = [UIButton buttonWithType:UIButtonTypeCustom];
////        [enBtn setTitle:@"en" forState:UIControlStateNormal];
//        [enBtn setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"en@2x" ofType:@"png"]] forState:UIControlStateNormal];
//        [enBtn setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"enPres@2x" ofType:@"png"]] forState:UIControlStateHighlighted];
//        [enBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [enBtn setFrame:CGRectMake(0, 0, 20, 20)];
//        
//        UIButton *chBtn = [UIButton buttonWithType:UIButtonTypeCustom];
////        [chBtn setTitle:@"ch" forState:UIControlStateNormal];
//        [chBtn setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ch@2x" ofType:@"png"]] forState:UIControlStateNormal];
//        [chBtn setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"chPres@2x" ofType:@"png"]] forState:UIControlStateHighlighted];
//        [chBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [chBtn setFrame:CGRectMake(0, 0, 20, 20)];
//        
//        UIButton *defBtn = [UIButton buttonWithType:UIButtonTypeCustom];
////        [defBtn setTitle:@"ch" forState:UIControlStateNormal];
//        [defBtn setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"desc@2x" ofType:@"png"]] forState:UIControlStateNormal];
//        [defBtn setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"descPres@2x" ofType:@"png"]] forState:UIControlStateHighlighted];
//        [defBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [defBtn setFrame:CGRectMake(frame.size.width - 40, frame.size.height-MIN(MAX(four.height, s.height), seven.height)-35, 20, 20)];
////        [defBtn setFrame:CGRectMake(0, 0, 20, 30)];
//        
//        [enBtn setCenter:CGPointMake(frame.size.width - 120, frame.size.height-MIN(MAX(four.height, s.height), seven.height)-35)];
//        [chBtn setCenter:CGPointMake(frame.size.width - 80, frame.size.height-MIN(MAX(four.height, s.height), seven.height)-35)];
//        [defBtn setCenter:CGPointMake(frame.size.width - 40, frame.size.height-MIN(MAX(four.height, s.height), seven.height)-35)];
//        
//        
//        [self addSubview:descriptionLabel];
//        
//        [self addSubview:enBtn];
//        [self addSubview:chBtn];
//        [self addSubview:defBtn];
//    }
//    return self;
//}

- (id)initWithFrame:(CGRect)frame model:(VOAView *)model
{
    self = [super initWithFrame:frame];
    if (self) {
        nowModel = model;
        isiPhone = ![Constants isPad];
        //定义取词时显示菜单
        UIMenuItem *menuItem = [[UIMenuItem alloc]initWithTitle:kPlayThirte action:@selector(showChDefine)];
        UIMenuController *menu = [UIMenuController sharedMenuController];
        [menu setMenuItems:[NSArray arrayWithObject:menuItem]];
        
        int fontSize = 15;
        if ([Constants isPad]) {
            fontSize = 20;
        }
        int mulValueFont = [[NSUserDefaults standardUserDefaults] integerForKey:@"mulValueFont"];
        if (mulValueFont > 0) {
            fontSize = mulValueFont;
        }
//        UIFont *Courier = [UIFont systemFontOfSize:fontSize];//初始15
        
        titleLabel = [[UITextView alloc] init];
//        titleLabel.myDelegate = self;
        [titleLabel setText:model.title];
        [titleLabel setTextColor:[UIColor colorWithRed:163/255.0 green:144/255.0 blue:167/255.0 alpha:1.0]];
        [titleLabel setFont:[UIFont boldSystemFontOfSize:fontSize]];
        //        [titleLabel setShadowColor:[UIColor blackColor]];
        //        [titleLabel setShadowOffset:CGSizeMake(1, 1)];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel sizeToFit];
        //        [titleLabel setCenter:CGPointMake(frame.size.width/2, frame.size.height*3/5)];
        [titleLabel setEditable:NO];
//        [titleLabel whenTapped:^{
//            UILabel *testL = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 80, 40)];
//            [testL setText:@"取词"];
//            [self addSubview:testL];
//            [self screenTouchWord:titleLabel];
//            nowTextView = titleLabel;
//        }];
        
        
        descriptionLabel = [[UITextView alloc] init];
        [descriptionLabel setText:model.creatTime];
        [descriptionLabel setFont:[UIFont systemFontOfSize:fontSize]];
        [descriptionLabel setTextColor:[UIColor colorWithRed:222/255.0 green:210/255.0 blue:224/255.0 alpha:1.0]];
        //        [descriptionLabel setShadowColor:[UIColor blackColor]];
        //        [descriptionLabel setShadowOffset:CGSizeMake(1, 1)];
//        [descriptionLabel setNumberOfLines:0];
        [descriptionLabel setBackgroundColor:[UIColor clearColor]];
        [descriptionLabel setTextAlignment:NSTextAlignmentCenter];
        [descriptionLabel setEditable:NO];
        
        CGSize s = descriptionLabel.text != Nil ?[descriptionLabel.text sizeWithFont:descriptionLabel.font constrainedToSize:CGSizeMake(frame.size.width-25, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping] :CGSizeZero;
        
        CGSize t = titleLabel.text != Nil ?[titleLabel.text sizeWithFont:titleLabel.font constrainedToSize:CGSizeMake(frame.size.width-25, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping] :CGSizeZero;
        
        //        descriptionLabel.frame = CGRectMake((self.frame.size.width-s.width)/2, titleLabel.frame.origin.y+titleLabel.frame.size.height+4,s.width, s.height);
        
        //        //three lines height
        CGSize four = [@"1 \n 2 \n 3 \n 4" sizeWithFont:descriptionLabel.font constrainedToSize:CGSizeMake(frame.size.width-25, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
        
        CGSize seven = [@"1 \n 2 \n 3 \n 4 \n 5 \n 6 \n 7" sizeWithFont:descriptionLabel.font constrainedToSize:CGSizeMake(frame.size.width-25, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
        //
        //        descriptionLabel.frame = CGRectMake((self.frame.size.width-s.width)/2, titleLabel.frame.origin.y+titleLabel.frame.size.height+4,s.width, MIN(s.height, three.height));
        
        descriptionLabel.frame = CGRectMake(10, frame.size.height-MIN(MAX(four.height, t.height), seven.height)-s.height-15, s.width + 25, s.height);
//        descriptionLabel.frame = CGRectMake((self.frame.size.width-s.width)/2, frame.size.height-s.height-25, s.width + 25, s.height);
        [descriptionLabel setContentOffset:CGPointMake(0, 10)];
        
        //        NSLog(@"%f", s.height);
        //        [titleLabel setCenter:CGPointMake(50, frame.size.height-MIN(s.height, three.height)-80)];
        titleLabel.frame = CGRectMake(10, self.frame.size.height-MIN(MAX(four.height, t.height), seven.height)-5, t.width + 25, MIN(MAX(four.height, t.height), seven.height));
//        titleLabel.frame = CGRectMake(10, frame.size.height-25, t.width + 25, t.height);
        [titleLabel setContentSize:CGSizeMake(t.width + 25, 20)];
        [titleLabel setContentOffset:CGPointMake(0, 10)];
        [self addSubview:titleLabel];
        
        
        enBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //        [enBtn setTitle:@"en" forState:UIControlStateNormal];
        [enBtn setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"en" ofType:@"png"]] forState:UIControlStateNormal];
        [enBtn setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"enPres" ofType:@"png"]] forState:UIControlStateHighlighted];
        [enBtn setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"enPres" ofType:@"png"]] forState:UIControlStateSelected];
        [enBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [enBtn addTarget:self action:@selector(disEn:) forControlEvents:UIControlEventTouchUpInside];
        [enBtn setFrame:CGRectMake(0, 0, 20, 20)];
        [enBtn setSelected:YES];
        
        chBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //        [chBtn setTitle:@"ch" forState:UIControlStateNormal];
        [chBtn setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ch" ofType:@"png"]] forState:UIControlStateNormal];
        [chBtn setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"chPres" ofType:@"png"]] forState:UIControlStateHighlighted];
        [chBtn setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"chPres" ofType:@"png"]] forState:UIControlStateSelected];
        [chBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [chBtn addTarget:self action:@selector(disCh:) forControlEvents:UIControlEventTouchUpInside];
        [chBtn setFrame:CGRectMake(0, 0, 20, 20)];
        
        defBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //        [defBtn setTitle:@"ch" forState:UIControlStateNormal];
        [defBtn setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"desc" ofType:@"png"]] forState:UIControlStateNormal];
        [defBtn setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"descPres" ofType:@"png"]] forState:UIControlStateHighlighted];
        [defBtn setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"descPres" ofType:@"png"]] forState:UIControlStateSelected];
        [defBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [defBtn addTarget:self action:@selector(disDef:) forControlEvents:UIControlEventTouchUpInside];
        [defBtn setFrame:CGRectMake(frame.size.width - 40, frame.size.height-MIN(MAX(four.height, s.height), seven.height)-35, 20, 20)];
        //        [defBtn setFrame:CGRectMake(0, 0, 20, 30)];
        
//        [enBtn setCenter:CGPointMake(frame.size.width - 120, frame.size.height-MIN(MAX(four.height, s.height), seven.height)-35)];
//        [chBtn setCenter:CGPointMake(frame.size.width - 80, frame.size.height-MIN(MAX(four.height, s.height), seven.height)-35)];
//        [defBtn setCenter:CGPointMake(frame.size.width - 40, frame.size.height-MIN(MAX(four.height, s.height), seven.height)-35)];
        [enBtn setCenter:CGPointMake(frame.size.width - 110, frame.size.height-MIN(MAX(four.height, t.height), seven.height)-s.height-5)];
        [chBtn setCenter:CGPointMake(frame.size.width - 70, frame.size.height-MIN(MAX(four.height, t.height), seven.height)-s.height-5)];
        [defBtn setCenter:CGPointMake(frame.size.width - 30, frame.size.height-MIN(MAX(four.height, t.height), seven.height)-s.height-5)];
        
        
        [self addSubview:descriptionLabel];
        
        [self addSubview:enBtn];
        [self addSubview:chBtn];
        [self addSubview:defBtn];
        
        explainView = [ExplainView sharedExplainView];
//        if (isiPhone) {
//            [explainView setFrame:CGRectMake(0, 10, 320, 240)];
//        }else {
//            [explainView setFrame:CGRectMake(144, 220, 480, 360)];
//            explainView.layer.cornerRadius = 20.0;
//        }
//        [explainView setHidden:YES];
//        [self addSubview:explainView];
        
//        myHighLightWord = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
//        [myHighLightWord setHidden:YES];
//        [myHighLightWord setTag:1000];
//        [myHighLightWord setAlpha:0.5];
        
        myWord = [[VOAWord alloc]init];
    }
    return self;
}

/**
 *  关闭单词翻译标签
 */
- (void)closeExplaView {
    [explainView setHidden:YES];
}

/**
 *  播放单词发音按钮响应事件
 */
- (void) playWord:(UIButton *)sender
{
    if (wordPlayer) {
        wordPlayer = nil;
    }
    wordPlayer =[[AVPlayer alloc] initWithURL:[NSURL URLWithString:myWord.audio]];
    [wordPlayer play];
}

/**
 *  取词"中译"响应事件
 */
- (void) showChDefine {
//    NSLog(@"text:%@", titleLabel.text);
//    UILabel *testL = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 80, 40)];
//    [testL setText:titleLabel.text];
//    [self addSubview:testL];
    @try {
        selectWord = [titleLabel.text substringWithRange:titleLabel.selectedRange];
        LocalWord *word = [LocalWord findByKey:selectWord];
        myWord.wordId = [VOAWord findLastId] + 1;
        if (([[NSUserDefaults standardUserDefaults] boolForKey:kBePro] || [[NSUserDefaults standardUserDefaults] boolForKey:@"isVip"]) && word) {
            //        if (word) {
            //            if (word) {
            //            myWord.wordId = [VOAWord findLastId] + 1;
            myWord.key = word.key;
            myWord.audio = word.audio;
            myWord.pron = [NSString stringWithFormat:@"%@",word.pron] ;
            if (myWord.pron == nil) {
                myWord.pron = @" ";
            }
            myWord.def = [[word.def stringByReplacingOccurrencesOfRegex:@"\\s+" withString:@""]stringByReplacingOccurrencesOfString:@"null" withString:@""];
            //            [word release];
            [self wordExistDisplay];
            //            }
        } else {
            
            if (kNetIsExist) {
                //            NSLog(@"有网");
                [self catchWords:selectWord];
            } else {
                myWord.key = selectWord;
                myWord.audio = @"";
                myWord.pron = @" ";
                myWord.def = @"";
                [self wordNoDisplay];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    kNetTest;
                });
            }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"NSException");
    }
    @finally {
        //        NSLog(@"selectWord:%@", selectWord);
    }
}

//必须实现这个函数才能显示需要出现的menuItem
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
//    if (isSpeedMenu) {
//        if (action == @selector(showSpeed)) {
//            return YES;
//        }
//    } else if (isAbMenu) {
//        if (action == @selector(showAB)) {
//            return YES;
//        }
//    } else {
        if (action == @selector(showChDefine)) {
            return YES;
        }
//    }
    
    return NO;
}

- (void)disEn:(id)sender {
    [titleLabel setText:nowModel.title];
    [sender setSelected:YES];
    [chBtn setSelected:NO];
    [defBtn setSelected:NO];
}

- (void)disCh:(id)sender {
    [titleLabel setText:(nowModel.title_Cn && ![nowModel.title_Cn isEqualToString:@"null"])? nowModel.title_Cn: @""];
    [sender setSelected:YES];
    [enBtn setSelected:NO];
    [defBtn setSelected:NO];
}

- (void)disDef:(id)sender {
    [titleLabel setText:nowModel.descCn];
    [sender setSelected:YES];
    [chBtn setSelected:NO];
    [enBtn setSelected:NO];
}

//- (void)catchTouches: (NSSet *)touches myTextView:(MyTextView *)myTextView {
//    wordTouches = touches;
//}

/**
 *  取词时查到该单词释义时响应事件
 */
- (void)wordExistDisplay {
//    for (UIView *sView in [explainView subviews]) {
//        if (![sView isKindOfClass:[UIImageView class]]) {
//            [sView removeFromSuperview];
//        }
//    }
    [explainView removeFromSuperview];
    
    NSString *totalString = [[NSString alloc] init];
    for (int i = 0; i<myWord.engArray.count; i++) {
        //        NSLog(@"retain1: %i", [totalString retainCount]);
        totalString = [totalString stringByAppendingFormat:@"%d:%@\n%@\n",i+1,[myWord.engArray objectAtIndex:i],[myWord.chnArray objectAtIndex:i]];
        //        NSLog(@"retain2: %i", [totalString retainCount]);
        //        totalNum += ([[myWord.engArray objectAtIndex:i] length]+2)/34 + 2 + [[myWord.chnArray objectAtIndex:i] length]/34;
    }
    
//    UIFont *Courier = [UIFont fontWithName:@"Arial" size:20];
//    UIFont *CourierT = [UIFont fontWithName:@"Arial" size:16];
//    UIFont *CourierTh = [UIFont fontWithName:@"Arial" size:14];
//    UIFont *CourierP = [UIFont fontWithName:@"Arial" size:23];
//    UIFont *CourierTP = [UIFont fontWithName:@"Arial" size:19];
//    UIFont *CourierThP = [UIFont fontWithName:@"Arial" size:17];
    
//    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
//    if ([myWord isExisit]) {
//        if (isiPhone) {
//            [addButton setImage:[UIImage imageNamed:@"addedWord.png"] forState:UIControlStateNormal];
//        } else {
//            [addButton setImage:[UIImage imageNamed:@"addedWord-iPad.png"] forState:UIControlStateNormal];
//        }
//        [addButton setSelected:YES];
//    } else {
//        if (isiPhone) {
//            [addButton setImage:[UIImage imageNamed:@"addWord.png"] forState:UIControlStateNormal];
//        } else {
//            [addButton setImage:[UIImage imageNamed:@"addWord-iPad.png"] forState:UIControlStateNormal];
//        }
//        [addButton setSelected:NO];
//    }
    
//    [addButton addTarget:self action:@selector(addWordPressed:) forControlEvents:UIControlEventTouchUpInside];
//    if (isiPhone) {
//        [addButton setFrame:CGRectMake(195, 0, 50, 50)];
//    }else{
//        [addButton setFrame:CGRectMake(315, 0, 50, 50)];
//    }
    
//    [explainView addSubview:addButton];
    
//    UILabel *wordLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 180, 30)];
//    [wordLabel setFont :isiPhone? Courier:CourierP];
//    [wordLabel setTextAlignment:UITextAlignmentLeft];
    explainView.wordLabel.text = myWord.key;
//    wordLabel.backgroundColor = [UIColor clearColor];
//    [explainView addSubview:wordLabel];
    
    //    UILabel *pronLabel = [[UILabel alloc]initWithFrame:CGRectMake(40+[myWord.key sizeWithFont:Courier].width, 5, [[NSString stringWithFormat:@"[%@]", myWord.pron] sizeWithFont:Courier].width+10, 20)];
//    UILabel *pronLabel = [[UILabel alloc]initWithFrame:CGRectMake(15,(isiPhone?30:40), 180, 20)];
//    [pronLabel setFont :isiPhone ?CourierT:CourierTP];
//    [pronLabel setTextAlignment:UITextAlignmentLeft];
    if ([myWord.pron isEqualToString:@" "] || [myWord.pron isEqualToString:@""]) {
        explainView.pronLabel.text = @"";
    }else
    {
        explainView.pronLabel.text = [NSString stringWithFormat:@"[%@]", myWord.pron];
    }
//    pronLabel.backgroundColor = [UIColor clearColor];
//    [explainView addSubview:pronLabel];
    
    if (wordPlayer) {
//        [wordPlayer release];
        wordPlayer = nil;
    }
    wordPlayer =[[AVPlayer alloc]initWithURL:[NSURL URLWithString:myWord.audio]];
    [wordPlayer play];
    
//    UIButton *audioButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
//    if (isiPhone) {
//        [audioButton setImage:[UIImage imageNamed:@"wordSound.png"] forState:UIControlStateNormal];
//    } else {
//        [audioButton setImage:[UIImage imageNamed:@"wordSound-iPad.png"] forState:UIControlStateNormal];
//    }
    [explainView.audioButton addTarget:self action:@selector(playWord:) forControlEvents:UIControlEventTouchUpInside];
    //    [audioButton setFrame:CGRectMake(250, 10, 30, 30)];
//    if (isiPhone) {
//        [audioButton setFrame:CGRectMake(250,5, 30, 30)];
//        
//    } else {
//        [audioButton setFrame:CGRectMake(385,5, 40, 40)];
//        
//    }
    //    [audioButton setFrame:CGRectMake(50+[myWord.key sizeWithFont:Courier].width + [[NSString stringWithFormat:@"[%@]", myWord.pron] sizeWithFont:Courier].width, 5, 20, 20)];
//    [explainView addSubview:audioButton];
    
//    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
//    if (isiPhone) {
//        [closeButton setImage:[UIImage imageNamed:@"wordClose.png"] forState:UIControlStateNormal];
//    } else {
//        [closeButton setImage:[UIImage imageNamed:@"wordClose-ipad.png"] forState:UIControlStateNormal];
//    }
//    [closeButton addTarget:self action:@selector(closeExplaView) forControlEvents:UIControlEventTouchUpInside];
//    if (isiPhone) {
//        [closeButton setFrame:CGRectMake(285, 5, 30, 30)];
//        
//    } else {
//        [closeButton setFrame:CGRectMake(435, 5, 40, 40)];
//        
//    }
//    [explainView addSubview:closeButton];
    
//    UITextView *defTextView = [[UITextView alloc] init];
    //    defTextView.delegate = self;
    if ([myWord.def isEqualToString:@" "]) {
        explainView.defTextView.text = kPlaySeven;
        [explainView.defTextView setFrame:CGRectMake(5,(isiPhone?50:70), explainView.frame.size.width-35, 20)];
        //        [defTextView setContentSize:CGSizeMake(explainView.frame.size.width-10, 20)];
        //                    NSLog(@"未联网无法查看释义!");
    }else{
        explainView.defTextView.text = myWord.def;
        CGSize enSize = [myWord.def sizeWithFont:explainView.defTextView.font constrainedToSize:CGSizeMake(explainView.frame.size.width-50, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
        [explainView.defTextView setFrame:CGRectMake(5, (isiPhone?50:70), explainView.frame.size.width-35, (enSize.height+10 < 70? enSize.height+10: 70))];
        //        [defTextView setContentSize:CGSizeMake(explainView.frame.size.width-10, enSize.height)];
    }
//    [explainView.defTextView setTag:arc4random()%1000];
//    [defTextView setEditable:NO];
//    [defTextView setFont:isiPhone? CourierTh:CourierThP];
//    defTextView.backgroundColor = [UIColor clearColor];
//    [defTextView setContentOffset:CGPointMake(0, 5)];
//    [explainView addSubview:defTextView];
//    [senButton setTag:defTextView.frame.size.height];//***
    //    [explainView setAlpha:1];
    
//    UITextView *senTextView = [[UITextView alloc] initWithFrame:CGRectMake(5,(isiPhone?50:70) + defTextView.frame.size.height, explainView.frame.size.width-10,   (isiPhone?190:290) - defTextView.frame.size.height)];
    [explainView.senTextView setFrame:CGRectMake(5, 50 + explainView.defTextView.frame.size.height, explainView.frame.size.width-10, 190 - explainView.defTextView.frame.size.height)];
    explainView.senTextView.text = totalString;
//    [senTextView setTag:arc4random()%1000];
//    [senTextView setEditable:NO];
//    [senTextView setFont: isiPhone? CourierTh:CourierThP];
//    senTextView.backgroundColor = [UIColor clearColor];
//    [senTextView setContentOffset:CGPointMake(0, 10)];
//    [explainView addSubview:senTextView];
    
//    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"showSen"]) {
        if (isiPhone) {
            [explainView setFrame:CGRectMake(0, 64, 320, 240)];
        } else {
            [explainView setFrame:CGRectMake(144, 220, 480, 360)];
        }
    
//    } else {
//        if (isiPhone) {
//            [explainView setFrame:CGRectMake(0, 100, 320, 50 + defTextView.frame.size.height) ];
//        } else {
//            [explainView setFrame:CGRectMake(144, 220, 480, 70 + defTextView.frame.size.height) ];
//        }
//    }
    [explainView setHidden:NO];
    [[UIApplication sharedApplication].keyWindow addSubview:explainView];

}

/**
 *  取词时未查到该词时响应事件
 */
- (void)wordNoDisplay {
    myWord.audio = @"";
    myWord.pron = @" ";
    myWord.def = @"";
//    for (UIView *sView in [explainView subviews]) {
//        if (![sView isKindOfClass:[UIImageView class]]) {
//            [sView removeFromSuperview];
//        }
//    }
    [explainView removeFromSuperview];
//    UIFont *Courier = [UIFont fontWithName:@"Arial" size:20];
//    //    UIFont *CourierT = [UIFont fontWithName:@"Arial" size:16];
//    UIFont *CourierTh = [UIFont fontWithName:@"Arial" size:14];
//    UIFont *CourierP = [UIFont fontWithName:@"Arial" size:23];
//    //    UIFont *CourierT = [UIFont fontWithName:@"Arial" size:16];
//    UIFont *CourierThP = [UIFont fontWithName:@"Arial" size:17];
    
//    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
//    if ([myWord isExisit]) {
//        if (isiPhone) {
//            [addButton setImage:[UIImage imageNamed:@"addedWord.png"] forState:UIControlStateNormal];
//        } else {
//            [addButton setImage:[UIImage imageNamed:@"addedWord-iPad.png"] forState:UIControlStateNormal];
//        }
//        [addButton setSelected:YES];
//    } else {
//        if (isiPhone) {
//            [addButton setImage:[UIImage imageNamed:@"addWord.png"] forState:UIControlStateNormal];
//        } else {
//            [addButton setImage:[UIImage imageNamed:@"addWord-iPad.png"] forState:UIControlStateNormal];
//        }
//        [addButton setSelected:NO];
//    }
//    [addButton addTarget:self action:@selector(addWordPressed:) forControlEvents:UIControlEventTouchUpInside];
//    if (isiPhone) {
//        [addButton setFrame:CGRectMake(195, 0, 50, 50)];
//    }else{
//        [addButton setFrame:CGRectMake(315, 0, 50, 50)];
//    }
//    
//    [explainView addSubview:addButton];
    
//    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
//    if (isiPhone) {
//        [closeButton setImage:[UIImage imageNamed:@"wordClose.png"] forState:UIControlStateNormal];
//    } else {
//        [closeButton setImage:[UIImage imageNamed:@"wordClose-ipad.png"] forState:UIControlStateNormal];
//    }
//    [closeButton addTarget:self action:@selector(closeExplaView) forControlEvents:UIControlEventTouchUpInside];
//    if (isiPhone) {
//        [closeButton setFrame:CGRectMake(285, 5, 30, 30)];
//        
//    } else {
//        [closeButton setFrame:CGRectMake(435, 5, 40, 40)];
//        
//    }    [explainView addSubview:closeButton];
    
//    UILabel *wordLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 180, 30)];
//    [wordLabel setFont :isiPhone? Courier:CourierP];
//    [wordLabel setTextAlignment:UITextAlignmentLeft];
    explainView.wordLabel.text = myWord.key;
//    wordLabel.backgroundColor = [UIColor clearColor];
//    [explainView addSubview:wordLabel];
    
//    UILabel *defLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 50, explainView.frame.size.width-10, 20)];
//    [defLabel setFont :isiPhone? CourierTh:CourierThP];
//    defLabel.backgroundColor = [UIColor clearColor];
//    [defLabel setLineBreakMode:UILineBreakModeWordWrap];
//    [defLabel setNumberOfLines:1];
    explainView.defTextView.text = kWordEight;
    //                NSLog(@"无查找结果!");
//    [explainView addSubview:defLabel];

    //    [explainView setAlpha:1];
    
    if (isiPhone) {
        [explainView setFrame:CGRectMake(0, 74, 320, 70)];
    } else {
        [explainView setFrame:CGRectMake(144, 220, 480, 70)];
    }
    
    [explainView setHidden:NO];
    
}

/**
 *  屏幕取词
 */
/*
-(void)screenTouchWord:(UITextView *)mylabel{
    int lineHeight = [@"a" sizeWithFont:mylabel.font].height;
    int LineStartlocation = 0;
    if (mylabel.tag == 2000) {
        [explainView setHidden:YES];
//        [myHighLightWord setHidden:YES];
        return;
    }
    if (![explainView isHidden]) {
        [explainView setHidden:YES];
//        [myHighLightWord setHidden:YES];
    }
    //    NSLog(@"取词:%@",mylabel.text);
    NSString * WordIFind = nil;
    UITouch *touch = [wordTouches anyObject];
    CGPoint point = [touch locationInView:mylabel];
    int tagetline = ceilf((point.y- mylabel.frame.origin.y)/lineHeight);
    CGSize maxSize = CGSizeMake(mylabel.frame.size.width-(isiPhone? 16: 18), CGFLOAT_MAX);
//    if (readRecord) {
//        point = [touch locationInView:self.myScroll];
//        if (isiPhone) {
//            tagetline = ceilf((point.y- 20)/lineHeight);
//            maxSize = CGSizeMake(260, CGFLOAT_MAX);
//        } else {
//            tagetline = ceilf((point.y- 50)/lineHeight);
//            maxSize = CGSizeMake(568, CGFLOAT_MAX);
//        }
//        
//    }
    //    NSLog(@"x:%f,y:%f",point.x,point.y);
    //    int fontSize = [[NSUserDefaults standardUserDefaults] integerForKey:@"nowValueFont"];
    //    NSLog(@"nowValueFont:%d",fontSize);
    //    UIFont *Courier = [UIFont fontWithName:@"Courier" size:fontSize];
    
    //    int numberoflines = self.frame.size.height / lineHeight;
    //    int tagetline = ceilf((point.y- mylabel.frame.origin.y)/lineHeight);
    NSString * sepratorString = @", ，。.?!:\"“”-()'‘";
    //    NSString * text = @"...idowrhu wpe gre dddd.. 'eow.ei, we u";
    NSCharacterSet * sepratorSet = [NSCharacterSet characterSetWithCharactersInString:sepratorString];
    NSArray * splitStr = [mylabel.text componentsSeparatedByCharactersInSet:sepratorSet];
    //    NSArray * splitStr = [self.text componentsSeparatedByString:@" "];
    int WordIndex = 0;
    int count = [splitStr count];
    BOOL WordFound = NO;
    NSString * string = @"";
    NSString * string2 = @"";
    
    for (int i = 0; i < count && !WordFound; i++) {
        @try {//??
            string = [string stringByAppendingString:[NSString stringWithFormat:@"%@.",[splitStr objectAtIndex:i]]];
            
            NSString * substr = [mylabel.text substringWithRange:NSMakeRange(LineStartlocation, [string length])];
            CGSize mysize = [substr sizeWithFont:mylabel.font constrainedToSize:maxSize];
            
            if (mysize.height/lineHeight == tagetline && !WordFound) {
                LineStartlocation = [string length] - [[splitStr objectAtIndex:i] length] - 1;
                for (; i < count; i++) {
                    
                    string2 = [string2 stringByAppendingString:[NSString stringWithFormat:@"%@.",[splitStr objectAtIndex:i]]];
                    NSString * substr2 = nil;
                    @try {
                        substr2 = [mylabel.text substringWithRange:NSMakeRange(LineStartlocation, [string2 length])];
                    }
                    @catch (NSException *exception) {
                        
                        return;
                    }
                    
                    
                    CGSize thissize = [substr2 sizeWithFont:mylabel.font constrainedToSize:maxSize];
                    if (thissize.height/lineHeight > 1) {
                        return;
                    }
                    
                    if (thissize.width > point.x) {
                        
                        WordIndex = i;
                        WordFound = YES;
                        break;
                    }
                    
//                    if (thissize.width > (readRecord? (![Constants isPad]? point.x-670:point.x-1636):point.x)) {
//                        
//                        WordIndex = i;
//                        WordFound = YES;
//                        break;
//                    }
                }
            }
        }
        @catch (NSException *exception) {
        }
    }
    if (WordFound) {
        WordIFind = [splitStr objectAtIndex:WordIndex];
        if ([WordIFind isEqualToString:@""] || WordIFind == nil) {//??
            return ;
        }
        CGFloat pointY = (tagetline -1 ) * lineHeight;
        CGFloat width = [[splitStr objectAtIndex:WordIndex] sizeWithFont:mylabel.font].width;
        
        NSRange Range1 = [string2 rangeOfString:[splitStr objectAtIndex:WordIndex] options:NSBackwardsSearch];
        
        
        NSString * str = [string2 substringToIndex:Range1.location];
        int i = 0;
        while ([[str substringToIndex:i] isEqual:@"."]) {
            str = [str substringFromIndex:i+1];
            i++;
            
        }
        
        CGFloat pointX = [str sizeWithFont:mylabel.font].width;
        //        if (readRecord) {
        //            pointX = [str sizeWithFont:mylabel.font].width;
        //        }
        
        //        if (wordBack) {
        //            [wordBack removeFromSuperview];
        //            wordBack = nil;
        //        }
        LocalWord *word = [LocalWord findByKey:WordIFind];
        myWord.wordId = [VOAWord findLastId] + 1;
//        nowUserId = [[[NSUserDefaults standardUserDefaults] objectForKey:@"nowUser"] integerValue];
//        myWord.userId = nowUserId;
        //        NSLog(@"%@", WordIFind);
        
        if (kNetIsExist) {
            //            NSLog(@"有网");
            [self catchWords:WordIFind];
        } else {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                kNetTest;
            });
            if (([[NSUserDefaults standardUserDefaults] boolForKey:kBePro] || [[NSUserDefaults standardUserDefaults] boolForKey:@"isVip"])  && word) {
                //        if (word) {
                //            if (word) {
                //            myWord.wordId = [VOAWord findLastId] + 1;
                myWord.key = word.key;
                myWord.audio = word.audio;
                myWord.pron = [NSString stringWithFormat:@"%@",word.pron] ;
                if (myWord.pron == nil) {
                    myWord.pron = @" ";
                }
                myWord.def = [[word.def stringByReplacingOccurrencesOfRegex:@"\\s+" withString:@""]stringByReplacingOccurrencesOfString:@"null" withString:@""];
                //                [word release];
                [self wordExistDisplay];
                //            }
            } else {
                myWord.key = WordIFind;
                myWord.audio = @"";
                myWord.pron = @" ";
                myWord.def = @"";
                [self wordNoDisplay];
            }
        }
        
        //        [self catchWords:WordIFind];
        
//        if (readRecord) {
//            [myHighLightWord setFrame:CGRectMake(pointX, pointY, width, lineHeight)];
//            [myHighLightWord setHidden:NO];
//        }else {
            [myHighLightWord setFrame:CGRectMake(pointX + 7, mylabel.frame.origin.y + pointY, width, lineHeight)];
//        }
        [myHighLightWord setAlpha:0.5];
        [myHighLightWord setHighlighted:YES];
        [myHighLightWord setHighlightedTextColor:[UIColor whiteColor]];
        [myHighLightWord setBackgroundColor:[UIColor colorWithRed:1.0/255 green:151.0/255 blue:211.0/255 alpha:1]];
//        if (readRecord) {
//            [mylabel addSubview:myHighLightWord];
//        }else {
//            [textScroll addSubview:myHighLightWord];
//        }
        
        //        [myHighLightWord setHidden:NO];
        
        //        wordBack = [[UIView alloc] initWithFrame:CGRectMake(pointX, pointY, width, lineHeight)];
        //        wordBack.backgroundColor = [UIColor colorWithRed:1.0 green:0.651 blue:0.098 alpha:0.5];
        //        [self insertSubview:wordBack atIndex:0];
        //        [self GetExplain:WordIFind];
    }
}*/

/**
 *  联网查词
 */
- (void)catchWords:(NSString *) word
{
    //    NSString *url = [NSString stringWithFormat:@"http://word.iyuba.com/words/apiWord.jsp?q=%@",word];
    //    ASIHTTPRequest * request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
    //    request.delegate = self;
    //    [request setUsername:word];
    //    [request startAsynchronous];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://word.iyuba.com/words/apiWord.jsp?q=%@",[ROUtility encodeString:word urlEncode:NSUTF8StringEncoding]]];
    ASIHTTPRequest * request = [[ASIHTTPRequest alloc] initWithURL:url];
    request.delegate = self;
    [request setUsername:word];
    [request startAsynchronous];
}

//- (void)setModel:(IntroModel*)model {
//    [titleLabel setText:model.titleText];
//    [descriptionLabel setText:model.descriptionText];
//}

/**
 *  查词成功
 */
- (void)requestFinished:(ASIHTTPRequest *)request {
    kNetEnable;
    if ([request.username isEqualToString:@"catchnet"]) {
        //        NSLog(@"有网络");
        //        isExisitNet = YES;
        return;
    }
    NSData *myData = [request responseData];
    DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:myData options:0 error:nil];;
    [myWord init];
    int result = 0;
    NSArray *items = [doc nodesForXPath:@"data" error:nil];
    if (items) {
        for (DDXMLElement *obj in items) {
            NSMutableArray *eng = [[NSMutableArray alloc] init];
            NSMutableArray *chi = [[NSMutableArray alloc] init];
            myWord.wordId = [VOAWord findLastId]+1;
            myWord.checks = 0;
            myWord.remember = 0;
//            myWord.userId = nowUserId;
            result = [[obj elementForName:@"result"] stringValue].intValue;
            if (result) {
                myWord.key = [[obj elementForName:@"key"] stringValue];
                myWord.audio = [[obj elementForName:@"audio"] stringValue];
                myWord.pron = [[obj elementForName:@"pron"] stringValue];
                if (myWord.pron == nil) {
                    myWord.pron = @" ";
                }
                myWord.def = [[[[obj elementForName:@"def"] stringValue] stringByReplacingOccurrencesOfRegex:@"\\s+" withString:@""]stringByReplacingOccurrencesOfString:@"null" withString:@""];
                NSArray *itemsOne = [doc nodesForXPath:@"data/sent" error:nil];
                if (itemsOne) {
                    //                        NSLog(@"4");
                    for (DDXMLElement *objOne in itemsOne) {
                        NSString *orig = [[[[[objOne elementForName:@"orig"] stringValue]stringByReplacingOccurrencesOfString:@"<em>" withString:@""] stringByReplacingOccurrencesOfString:@"</em>" withString:@""] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                        //                        NSString * decodedText = [[NSString alloc] initWithUTF8String:[_feedback.text UTF8String]];
                        [eng addObject:orig.URLDecodedString];
                        NSString *trans = [[[objOne elementForName:@"trans"] stringValue] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                        [chi addObject:trans];
                        //                            NSLog(@"orig:%@", orig);
                        //                            NSLog(@"trans:%@", trans);
                    }
                }
                myWord.engArray = eng;
                
                myWord.chnArray = chi;
                
                [self wordExistDisplay];
                
            }else
            {
                [myWord init];
                LocalWord *word = [LocalWord findByKey:request.username];
                myWord.wordId = [VOAWord findLastId] + 1;
                if (([[NSUserDefaults standardUserDefaults] boolForKey:kBePro] || [[NSUserDefaults standardUserDefaults] boolForKey:@"isVip"])  && word) {
                    //        if (word) {
                    //            if (word) {
                    //            myWord.wordId = [VOAWord findLastId] + 1;
                    myWord.key = word.key;
                    myWord.audio = word.audio;
                    myWord.pron = [NSString stringWithFormat:@"%@",word.pron] ;
                    if (myWord.pron == nil) {
                        myWord.pron = @" ";
                    }
                    myWord.def = [[word.def stringByReplacingOccurrencesOfRegex:@"\\s+" withString:@""]stringByReplacingOccurrencesOfString:@"null" withString:@""];
                    //                    [word release];
                    [self wordExistDisplay];
                    //            }
                } else {
                    myWord.key = request.username;
                    myWord.audio = @"";
                    myWord.pron = @" ";
                    myWord.def = @"";
                    [self wordNoDisplay];
                }
            }
            eng = nil;
            chi = nil;
        }
    }
}

/**
 *  查词出错
 */
- (void)requestFailed:(ASIHTTPRequest *)request
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        kNetTest;
    });
    if ([request.username isEqualToString:@"catchnet"]) {
        //        NSLog(@"有网络");
        //        isExisitNet = NO;
        return;
    }
    [myWord init];
    LocalWord *word = [LocalWord findByKey:request.username];
    myWord.wordId = [VOAWord findLastId] + 1;
    if (([[NSUserDefaults standardUserDefaults] boolForKey:kBePro] || [[NSUserDefaults standardUserDefaults] boolForKey:@"isVip"])  && word) {
        //        if (word) {
        //            if (word) {
        //            myWord.wordId = [VOAWord findLastId] + 1;
        myWord.key = word.key;
        myWord.audio = word.audio;
        myWord.pron = [NSString stringWithFormat:@"%@",word.pron] ;
        if (myWord.pron == nil) {
            myWord.pron = @" ";
        }
        myWord.def = [[word.def stringByReplacingOccurrencesOfRegex:@"\\s+" withString:@""]stringByReplacingOccurrencesOfString:@"null" withString:@""];
        //        [word release];
        [self wordExistDisplay];
        //            }
    } else {
        myWord.key = request.username;
        myWord.audio = @"";
        myWord.pron = @" ";
        myWord.def = @"";
        [self wordNoDisplay];
    }
}

@end
