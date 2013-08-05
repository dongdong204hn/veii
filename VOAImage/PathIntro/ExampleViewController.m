#import "ExampleViewController.h"
#import "IASKAppSettingsViewController.h"
#import "VOAView.h"
#import "FeedbackViewController.h"
#import "LogController.h"

@implementation ExampleViewController
@synthesize sharedSingleQueue;

- (id)init
{
    self = [super initWithNibName:nil bundle:nil];
    self.wantsFullScreenLayout = YES;
    self.modalPresentationStyle = UIModalPresentationFullScreen;
    return self;
}

- (void) loadView {
    [super loadView];
    
//    IntroModel *model1 = [[IntroModel alloc] initWithTitle:@"Example 1" description:@"Hi, my name is Dmitry" image:@"20130501_1.jpg"];
/*        IntroModel *model1 = [[IntroModel alloc] initWithTitle:@"Example 1" description:@"Hi, my name is Dmitry" image:@"http://static.iyuba.com/images/voa/519.jpg"];
    IntroModel *model2 = [[IntroModel alloc] initWithTitle:@"Example 2" description:@"Several sample texts in Old, Middle, Early Modern, and Modern English are provided here for practice, reference, and reading." image:@"http://static.iyuba.com/images/voa/519.jpg"];
    
    IntroModel *model3 = [[IntroModel alloc] initWithTitle:@"Example 3" description:@"The Tempest is the first play in the First Folio edition (see the signature) even though it is a later play (namely 1610) than Hamlet (1600), for example. The first page is reproduced here." image:@"20130501_3.jpg"];
    
    IntroModel *model4 = [[IntroModel alloc] initWithTitle:@"Example 4" description:@"4444444444." image:@"20130501_4.jpg"];
    
    IntroModel *model5 = [[IntroModel alloc] initWithTitle:@"Example 5" description:@"5555555555" image:@"20130501_5.jpg"];
    
    IntroModel *model6 = [[IntroModel alloc] initWithTitle:@"Example 6" description:@"5555555555" image:@"20130501_6.jpg"];
    
    myIntroControl = [[IntroControll alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) pages:@[model1, model2, model3, model4, model5, model6]];*/
    
    [self catchIntro];
    
    myVoas = [[NSMutableArray alloc] init];
    
    [self initIntroView];
    
    
    
//    self.view = [[IntroControll alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) pages:@[model1, model2, model3, model4, model5]];
}

- (void)initIntroView {
    isSelectList = NO;
    listVoaid = 0;
    
    [myVoas removeAllObjects];
    
    offset = [VOAView findNew:0 newVoas:myVoas];
    
    netVoaid = [(VOAView *)[myVoas lastObject] voaid];
    
    myIntroControl = [[IntroControll alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) pages:myVoas];
    
    myIntroControl.topView.myDelegate = self;
    myIntroControl.bottomView.myDelegate = self;
    [myIntroControl setDelegate:self];
    self.view = myIntroControl;
}

-(BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
    kNetTest;
    //start timer
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"imgAutoScroll"]) {
        if (!timer || ![timer isValid]) {
            timer =  [NSTimer scheduledTimerWithTimeInterval:kAutoScroll
                                                      target:self
                                                    selector:@selector(imgScroll)
                                                    userInfo:nil
                                                     repeats:YES];
        }
    } else {
        if (timer && [timer isValid]) {
            [timer invalidate];
        }
    }
}

- (void)imgScroll {
    [myIntroControl tick];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    downMoreView = NO;
//    titleIndex = 0;
    titleTotal = 0;
    isNewComm = NO;
    
    
//    [[UIApplication sharedApplication].keyWindow addSubview:[ExplainView sharedExplainView]];
    
    //    [self catchIntro];
    
    [self loadPlaySetting];

//    [myIntroControl tick];
//    
//    [myIntroControl.scrollView setContentOffset:CGPointMake(self.view.frame.size.width, 0) animated:YES];
//    [myIntroControl.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
//    [myIntroControl.scrollView scrollRectToVisible:CGRectMake(0, 0, 0, 0) animated:NO];
}

/**
 *  init play and record settings
 */
- (void) loadPlaySetting {
    AudioSessionInitialize (NULL, NULL, NULL, NULL);
//    OSStatus status = AudioSessionAddPropertyListener(
//                                                      kAudioSessionProperty_AudioRouteChange,
//                                                      audioRouteChangeListenerCallback,self);
//    if(status == 0){}
    
    //对播放和录音的一些属性设置
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone || UIUserInterfaceIdiomPad)
    {
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        NSError *error;
        if ([audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:&error])
        {
            if ([audioSession setActive:YES error:&error])
            {
                //        AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
            }
            else
            {
                NSLog(@"Failed to set audio session category: %@", error);
            }
        }
        else
        {
            NSLog(@"Failed to set audio session category: %@", error);
        }
        UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
        AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,sizeof(audioRouteOverride),&audioRouteOverride);
    }
    audioRecoder = [[CL_AudioRecorder alloc] initWithFinishRecordingBlock:^(CL_AudioRecorder *recorder, BOOL success) {
    } encodeErrorRecordingBlock:^(CL_AudioRecorder *recorder, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
    } receivedRecordingBlock:^(CL_AudioRecorder *recorder, float peakPower, float averagePower, float currentTime) {
        NSLog(@"%f,%f,%f",peakPower,averagePower,currentTime);
    }];
    
    //此种模式下无法播放的同时录音
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    [[AVAudioSession sharedInstance] setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom Method
/**
 *  获取下载队列
 */
- (NSOperationQueue *)sharedQueue
{
    //    static NSOperationQueue *sharedSingleQueue;
    
    @synchronized(self)
    {
        if (!sharedSingleQueue){
            sharedSingleQueue = [[NSOperationQueue alloc] init];
            [sharedSingleQueue setMaxConcurrentOperationCount:1];
        }
        return sharedSingleQueue;
    }
}

//- (IntroModel *)catchIntro:(NSInteger)index {
////    NSLog(@"111");
//    IntroModel *model = [[IntroModel alloc] initWithTitle:[NSString stringWithFormat:@"Example %d", index] description:[NSString stringWithFormat:@"%d%d", index, index] image:[NSString stringWithFormat:@"20130501_%d.jpg", index]];
//    return model;
//}

#pragma mark - IntroControllDelegate
- (VOAView *)catchVoa:(NSInteger)index {
    //    NSLog(@"111");
    return (VOAView *)[myVoas objectAtIndex:index];
}

- (void)netLastVoa {
    if (kNetIsExist) {
        NSInteger lastVoaid = [VOATitle catchVoaidBelow:[(VOAView *)[myVoas lastObject] voaid]];
        //        while (lastVoaid >= netVoaid) {
        //            lastVoaid--;
        //        }
        //        addNum = 0;
        if (lastVoaid > 0 && lastVoaid < netVoaid && ![VOAView isVoaidExist:lastVoaid]) {
            [self catchTenTextByVoaid:lastVoaid];
        }
    }
}

- (NSInteger)catchLastVoa {
//    if (kNetIsExist) {
//        NSInteger lastVoaid = [VOATitle catchVoaidBelow:[(VOAView *)[myVoas lastObject] voaid]];
////        while (lastVoaid >= netVoaid) {
////            lastVoaid--;
////        }
////        addNum = 0;
//        if (lastVoaid > 0 && lastVoaid < netVoaid) {
//            [self catchTenTextByVoaid:lastVoaid];
//        }
//    }
    NSInteger addNumNow = isSelectList? (islocal? [VOAView findNewBelowVoaidParaid:listVoa.voaid paraid:listVoa.paraid myArray:myVoas offset:offset]: [VOAView findNewBelowVoaid:listVoaid myArray:myVoas offset:offset]):[VOAView findNew:offset newVoas:myVoas];
    offset += addNumNow;
//    NSLog(@"222222done:%d", addNumNow);
//    if (addNum > 0) {
//        [myVoas removeAllObjects];
//        myVoas = [NSMutableArray arrayWithArray:voas];
//    }
    return addNumNow;
}

- (void)flushIntro {
    isSelectList = NO;
    if (kNetIsExist) {
        NSInteger firstVoaid = [VOATitle catchVoaidBelow:100000000];
        if ([(VOAView *)[myVoas objectAtIndex:0] voaid] < firstVoaid) {
            [self catchScrollTextByVoaid:firstVoaid];
        } else {
            //            [myIntroControl scrollViewToImgIndex:1];
            //            [myIntroControl scrollViewtoTop];
            [myVoas removeAllObjects];
            
            offset = [VOAView findNew:0 newVoas:myVoas];
            
            netVoaid = [(VOAView *)[myVoas lastObject] voaid];
            
            [myIntroControl scrollInitIntro:self.view.frame];
        }
    } else {
        kNetTest;
        [myVoas removeAllObjects];
        
        offset = [VOAView findNew:0 newVoas:myVoas];
        
        netVoaid = [(VOAView *)[myVoas lastObject] voaid];
        
        [myIntroControl scrollInitIntro:self.view.frame];
        //        [myIntroControl scrollViewToImgIndex:1];
    }
    //    [self initIntroView];
}

//- (void)flushSound {
//    VOAView *nowVoa = [myVoas objectAtIndex:myIntroControl.currentPhotoNum];
//    [myIntroControl.bottomView.userImg setImageWithURL:[NSURL URLWithString:nowVoa.userImgUrl]];
//    [myIntroControl.bottomView.userName setText:nowVoa.userName];
//}

/**
 *  定时自动消失的提示框的最后执行消失功能的函数
 */
-(void)c
{
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}

/**
 *  定时自动隐藏句子标签的函数
 */
-(void)cSenLabel
{
    [commentView.myAudioView setHidden:YES];
}

#pragma mark - Http connect
//- (void)catchIntroOneByPageNum:(NSInteger)pageNum{
//    if (titleTotal > 0 && titleIndex >= titleTotal) {
//        return;
//    } else {
//        NSString *url = [NSString stringWithFormat:@"http://voa.iyuba.com/voa/titleApi.jsp?maxid=0&type=iOS&format=xml&pages=%d&pageNum=%d&parentID=300", titleIndex+1, pageNum];
//        NSOperationQueue *myQueue = [self sharedQueue];
//        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
//        [request setDelegate:self];
//        [request setUsername:@"title"];
//        //    [request setDidStartSelector:@selector(requestMyStarted:)];
//        [request setDidFinishSelector:@selector(requestDone:)];
//        [request setDidFailSelector:@selector(requestWentWrong:)];
//        [myQueue addOperation:request];
//    }
//}

/*
- (void)catchIntroNew{
    NSString *url = [NSString stringWithFormat:@"http://voa.iyuba.com/voa/titleApi.jsp?maxid=0&type=iOS&format=xml&pages=1&pageNum=1&parentID=300"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    [request setDelegate:self];
    [request setUsername:@"titleNew"];
    [request setTimeOutSeconds:10];
    [request startSynchronous];
}
 
 - (void)catchIntroOneByPages:(NSInteger)pages{
 //    if (titleTotal > 0 && titleIndex >= titleTotal) {
 //        return;
 //    } else {
 NSString *url = [NSString stringWithFormat:@"http://voa.iyuba.com/voa/titleApi.jsp?maxid=0&type=iOS&format=xml&pages=0&pageNum=1&parentID=300"];
 NSOperationQueue *myQueue = [self sharedQueue];
 ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
 [request setDelegate:self];
 [request setUsername:@"title"];
 //    [request setDidStartSelector:@selector(requestMyStarted:)];
 [request setDidFinishSelector:@selector(requestDone:)];
 [request setDidFailSelector:@selector(requestWentWrong:)];
 [myQueue addOperation:request];
 //    }
 }
 
 - (void)catchFirstIntro {
 //    if (titleTotal > 0 && titleIndex >= titleTotal) {
 //        return;
 //    } else {
 NSString *url = [NSString stringWithFormat:@"http://voa.iyuba.com/voa/titleApi.jsp?maxid=0&type=iOS&format=xml&pages=0&pageNum=1&parentID=300"];
 NSOperationQueue *myQueue = [self sharedQueue];
 ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
 [request setDelegate:self];
 [request setUsername:@"first"];
 //    [request setDidStartSelector:@selector(requestMyStarted:)];
 [request setDidFinishSelector:@selector(requestDone:)];
 [request setDidFailSelector:@selector(requestWentWrong:)];
 [myQueue addOperation:request];
 //    }
 }

*/


- (void)sendComment:(NSInteger)commType {
    VOAView *nowVoa = [myVoas objectAtIndex:myIntroControl.currentPhotoNum];
    if (kNetIsExist) {
        NSInteger uid = [[NSUserDefaults standardUserDefaults] integerForKey:@"nowUser"];
        NSString *url;
        //    url = [NSString stringWithFormat:@"http://172.16.94.220:8081/voa/UnicomApi?platform=ios&format=xml&protocol=60002&userid=%i&voaid=%i&shuoshuotype=1",uid, voa._voaid];
        //        url = [NSString stringWithFormat:@"http://voa.iyuba.com/voa/UnicomApi?"];
        if (commentView.isResponse) {
            url = [NSString stringWithFormat:@"http://voa.iyuba.com/voa/UnicomApi?parentID=300&toId=%i", [[commentView.commArray objectAtIndex:[commentView.textView tag]*9] integerValue]];
        } else {
            url = [NSString stringWithFormat:@"http://voa.iyuba.com/voa/UnicomApi?parentID=300&"];
        }
        
        ASIFormDataRequest * request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
        request.delegate = self;
        [request setPostValue:@"ios" forKey:@"platform"];
        [request setPostValue:@"xml" forKey:@"format"];
        [request setPostValue:@"60002" forKey:@"protocol"];
        [request setPostValue:[NSString stringWithFormat:@"%d", uid] forKey:@"userid"];
        [request setPostValue:[NSString stringWithFormat:@"%d", nowVoa.voaid] forKey:@"voaid"];
        [request setPostValue:[NSString stringWithFormat:@"%d", nowVoa.paraid] forKey:@"paraid"];
//        [request setPostValue:[NSString stringWithFormat:@"%d", nowVoa.paraid] forKey:@"paraid"];
        [request setPostValue:[NSString stringWithFormat:@"%d", commType] forKey:@"shuoshuotype"];
        //    NSData* audioData = [audioStr dataUsingEncoding:NSUTF8StringEncoding];
        if (commType == 0) {
            [request setPostValue:[[commentView.textView text] URLEncodedString] forKey:@"content"];
//            NSLog(@"textView:%@", [commentView.textView text]);
        } else {
            NSString *recordAudioFullPath = [kRecorderDirectory stringByAppendingPathComponent:
                                             [NSString stringWithFormat:kRecordFile]];
            NSData* audioData = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:recordAudioFullPath]];
            [request addData:audioData withFileName:@"record.aac" andContentType:@"multipart/form-data" forKey:@"content"];
        }
        NSLog(@"url:%@platform=ios&format=xml&protocol=60002&userid=%d&voaid=%d&paraid=%d&shuoshuotype=%d&content=%@", request.url, uid, nowVoa.voaid, nowVoa.paraid, commType, [[commentView.textView text] URLEncodedString]);
        //        NSLog(@"url:%@ %d %d", request.url, uid, voa._voaid);
        [request setUsername:@"send"];
        //    [request setRequestMethod:@"POST"];
        [request startAsynchronous];
    } else {
        kNetTest;
    }
}

- (void)sendAgree:(NSInteger)commId  {
    NSInteger uid = [[NSUserDefaults standardUserDefaults] integerForKey:@"nowUser"];
    if (uid>0) {
        VOAView *nowVoa = [myVoas objectAtIndex:myIntroControl.currentPhotoNum];
        if (kNetIsExist) {
            NSString *url = [NSString stringWithFormat:@"http://voa.iyuba.com/voa/UnicomApi?protocol=61001&format=xml&id=%d&parentID=300&paraid=%d&uid=%d", commId, nowVoa.paraid, uid];
            ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
            //        [commentView.sendBtn setUserInteractionEnabled:NO];
            NSLog(@"url:%@", url);
            request.delegate = self;
            [request setUsername:@"agree"];
            [request startSynchronous];
        } else {
            isEvaluate = NO;
            kNetTest;
        }
    } else {
        isEvaluate = NO;
        LogController *myLog = [[LogController alloc]init];
        [self presentModalViewController:myLog animated:YES];
        //        [myLog release];
    }
}

- (void)sendAgainst:(NSInteger)commId  {
    NSInteger uid = [[NSUserDefaults standardUserDefaults] integerForKey:@"nowUser"];
    if (uid>0) {
        VOAView *nowVoa = [myVoas objectAtIndex:myIntroControl.currentPhotoNum];
        if (kNetIsExist) {
            NSString *url = [NSString stringWithFormat:@"http://voa.iyuba.com/voa/UnicomApi?protocol=61002&format=xml&id=%d&parentID=300&paraid=%d&uid=%d", commId, nowVoa.paraid,uid];
            ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
            //        [commentView.sendBtn setUserInteractionEnabled:NO];
            //        NSLog(@"url:%@", url);
            request.delegate = self;
            [request setUsername:@"against"];
            [request startSynchronous];
        } else {
            kNetTest;
        }
    } else {
        LogController *myLog = [[LogController alloc]init];
        [self presentModalViewController:myLog animated:YES];
        //        [myLog release];
    }
}

- (void)catchIntro{
    NSString *url = [NSString stringWithFormat:@"http://voa.iyuba.com/voa/titleApi.jsp?maxid=%d&type=iOS&format=xml&pages=1&pageNum=1000&parentID=300", [VOATitle findLastId]];
    NSLog(@"url:%@", url);
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    [request setDelegate:self];
    [request setUsername:@"title"];
    [request setTimeOutSeconds:10];
    [request startAsynchronous];
}

//- (void)catchTextByVoaid:(NSInteger)voaid{
//    NSString *url = [NSString stringWithFormat:@"http://voa.iyuba.com/voa/textApi.jsp?voaid=%d&format=xml",voaid];
//    NSOperationQueue *myQueue = [self sharedQueue];
//    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
//    [request setDelegate:self];
//    [request setUsername:@"text"];
//    [request setTag:voaid];
//    //    [request setDidStartSelector:@selector(requestMyStarted:)];
//    [request setDidFinishSelector:@selector(requestDone:)];
//    [request setDidFailSelector:@selector(requestWentWrong:)];
//    [myQueue addOperation:request];
//}

- (void)catchTenTextByVoaid:(NSInteger)voaid{
    NSString *url = [NSString stringWithFormat:@"http://voa.iyuba.com/voa/textApi.jsp?voaid=%d&format=xml&parentID=300",voaid];
    NSOperationQueue *myQueue = [self sharedQueue];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    [request setDelegate:self];
    [request setUsername:@"tenText"];
    [request setTag:voaid];
    //    [request setDidStartSelector:@selector(requestMyStarted:)];
    [request setDidFinishSelector:@selector(requestDone:)];
    [request setDidFailSelector:@selector(requestWentWrong:)];
    [myQueue addOperation:request];
}

- (void)catchSyTextByVoaid:(NSInteger)voaid{
    NSString *url = [NSString stringWithFormat:@"http://voa.iyuba.com/voa/textApi.jsp?voaid=%d&format=xml&parentID=300",voaid];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    [request setDelegate:self];
    [request setUsername:@"firstText"];
    [request setTag:voaid];
    [request setTimeOutSeconds:10];
    [request startSynchronous];
}

- (void)catchScrollTextByVoaid:(NSInteger)voaid{
    NSString *url = [NSString stringWithFormat:@"http://voa.iyuba.com/voa/textApi.jsp?voaid=%d&format=xml&parentID=300",voaid];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    [request setDelegate:self];
    [request setUsername:@"scrollText"];
    [request setTag:voaid];
    [request setTimeOutSeconds:10];
    [request startAsynchronous];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    if ([request.username isEqualToString:@"agree"] || [request.username isEqualToString:@"against"]) {
        isEvaluate = NO;
    }
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    kNetEnable;
    NSData *myData = [request responseData];
    DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:myData options:0 error:nil];
    if ([request.username isEqualToString:@"title" ]) {
        NSArray *items = [doc nodesForXPath:@"data" error:nil];
        if (items) {
            for (DDXMLElement *obj in items) {
                titleTotal = [[[obj elementForName:@"total"] stringValue] integerValue] ;
                NSLog(@"total:%d",titleTotal);
            }
        }
        items = [doc nodesForXPath:@"data/voatitle" error:nil];
        if (items) {
            //            BOOL flushList = NO;
            for (DDXMLElement *obj in items) {
                VOATitle *voaTitle = [[VOATitle alloc] init];
                voaTitle.voaid = [[[obj elementForName:@"voaid"] stringValue] integerValue] ;
                voaTitle.creatTime = [[obj elementForName:@"CreatTime"] stringValue];
                voaTitle.pic = [[obj elementForName:@"Pic"] stringValue];
                voaTitle.descCn = [[obj elementForName:@"DescCn"] stringValue];
                [voaTitle insert];
//                titleIndex++;
//                [self catchSyTextByVoaid:myVoaid];
            }
        }
    }
//    else if ([request.username isEqualToString:@"text" ]) {
//        NSArray *items = [doc nodesForXPath:@"data/voatext" error:nil];
//        if (items) {
//            BOOL flushList = NO;
//            for (DDXMLElement *obj in items) {
//                VOAView *newVoa = [[VOAView alloc] init];
//                newVoa.voaid = request.tag;
//                newVoa.paraid = [[[obj elementForName:@"ParaId"] stringValue] integerValue];
//                newVoa.pic = [NSString stringWithFormat:@"http://static.iyuba.com/images/voapic/%d/%d_%d.jpg", newVoa.voaid/100, newVoa.voaid, newVoa.paraid];
//                newVoa.descCn = [[[obj elementForName:@"ImgWords"] stringValue] stringByReplacingOccurrencesOfString:@"\"" withString:@"”"];
//                newVoa.title = [[[obj elementForName:@"Sentence"] stringValue]stringByReplacingOccurrencesOfString:@"\"" withString:@"”"];;
//                newVoa.title_Cn = [[[obj elementForName:@"sentence_cn"] stringValue] isEqualToString: @" null"] ? nil :[[obj elementForName:@"sentence_cn"] stringValue];
//                newVoa.creatTime = [VOATitle catchCreatTimeBy:request.tag];
//                //                newVoa._sound = [[obj elementForName:@"Sound"] stringValue];
//                //                newVoa._url = [[obj elementForName:@"Url"] stringValue];
//                //                newVoa._pic = [[obj elementForName:@"Pic"] stringValue];
//                //                newVoa._creatTime = [[obj elementForName:@"CreatTime"] stringValue];
//                //                newVoa._publishTime = [[[obj elementForName:@"PublishTime"] stringValue] isEqualToString:@" null"] ? nil :[[obj elementForName:@"PublishTime"] stringValue];
//                //                newVoa._readCount = [[obj elementForName:@"ReadCount"] stringValue];
//                //                newVoa._hotFlg = [[obj elementForName:@"HotFlg"] stringValue];
//                //                newVoa._isRead = @"0";
//                if ([VOAView isExist:newVoa.voaid paraid:newVoa.paraid] == NO) {
//                    [newVoa insert];
//                    //                    [self catchDetails:newVoa];
//                    flushList = YES;
//                    //                    NSLog(@"插入%d成功",newVoa._voaid);
//                }
//                //                [newVoa release],newVoa = nil;
//            }
//            //            [self catchIntroOneByPageNum:1];
//            //            NSMutableArray *addArray = [[NSMutableArray alloc]init];
//            //            if (category == 0) {
//            //                addArray = [VOAView findNew:10*(pageNum-1) newVoas:addArray];
//            //            } else if (category<11) {
//            //                addArray = [VOAView findNewByCategory:10*(pageNum-1) category:category myArray:addArray];
//            //            } else {
//            //
//            //            }
//            //            //            addArray = [VOAView findNew:10*(pageNum-1) newVoas:addArray];
//            //            pageNum ++;
//            //            addNum = 0;
//            //            for (VOAView *voaOne in addArray) {
//            //                [self.voasArray addObject:voaOne];
//            //                addNum++;
//            //            }
//            //            [addArray release],addArray = nil;
//            //            [self.voasTableView reloadData];
//        }
//        
//    }
    else if ([request.username isEqualToString:@"firstText" ]) {
        NSArray *items = [doc nodesForXPath:@"data/voatext" error:nil];
        if (items) {
            BOOL flushList = NO;
//            NSInteger addTemp = 0;
            for (DDXMLElement *obj in items) {
                VOAView *newVoa = [[VOAView alloc] init];
                newVoa.voaid = request.tag;
                newVoa.paraid = [[[obj elementForName:@"ParaId"] stringValue] integerValue];
                newVoa.pic = [NSString stringWithFormat:@"http://static.iyuba.com/images/voapic/%d/%d_%d.jpg", newVoa.voaid/100, newVoa.voaid, newVoa.paraid];
                newVoa.descCn = [[[obj elementForName:@"ImgWords"] stringValue] stringByReplacingOccurrencesOfString:@"\"" withString:@"”"];
                newVoa.title = [[[obj elementForName:@"Sentence"] stringValue]stringByReplacingOccurrencesOfString:@"\"" withString:@"”"];;
                newVoa.title_Cn = [[[obj elementForName:@"sentence_cn"] stringValue] isEqualToString: @" null"] ? nil :[[obj elementForName:@"sentence_cn"] stringValue];
                newVoa.creatTime = [VOATitle catchCreatTimeBy:request.tag];
                newVoa.userid = [[[obj elementForName:@"agreeUserId"] stringValue] integerValue];
                if (newVoa.userid > 0) {
                    newVoa.userName = [[obj elementForName:@"agreeUserName"] stringValue];
                    newVoa.userImgUrl = [[obj elementForName:@"agreeImgsrc"] stringValue];
                    newVoa.sound =  [NSString stringWithFormat:@"http://voa.iyuba.com/voa/%@", [[obj elementForName:@"agreeShuoShuo"] stringValue].URLDecodedString];
                }
                
                if ([VOAView isExist:newVoa.voaid paraid:newVoa.paraid] == NO) {
                    [newVoa insert];
                    //                    [self catchDetails:newVoa];
                    flushList = YES;
                    //                    NSLog(@"插入%d成功",newVoa._voaid);
                } else {
                    [newVoa updateByVoaid];
                }
//                [myVoas insertObject:newVoa atIndex:addTemp++];
            }
            
//            [self initIntroView];

        }
        
    }
    else if ([request.username isEqualToString:@"scrollText" ]) {
        NSArray *items = [doc nodesForXPath:@"data/voatext" error:nil];
        if (items) {
            BOOL flushList = NO;
//            NSInteger addTemp = 0;
            for (DDXMLElement *obj in items) {
                VOAView *newVoa = [[VOAView alloc] init];
                newVoa.voaid = request.tag;
                newVoa.paraid = [[[obj elementForName:@"ParaId"] stringValue] integerValue];
                newVoa.pic = [NSString stringWithFormat:@"http://static.iyuba.com/images/voapic/%d/%d_%d.jpg", newVoa.voaid/100, newVoa.voaid, newVoa.paraid];
                newVoa.descCn = [[[obj elementForName:@"ImgWords"] stringValue] stringByReplacingOccurrencesOfString:@"\"" withString:@"”"];
                newVoa.title = [[[obj elementForName:@"Sentence"] stringValue]stringByReplacingOccurrencesOfString:@"\"" withString:@"”"];;
                newVoa.title_Cn = [[[obj elementForName:@"sentence_cn"] stringValue] isEqualToString: @" null"] ? nil :[[obj elementForName:@"sentence_cn"] stringValue];
                newVoa.creatTime = [VOATitle catchCreatTimeBy:request.tag];
                newVoa.userid = [[[obj elementForName:@"agreeUserId"] stringValue] integerValue];
                newVoa.userName = [[obj elementForName:@"agreeUserName"] stringValue];
                newVoa.userImgUrl = [[obj elementForName:@"agreeImgsrc"] stringValue];
                newVoa.sound =  [NSString stringWithFormat:@"http://voa.iyuba.com/voa/%@", [[obj elementForName:@"agreeShuoShuo"] stringValue].URLDecodedString];
                
                if ([VOAView isExist:newVoa.voaid paraid:newVoa.paraid] == NO) {
                    [newVoa insert];
                    //                    [self catchDetails:newVoa];
                    flushList = YES;
                    //                    NSLog(@"插入%d成功",newVoa._voaid);
                } else {
                    [newVoa updateByVoaid];
                }
//                [myVoas insertObject:newVoa atIndex:addTemp++];
            }
            
            [myVoas removeAllObjects];
            
            offset = [VOAView findNew:0 newVoas:myVoas];
            
            netVoaid = [(VOAView *)[myVoas lastObject] voaid];
            
            [myIntroControl scrollInitIntro:self.view.frame];
            
            //            [self initIntroView];
            
        }
        
    } else if ([request.username isEqualToString:@"comment" ]) {
        /////解析
        [commentView.sendBtn setUserInteractionEnabled:YES];
        
        NSArray *items = [doc nodesForXPath:@"data" error:nil];
        if (items) {
            for (DDXMLElement *obj in items) {
                int resultCode = [[[obj elementForName:@"ResultCode"] stringValue] integerValue] ;
                if (resultCode == 510) {
                    [commentView.commArray removeAllObjects];
                } else {
                    commentView.nowPage = [[[obj elementForName:@"PageNumber"] stringValue] integerValue] ;
                    
                    //                NSLog(@"pageNumber:%d",pageNumber);
                    
                    
                    if (commentView.nowPage == 1) {
                        [commentView.commArray removeAllObjects];
                        //                    NSInteger commcount = [[[obj elementForName:@"counts"] stringValue] integerValue] ;
                        commentView.totalPage = [[[obj elementForName:@"TotalPage"] stringValue] integerValue] ;
                        //                    NSLog(@"commcount:%d",commcount);
                        //                    commArray = [[NSMutableArray alloc]initWithCapacity:4*commcount];
                        //                    struct comment comms[commNumber];
                    }
                    items = [doc nodesForXPath:@"data/Row" error:nil];
                    if (items) {
                        for (DDXMLElement *obj in items) {
                            [commentView.commArray addObject:[[obj elementForName:@"id"] stringValue]];
                            [commentView.commArray addObject:[[obj elementForName:@"Userid"] stringValue]];
                            [commentView.commArray addObject:[[obj elementForName:@"UserName"] stringValue]];
                            [commentView.commArray addObject:[[obj elementForName:@"ImgSrc"] stringValue]];
                            [commentView.commArray addObject:[[obj elementForName:@"ShuoShuoType"] stringValue]];
                            [commentView.commArray addObject: [[obj elementForName:@"ShuoShuoType"] stringValue].intValue == 1 ?[NSString stringWithFormat:@"http://voa.iyuba.com/voa/%@", [[obj elementForName:@"ShuoShuo"] stringValue].URLDecodedString] : [[obj elementForName:@"ShuoShuo"] stringValue].URLDecodedString];
                            [commentView.commArray addObject:[[obj elementForName:@"agreeCount"] stringValue]];
                            [commentView.commArray addObject:[[obj elementForName:@"againstCount"] stringValue]];
                            [commentView.commArray addObject:[[obj elementForName:@"CreateDate"] stringValue]];
                            
                            
                        }
                    }
                    if ([commentView.commArray count]/9 < 4) {
                        [commentView.commTableView setFrame:CGRectMake(0, 0, 320, [commentView.commArray count]/9*kCommTableHeightPh)];
                        //                NSLog(@"表高:%f", [commArray count]/4*kCommTableHeightPh);
                    }
                    else {
                        [commentView.commTableView setFrame:CGRectMake(0, 0, 320, 228)];
                    }
                }
                
            }
        }
        [commentView.commTableView reloadData];
        if (isNewComm) {
            [commentView.commTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            isNewComm = NO;
        }
        //        int i = 0;
        //        NSLog(@"count：%i",[commArray count]);
        //        for (; i< [commArray count]; i++) {
        //            NSLog(@"%i:%@",i,[commArray objectAtIndex:i]);
        //        }
    } else if ([request.username isEqualToString:@"send" ]) {
        //        [commArray removeAllObjects];
        NSArray *items = [doc nodesForXPath:@"data" error:nil];
        if (items) {
            for (DDXMLElement *obj in items) {
                int resultCode = [[[obj elementForName:@"ResultCode"] stringValue] integerValue] ;
                NSLog(@"resultCode:%d", resultCode);
            }
        }
        isNewComm = YES;
        //        NSLog(@"1111");
        [commentView.textView setText:@""];
        commentView.isResponse = NO;
        [self catchComments:1];
    } else if ([request.username isEqualToString:@"agree" ]) {
        //        [commArray removeAllObjects];
        NSArray *items = [doc nodesForXPath:@"data" error:nil];
        if (items) {
            for (DDXMLElement *obj in items) {
                int resultCode = [[[obj elementForName:@"ResultCode"] stringValue] integerValue] ;
                if (resultCode > 0) {
                    isEvaluate = YES;
                } else {
                    isEvaluate = NO;
                    NSString *message = [[obj elementForName:@"Message"] stringValue];
                    if ([message isEqualToString:@"IN TIME"]) {
                        alert =[[UIAlertView alloc] initWithTitle:kInfoTwo message:kExample2 delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
                        [alert setBackgroundColor:[UIColor clearColor]];
                        [alert setContentMode:UIViewContentModeScaleAspectFit];
                        [alert show];
                        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(c) userInfo:nil repeats:NO];
                    }
                }
                
//                NSLog(@"resultCode:%d message:%@", resultCode, message);
            }
        }
    }else if ([request.username isEqualToString:@"against" ]) {
        //        [commArray removeAllObjects];
        NSArray *items = [doc nodesForXPath:@"data" error:nil];
        if (items) {
            for (DDXMLElement *obj in items) {
                int resultCode = [[[obj elementForName:@"ResultCode"] stringValue] integerValue] ;
                if (resultCode > 0) {
                    isEvaluate = YES;
                } else {
                    isEvaluate = NO;
                    NSString *message = [[obj elementForName:@"Message"] stringValue];
                    if ([message isEqualToString:@"IN TIME"]) {
                        alert =[[UIAlertView alloc] initWithTitle:kInfoTwo message:kExample2 delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
                        [alert setBackgroundColor:[UIColor clearColor]];
                        [alert setContentMode:UIViewContentModeScaleAspectFit];
                        [alert show];
                        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(c) userInfo:nil repeats:NO];
                    }
                }

            }
        }
    }
}

- (void)requestDone:(ASIHTTPRequest *)request
{
    kNetEnable;
    NSData *myData = [request responseData];
    DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:myData options:0 error:nil];
//    if ([request.username isEqualToString:@"text" ]) {
//        NSArray *items = [doc nodesForXPath:@"data/voatext" error:nil];
//        if (items) {
//            BOOL flushList = NO;
//            for (DDXMLElement *obj in items) {
//                VOAView *newVoa = [[VOAView alloc] init];
//                newVoa.voaid = request.tag;
//                newVoa.paraid = [[[obj elementForName:@"ParaId"] stringValue] integerValue];
//                newVoa.pic = [NSString stringWithFormat:@"http://static.iyuba.com/images/voapic/%d/%d_%d.jpg", newVoa.voaid/100, newVoa.voaid, newVoa.paraid];
//                newVoa.descCn = [[[obj elementForName:@"ImgWords"] stringValue] stringByReplacingOccurrencesOfString:@"\"" withString:@"”"];
//                newVoa.title = [[[obj elementForName:@"Sentence"] stringValue]stringByReplacingOccurrencesOfString:@"\"" withString:@"”"];;
//                newVoa.title_Cn = [[[obj elementForName:@"sentence_cn"] stringValue] isEqualToString: @" null"] ? nil :[[obj elementForName:@"sentence_cn"] stringValue];
//                //                newVoa.creatTime = [[obj elementForName:@"creatTime"] stringValue];
//                newVoa.creatTime = [VOATitle catchCreatTimeBy:request.tag];
//                if ([VOAView isExist:newVoa.voaid paraid:newVoa.paraid] == NO) {
//                    [newVoa insert];
//                    //                    [self catchDetails:newVoa];
//                    flushList = YES;
//                    //                    NSLog(@"插入%d成功",newVoa._voaid);
//                }
//            }
//        }
//
//    }  else
    if ([request.username isEqualToString:@"tenText" ]) {
        NSArray *items = [doc nodesForXPath:@"data/voatext" error:nil];
        if (items) {
//            BOOL flushList = NO;
            for (DDXMLElement *obj in items) {
                VOAView *newVoa = [[VOAView alloc] init];
                newVoa.voaid = request.tag;
                newVoa.paraid = [[[obj elementForName:@"ParaId"] stringValue] integerValue];
                newVoa.pic = [NSString stringWithFormat:@"http://static.iyuba.com/images/voapic/%d/%d_%d.jpg", newVoa.voaid/100, newVoa.voaid, newVoa.paraid];
                newVoa.descCn = [[[obj elementForName:@"ImgWords"] stringValue] stringByReplacingOccurrencesOfString:@"\"" withString:@"”"];
                newVoa.title = [[[obj elementForName:@"Sentence"] stringValue]stringByReplacingOccurrencesOfString:@"\"" withString:@"”"];;
                newVoa.title_Cn = [[[obj elementForName:@"sentence_cn"] stringValue] isEqualToString: @" null"] ? nil :[[obj elementForName:@"sentence_cn"] stringValue];
                newVoa.creatTime = [VOATitle catchCreatTimeBy:request.tag];
                newVoa.userid = [[[obj elementForName:@"agreeUserId"] stringValue] integerValue];
                newVoa.userName = [[obj elementForName:@"agreeUserName"] stringValue];
                newVoa.userImgUrl = [[obj elementForName:@"agreeImgsrc"] stringValue];
                newVoa.sound =  [NSString stringWithFormat:@"http://voa.iyuba.com/voa/%@", [[obj elementForName:@"agreeShuoShuo"] stringValue].URLDecodedString];
                
                if ([VOAView isExist:newVoa.voaid paraid:newVoa.paraid] == NO) {
                    [newVoa insert];
                    //                    [self catchDetails:newVoa];
//                    flushList = YES;
                    //                    NSLog(@"插入%d成功",newVoa._voaid);
                } else {
                    [newVoa updateByVoaid];
                }
//                addNum++;
            }
            netVoaid = request.tag;
        }
//        NSLog(@"111111done");
//        if (addNum < 10) {
//            [self catchTenTextByVoaid:request.tag-1];
//        }
    }
}


#pragma mark -  CommentViewDelegate
/**
 *  获取评论
 */
- (void)catchComments: (NSInteger)page{
    VOAView *nowVoa = [myVoas objectAtIndex:myIntroControl.currentPhotoNum];
    if (kNetIsExist) {
        NSString *url = [NSString stringWithFormat:@"http://voa.iyuba.com/voa/UnicomApi?protocol=60001&voaid=%d&format=xml&sort=agree&parentID=300&paraid=%d&pageNumber=%d&pageCounts=15",nowVoa.voaid, nowVoa.paraid, page];
        ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
        [commentView.sendBtn setUserInteractionEnabled:NO];
        //        NSLog(@"url:%@", url);
        request.delegate = self;
        [request setUsername:@"comment"];
        [request startAsynchronous];
    } else {
        kNetTest;
    }
}

- (void)doResponse:(UIButton*) sender {
    [commentView.commRecBtn setHidden:YES];
    [commentView.textView becomeFirstResponder];
    [commentView.textView setHidden:NO];
    //    [commChangeBtn setTitle:@"语音" forState:UIControlStateNormal];
    [commentView.commChangeBtn setImage:[UIImage imageNamed:@"audioComm.png"] forState:UIControlStateNormal];
    [commentView.commChangeBtn setImage:[UIImage imageNamed:@"audioCommPres.png"] forState:UIControlStateHighlighted];
    [commentView.commChangeBtn setTag:1];
    [commentView.commRecBtn removeTarget:self action:@selector(playCommRec) forControlEvents:UIControlEventTouchUpInside];
    [commentView.commRecBtn setTitle:kPlaySixte forState:UIControlStateNormal];
    [commentView.commRecBtn addTarget:self action:@selector(startCommRecord) forControlEvents:UIControlEventTouchDown];
    [commentView.commRecBtn addTarget:self action:@selector(endCommRecord) forControlEvents:UIControlEventTouchUpInside];
    [commentView.commRecBtn addTarget:self action:@selector(endCommRecord) forControlEvents:UIControlEventTouchUpOutside];
    
    for (int i = 0; i < [commentView.commArray count]/9; i++) {
        if (i == sender.superview.tag) {
            [commentView.textView setText:[NSString stringWithFormat:@"%@%@:", kPlayNine, [commentView.commArray objectAtIndex:i*9+2]]];
        }
    }
    commentView.isResponse = YES;
    [commentView.textView setTag:sender.superview.tag];
}

- (void)doSend {
    NSInteger uid = [[NSUserDefaults standardUserDefaults] integerForKey:@"nowUser"];
    if (uid>0) {
        if ([commentView.textView isHidden]) {
            //                NSLog(@"上传音频");
            if (commentView.commChangeBtn.tag == 3) {
                [self sendComment:1];
            }
            
        } else {
            if ([[commentView.textView text] length] > 0) {
                [self sendComment:0];
            }
        }
    } else {
        LogController *myLog = [[LogController alloc]init];
        [self presentModalViewController:myLog animated:YES];
//        [myLog release];
    }
    [self.view endEditing:YES];
//    [self sendComment:[[commentView.commArray objectAtIndex:commentView.textView.tag] integerValue]];
}

- (void)doAgree:(UIButton*)sender {
    [self sendAgree:[[commentView.commArray objectAtIndex:sender.superview.tag*9] integerValue]];
    if(isEvaluate) [sender setTitle:[NSString stringWithFormat:@"%d", sender.titleLabel.text.integerValue+1] forState:UIControlStateNormal];
}

- (void)doAgainst:(UIButton*)sender {
    [self sendAgainst:[[commentView.commArray objectAtIndex:sender.superview.tag*9] integerValue]];
//    NSLog(@"%d", [[commentView.commArray objectAtIndex:sender.superview.tag*9] integerValue]);
    if(isEvaluate) [sender setTitle:[NSString stringWithFormat:@"%d", sender.titleLabel.text.integerValue+1] forState:UIControlStateNormal];
}

#pragma mark - MyTopViewDelegate
- (void)didListBtnPressed:(MyTopView *)myTopView {
    NSLog(@"list");
//    KLViewController *myKlview = [KLViewController alloc];
//    [self presentModalViewController:myKlview animated:YES];

    listView = (ListView *)[[[NSBundle mainBundle] loadNibNamed:@"ListView"
                                                          owner:self
                                                        options:nil] objectAtIndex:0];
    [listView setFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 0)];
    //    [moreView setFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height)];
    [listView.backBtn addTarget:self action:@selector(backBtnPressed:) forControlEvents:UIControlEventTouchDown];
    [listView setDelegate:self];
    [listView setMyDelegate:self];
    [self.view addSubview:listView];
    
    [listView.listView reloadData];
    [Constants beginAnimationWithName:@"SwitchTwo" duration:0.4f];
    [listView setFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height)];
    [UIView commitAnimations];
}


- (void)backBtnPressed:(UIButton *) sender {
    [Constants beginAnimationWithName:@"SwitchOne" duration:0.4f];
    [self.view endEditing:YES];
    [sender.superview.superview setFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 0)];
    [UIView commitAnimations];
}

//- (void)commBackBtnPressed:(UIButton *) sender {
//    [Constants beginAnimationWithName:@"SwitchOne" duration:0.4f];
//    [self.view endEditing:YES];
//    [sender.superview.superview setFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 0)];
//    [UIView commitAnimations];
//}

- (void)didMoreBtnPressed:(MyTopView *)myTopView {
    NSLog(@"more");
//    MoreViewController *myKlview = [[MoreViewController alloc] initWithNibName:@"MoreViewController" bundle:nil];
//    [self presentModalViewController:myKlview animated:YES];
    
    moreView = (MoreView *)[[[NSBundle mainBundle] loadNibNamed:@"MoreView"
                                                          owner:self
                                                        options:nil] objectAtIndex:0];
    [moreView setFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 0)];
//    [moreView setFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height)];
    [moreView.backBtn addTarget:self action:@selector(backBtnPressed:) forControlEvents:UIControlEventTouchDown];
    [moreView setDelegate:self];
    [moreView setMyDelegate:self];
    [self.view addSubview:moreView];
    
    [Constants beginAnimationWithName:@"SwitchTwo" duration:0.4f];
    [moreView setFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height)];
    [UIView commitAnimations];
}

- (void) didIyubaBtnPressed:(MyTopView *)myTopView {
//    [self flushIntro];
    isSelectList = NO;
    if (kNetIsExist) {
        NSInteger firstVoaid = [VOATitle catchVoaidBelow:100000000];
        if ([(VOAView *)[myVoas objectAtIndex:0] voaid] < firstVoaid) {
            [self catchSyTextByVoaid:firstVoaid];
        } else {
            //            [myIntroControl scrollViewToImgIndex:1];
            //            [myIntroControl scrollViewtoTop];
        }
    } else {
        kNetTest;
        //        [myIntroControl scrollViewToImgIndex:1];
    }
    [self initIntroView];
}


#pragma mark - MyBottomViewDelegate

- (void)didCommBtnPressed:(MyBottomView *)myBottomView {
    commentView = (CommentView *)[[[NSBundle mainBundle] loadNibNamed:@"CommentView"
                                                          owner:self
                                                        options:nil] objectAtIndex:0];
    [self catchComments:1];
    VOAView *nowVoa = [myVoas objectAtIndex:myIntroControl.currentPhotoNum];
    [commentView.senLabel setText:nowVoa.title];
    
    [commentView setFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 0)];
    //    [moreView setFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height)];
    [commentView.backBtn addTarget:self action:@selector(backBtnPressed:) forControlEvents:UIControlEventTouchDown];
    
    [commentView.sendBtn addTarget:self action:@selector(doSend) forControlEvents:UIControlEventTouchUpInside];
    [commentView.commChangeBtn addTarget:self action:@selector(doCommChange) forControlEvents:UIControlEventTouchUpInside];
    [commentView.commRecBtn addTarget:self action:@selector(startCommRecord) forControlEvents:UIControlEventTouchDown];
    [commentView.commRecBtn addTarget:self action:@selector(endCommRecord) forControlEvents:UIControlEventTouchUpInside];
    [commentView.commRecBtn addTarget:self action:@selector(endCommRecord) forControlEvents:UIControlEventTouchUpOutside];
    
    
    [commentView setDelegate:self];
    [commentView setMyDelegate:self];
    [self.view addSubview:commentView];
    
    nowVoa = [myIntroControl.pages objectAtIndex:myIntroControl.arrayIndex];
    if (nowVoa.userid > 0) {
        [commentView.userImg setImageWithURL:[NSURL URLWithString:nowVoa.userImgUrl] placeholderImage:[UIImage imageNamed:@"userDefault.png"]];
        [commentView.userName setText:nowVoa.userName];
    }
    
    [Constants beginAnimationWithName:@"SwitchTwo" duration:0.4f];
    [commentView setFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height)];
    [UIView commitAnimations];
}

- (void)didShareBtnPressed:(MyBottomView *)myBottomView {
    UIActionSheet *share = [[UIActionSheet alloc] initWithTitle:@"分享当前图片新闻到" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"新浪微博",@"人人网",@"腾讯微博",@"个人收藏", nil];
    [share showInView:self.view.window];
}

- (void)didTrumpetBtnPressed:(UIButton*)sender  {
    VOAView *nowVoa = [myIntroControl.pages objectAtIndex:myIntroControl.arrayIndex];
    if (kNetIsExist && nowVoa.userid > 0) {
        VOAView *nowVoa = [myIntroControl.pages objectAtIndex:myIntroControl.arrayIndex];
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setCategory:AVAudioSessionCategoryPlayback error:nil];
        if (commPlayer) {
            commPlayer = nil;
        }
        commPlayer =[[AVPlayer alloc]initWithURL:[NSURL URLWithString:nowVoa.sound]];
        [commPlayer play];
        //    NSLog(@"play word");
    }
}

#pragma mark UIActionSheetDelegate
/**
 *  分享时出现的UIActionSheet点击选项时响应协议
 */
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0://新浪微博
            // 微博分享：
            //                NSLog(@"weibo");
//            [self shareAll];
            break;
        case 1:
            //人人分享：
//            [self ShareThisQuestion];
            break;
        case 2:
            //QQ微博分享：
//            [self shareToQQWeibo];
            break;
        case 3:
            [self collectVOAView];
            break;
        default:
            break;
    }
    
    //    }
}

- (void)collectVOAView {
    VOAView *nowVoa = [myVoas objectAtIndex:myIntroControl.currentPhotoNum];
    [VOAFav alterCollect:nowVoa.voaid paraid:nowVoa.paraid];
    NSLog(@"zhaosong:%@", nowVoa.descCn);
}

#pragma mark - ListViewDelegate
/**
 *
 */
- (void)didImgPressed:(NSInteger)newsIndex {
//    NSLog(@"newsIndex:%d", newsIndex);
//    [myIntroControl scrollViewToImgIndex:newsIndex];
    if (timer && [timer isValid]) {
        [timer invalidate];
    }
    
    isSelectList = YES;
    islocal = NO;
    listVoaid = newsIndex;
    [Constants beginAnimationWithName:@"SwitchOne" duration:1.f];
    
//    if (kNetIsExist && ![VOAView isVoaidExist:newsIndex]) {
    if(kNetIsExist) {
        [self catchSyTextByVoaid:newsIndex];
    }
    
    if ([VOAView isVoaidExist:newsIndex]) {
        [myVoas removeAllObjects];
        offset = [VOAView findNewByVoaid:newsIndex myArray:myVoas];
        
        netVoaid = [(VOAView *)[myVoas lastObject] voaid];
        
        myIntroControl = [[IntroControll alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) pages:myVoas];
        
        myIntroControl.topView.myDelegate = self;
        myIntroControl.bottomView.myDelegate = self;
        [myIntroControl setDelegate:self];
        self.view = myIntroControl;
        [listView setFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 0)];
    } else {
        alert =[[UIAlertView alloc] initWithTitle:kInfoTwo message:kExample1 delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alert setBackgroundColor:[UIColor clearColor]];
        [alert setContentMode:UIViewContentModeScaleAspectFit];
        [alert show];
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(c) userInfo:nil repeats:NO];
    }

    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"imgAutoScroll"]) {
        timer =  [NSTimer scheduledTimerWithTimeInterval:kAutoScroll
                                                  target:self
                                                selector:@selector(imgScroll)
                                                userInfo:nil
                                                 repeats:YES];
    }
    
    [UIView commitAnimations];
    
    
}

- (void)didImgPressedLocal:(VOAView *)voaView {
//    NSLog(@"newsIndex:%d", newsIndex);
    //    [myIntroControl scrollViewToImgIndex:newsIndex];
    if (timer && [timer isValid]) {
        [timer invalidate];
    }
    isSelectList = YES;
    islocal = YES;
    listVoa = voaView;
    [Constants beginAnimationWithName:@"SwitchOne" duration:1.f];
    
//    if (kNetIsExist && ![VOAView isVoaidExist:newsIndex]) {
//        [self catchSyTextByVoaid:newsIndex];
//    }
    
//    if ([VOAView isVoaidExist:newsIndex]) {
        [myVoas removeAllObjects];
        offset = [VOAView findNewByVoaidParaid:voaView.voaid paraid:voaView.paraid myArray:myVoas];
    
        netVoaid = [(VOAView *)[myVoas lastObject] voaid];
        
        myIntroControl = [[IntroControll alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) pages:myVoas];
        
        myIntroControl.topView.myDelegate = self;
        myIntroControl.bottomView.myDelegate = self;
        [myIntroControl setDelegate:self];
        self.view = myIntroControl;
        [listView setFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 0)];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"imgAutoScroll"]) {
        timer =  [NSTimer scheduledTimerWithTimeInterval:kAutoScroll
                                                  target:self
                                                selector:@selector(imgScroll)
                                                userInfo:nil
                                                 repeats:YES];
    }
//    } else {
//        alert =[[UIAlertView alloc] initWithTitle:kInfoTwo message:kExample1 delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
//        [alert setBackgroundColor:[UIColor clearColor]];
//        [alert setContentMode:UIViewContentModeScaleAspectFit];
//        [alert show];
//        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(c) userInfo:nil repeats:NO];
//    }
    
    [UIView commitAnimations];
}

//- (void)didAllPressed {
//    [listView allFlush];
//}
//
//- (void)didlocPressed {
//    [listView localFlush];
//}

#pragma mark - MoreViewDelegate
/**
 *
 */
- (void)didSettingBtnPressed {
    IASKAppSettingsViewController *mySetting = [[IASKAppSettingsViewController alloc] init];
//    IASKAppSettingsViewController *mySetting = (IASKAppSettingsViewController *)[[[NSBundle mainBundle] loadNibNamed:@"IASKAppSettingsView"
//                                                                owner:self
//                                                              options:nil] objectAtIndex:0];
    [self.navigationController pushViewController:mySetting animated:YES];
//    [self presentModalViewController:mySetting animated:YES];
}

- (void)didFeedbackBtnPressed {
    FeedbackViewController *feedback = [[FeedbackViewController alloc] init];
    [self presentModalViewController:feedback animated:YES];
}

- (void)didAccountBtnPressed {
    LogController *logControll = [[LogController alloc] init];
//    [self.navigationController pushViewController:logControll animated:YES];
    [self presentModalViewController:logControll animated:YES];
}

#pragma mark - UIScrollViewDelegate
/**
 *  滑动UIScrollView时响应
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
//    scrollView set
    NSLog(@"offsety:%f", scrollView.contentOffset.y);
    if (scrollView.contentOffset.y < -[[UIScreen mainScreen] bounds].size.height * 0.2f) {
        downMoreView = YES;
//        [UIScrollView beginAnimations:@"SwitchOne" context:nil];
//        [UIScrollView setAnimationDuration:1.0f];
//        [UIScrollView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//        [scrollView setFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 0)];
//        [UIScrollView commitAnimations];
//        downMoreView = NO;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (downMoreView) {
//        [self backBtnPressed];
        [Constants beginAnimationWithName:@"SwitchOne" duration:0.4f];
        [scrollView setFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 0)];
        [UIView commitAnimations];
        downMoreView = NO;
    }
}
#pragma mark Record action
/**
 *  开启/关闭录音定时器
 */
-(void)changeRecordTimer
{
    //    //时间间隔
    //    NSTimeInterval timeInterval =1.0 ;
    //定时器
    if (recordTimer && [recordTimer isValid]) {
        [recordTimer invalidate];
        //        recordTimer = nil;
    } else {
//        if (pageControl.currentPage == 2) {
//            [self stopPlayRecord];
//        }
        //        recordSeconds = 0.f ;
//        nowRecordSeconds = recordTime;
        recordSeconds = 0.f;
//        [recordLabel setText:[timeSwitchClass timeToSwitchAdvance:0]];
        recordTimer = [NSTimer scheduledTimerWithTimeInterval:0.1f
                                                       target:self
                                                     selector:@selector(handleRecordTimer)
                                                     userInfo:nil
                                                      repeats:YES];
    }
}

/**
 *  录音定时器处理函数
 */
-(void) handleRecordTimer {
    //更新峰值
    [audioRecoder.audioRecorder updateMeters];
    [self updateMetersByAvgPower:[audioRecoder.audioRecorder averagePowerForChannel:0]];
//    if (pageControl.currentPage == 2) {
//        //        [recordLabel setText:[timeSwitchClass timeToSwitchAdvance: (int)recordSeconds]];
//        [recordLabel setText:[timeSwitchClass timeToSwitchAdvance: (int)nowRecordSeconds]];
//        if (nowRecordSeconds < 0 && recordLabel.textColor != [UIColor redColor] ) {
//            [recordLabel setTextColor:[UIColor redColor]];
//        }
//    }
    nowRecordSeconds -= 0.1f;
    recordSeconds += 0.1f;
    //    NSLog(@"recordSeconds:%f", recordSeconds);
}

/**
 *  更新音频峰值
 */
- (void)updateMetersByAvgPower:(float)_avgPower{
    //-160表示完全安静，0表示最大输入值
    //
    //    NSInteger imageIndex = 0;
    if (_avgPower < -40)
        commentView.peakMeterIV.image = [UIImage imageNamed:kSpeakImage1];
    else if (_avgPower >= -40 && _avgPower < -30)
        commentView.peakMeterIV.image = [UIImage imageNamed:kSpeakImage2];
    else if (_avgPower >= -30 && _avgPower < -25)
        commentView.peakMeterIV.image = [UIImage imageNamed:kSpeakImage3];
    else if (_avgPower >= -25 && _avgPower < -20)
        commentView.peakMeterIV.image = [UIImage imageNamed:kSpeakImage4];
    else if (_avgPower >= -20 && _avgPower < -15)
        commentView.peakMeterIV.image = [UIImage imageNamed:kSpeakImage5];
    else if (_avgPower >= -15 && _avgPower < -10)
        commentView.peakMeterIV.image = [UIImage imageNamed:kSpeakImage6];
    else if (_avgPower >= -10 && _avgPower < -5)
        commentView.peakMeterIV.image = [UIImage imageNamed:kSpeakImage7];
    else if (_avgPower >= -5 && _avgPower < -0)
        commentView.peakMeterIV.image = [UIImage imageNamed:kSpeakImage8];
    
}

/**
 *  评论录音按钮响应事件
 */
- (void)startCommRecord
{
    NSLog(@"开始录音");
    //    [self setButtonImage:pauseImage];
//    if () {
//        [wordPlayer release];
//        wordPlayer = nil;
//    }
    [commentView.myAudioView setHidden:NO];
    
    if (commPlayer) {
        commPlayer = nil;
    }
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryRecord error:nil];
    
    if (m_isRecording == NO)
    {
//        if (!notValid) {
//            //        if ([lyricSynTimer isValid]) {
//            [lyricSynTimer invalidate];
//            //        }
//            //        if ([sliderTimer isValid]) {
//            [sliderTimer invalidate];
//            //        }
//            notValid = YES;
//        }
        [self changeRecordTimer];
        [commentView.recorderView setHidden:NO];
        m_isRecording = YES;
        NSString *recordAudioFullPath = [kRecorderDirectory stringByAppendingPathComponent:[NSString stringWithFormat:kRecordFile]];
        //        NSString *recordAudioFullPath = [kRecorderDirectory stringByAppendingPathComponent:
        //                                         [NSString stringWithFormat:@"recordAudio.caf"]];
        NSLock* tempLock = [[NSLock alloc]init];
        [tempLock lock];
        if ([[NSFileManager defaultManager] fileExistsAtPath:recordAudioFullPath])
        {
            [[NSFileManager defaultManager] removeItemAtPath:recordAudioFullPath error:nil];
        }
        [tempLock unlock];
//        [tempLock release];
        
        dispatch_queue_t stopQueue;
        stopQueue = dispatch_queue_create("stopQueue", NULL);
        dispatch_async(stopQueue, ^(void){
            //run in main thread
            dispatch_async(dispatch_get_main_queue(), ^{
                [audioRecoder startRecord];
                //                if (!isiPhone) { //ipad版本需要最少录制八秒才可播放
                //                    [NSTimer scheduledTimerWithTimeInterval:8 target:self selector:@selector(recordEnable) userInfo:nil repeats:NO];
                //                }
            });
        });
        
        dispatch_release(stopQueue);
        
    }
}

- (void)endCommRecord
{
    NSLog(@"结束录音");
    [self performSelector:@selector(endCommRecordImple) withObject:nil afterDelay:1.2f];
}

- (void)endCommRecordImple {
    if (m_isRecording) {
        [commentView.myAudioView setHidden:YES];
        m_isRecording = NO;
        [commentView.recorderView setHidden:YES];
        [self stopRecordTimer];
        dispatch_queue_t stopQueue;
        stopQueue = dispatch_queue_create("stopQueue", NULL);
        dispatch_async(stopQueue, ^(void){
            //run in main thread
            dispatch_async(dispatch_get_main_queue(), ^{
                [audioRecoder stopRecord];
                
            });
        });
        dispatch_release(stopQueue);
        
        if (recordSeconds > 3.0f) {
            [commentView.commRecBtn removeTarget:self action:@selector(startCommRecord) forControlEvents:UIControlEventTouchDown];
            [commentView.commRecBtn removeTarget:self action:@selector(endCommRecord) forControlEvents:UIControlEventTouchUpInside];
            [commentView.commRecBtn removeTarget:self action:@selector(endCommRecord) forControlEvents:UIControlEventTouchUpOutside];
            [commentView.commRecBtn setTitle:kPlay24 forState:UIControlStateNormal];
            [commentView.commRecBtn addTarget:self action:@selector(playCommRec) forControlEvents:UIControlEventTouchUpInside];
            
            [commentView.commChangeBtn removeTarget:self action:@selector(doCommChange) forControlEvents:UIControlEventTouchUpInside];
            [commentView.commChangeBtn setImage:[UIImage imageNamed:@"commReturn.png"] forState:UIControlStateNormal];
            [commentView.commChangeBtn setImage:[UIImage imageNamed:@"commReturnPres.png"] forState:UIControlStateHighlighted];
            [commentView.commChangeBtn setTag:3];
            [commentView.commChangeBtn addTarget:self action:@selector(returnCommRec) forControlEvents:UIControlEventTouchUpInside];
        } else {
            [commentView.displayModeBtn setTitle:kPlay25 forState:UIControlStateNormal];
            
            [Constants beginAnimationWithName:@"Display" duration:0.5f];
            [commentView.displayModeBtn setAlpha:0.8];
            [UIView commitAnimations];
            
            [Constants beginAnimationWithName:@"Dismiss" duration:2.0f];
            [commentView.displayModeBtn setAlpha:0];
            [UIView commitAnimations];
        }
    }
}

/**
 *  关闭录音定时器
 */
-(void)stopRecordTimer
{
    //    //时间间隔
    //    NSTimeInterval timeInterval =1.0 ;
    //定时器
    if (recordTimer && [recordTimer isValid]) {
        [recordTimer invalidate];
        recordTimer = nil;
//        [recordLabel setTextColor:[UIColor whiteColor]];
    }
}

/**
 *  切换评论方式的按钮响应事件
 */
- (void) doCommChange{
    if (commentView.textView.isHidden) {
        [commentView.textView setHidden:NO];
        [commentView.commRecBtn setHidden:YES];
        //        [commChangeBtn setTitle:@"语音" forState:UIControlStateNormal];
        [commentView.commChangeBtn setImage:[UIImage imageNamed:@"audioComm.png"] forState:UIControlStateNormal];
        [commentView.commChangeBtn setImage:[UIImage imageNamed:@"audioCommPres.png"] forState:UIControlStateHighlighted];
        [commentView.commChangeBtn setTag:1];
        //        [sendBtn removeTarget:self action:@selector(doRecSend) forControlEvents:UIControlEventTouchUpInside];
        //        [sendBtn addTarget:self action:@selector(doSend) forControlEvents:UIControlEventTouchUpInside];
        //        [commRecControl setHidden:YES];
    } else {
        [commentView.textView setHidden:YES];
        [commentView.commRecBtn setHidden:NO];
        //        [commChangeBtn setTitle:@"文本" forState:UIControlStateNormal];
        [commentView.commChangeBtn setImage:[UIImage imageNamed:@"textComm.png"] forState:UIControlStateNormal];
        [commentView.commChangeBtn setImage:[UIImage imageNamed:@"textCommPres.png"] forState:UIControlStateHighlighted];
        [commentView.commChangeBtn setTag:2];
        [self.view endEditing:YES];
        //        [sendBtn removeTarget:self action:@selector(doSend) forControlEvents:UIControlEventTouchUpInside];
        //        [sendBtn addTarget:self action:@selector(doRecSend) forControlEvents:UIControlEventTouchUpInside];
        //        [commRecControl setHidden:YES];
    }
}

/**
 *  切换评论方式的按钮响应事件
 */
//- (void) doRecSend{
//    NSLog(@"上传音频");
//    if (kNetIsExist) {
//        [self sendAudioComments:1];
//    } else {
//        kNetTest;
//    }
//
//}

/**
 *  返回语音评价录制
 */
- (void)returnCommRec{
    [commentView.commRecBtn removeTarget:self action:@selector(playCommRec) forControlEvents:UIControlEventTouchUpInside];
    [commentView.commRecBtn setTitle:kPlaySixte forState:UIControlStateNormal];
    [commentView.commRecBtn addTarget:self action:@selector(startCommRecord) forControlEvents:UIControlEventTouchDown];
    [commentView.commRecBtn addTarget:self action:@selector(endCommRecord) forControlEvents:UIControlEventTouchUpInside];
    [commentView.commRecBtn addTarget:self action:@selector(endCommRecord) forControlEvents:UIControlEventTouchUpOutside];
    
    
    [commentView.commChangeBtn removeTarget:self action:@selector(returnCommRec) forControlEvents:UIControlEventTouchUpInside];
    //    [commChangeBtn setTitle:@"文本" forState:UIControlStateNormal];
    [commentView.commChangeBtn setImage:[UIImage imageNamed:@"textComm.png"] forState:UIControlStateNormal];
    [commentView.commChangeBtn setImage:[UIImage imageNamed:@"textCommPres.png"] forState:UIControlStateHighlighted];
    [commentView.commChangeBtn setTag:2];
    [commentView.commChangeBtn addTarget:self action:@selector(doCommChange) forControlEvents:UIControlEventTouchUpInside];
    //    [self doCommChange];
    //    NSLog(@"返回语音评价录制");
}

/**
 *  播放大家的语音评论
 */
- (void) playUserCommRec:(UIButton *)sender
{
    if (senLabelTimer && [senLabelTimer isValid]) {
        [senLabelTimer invalidate];
        //        recordTimer = nil;
    }
    senTimerNum = 5;
    [commentView.myAudioView setHidden:NO];
    senLabelTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                     target:self
                                                   selector:@selector(handleSenTimer)
                                                   userInfo:nil
                                                    repeats:YES];
    if (kNetIsExist) {
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setCategory:AVAudioSessionCategoryPlayback error:nil];
        if (commPlayer) {
            commPlayer = nil;
        }
        commPlayer =[[AVPlayer alloc]initWithURL:[NSURL URLWithString:[commentView.commArray objectAtIndex:sender.superview.tag*9+5]]];
        [commPlayer play];
        //    NSLog(@"play word");
    }
    
}

- (void)handleSenTimer {
    senTimerNum--;
    if (senTimerNum == 0) {
        [senLabelTimer invalidate];
        [commentView.myAudioView setHidden:YES];
    }
}

/**
 *  回放语音评价
 */
- (void)playCommRec{
    //    NSLog(@"回放语音评价");
    if (senLabelTimer && [senLabelTimer isValid]) {
        [senLabelTimer invalidate];
        //        recordTimer = nil;
    }
    senTimerNum = 5;
    [commentView.myAudioView setHidden:NO];
    senLabelTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                     target:self
                                                   selector:@selector(handleSenTimer)
                                                   userInfo:nil
                                                    repeats:YES];

    NSString *recordAudioFullPath = [kRecorderDirectory stringByAppendingPathComponent:
                                     [NSString stringWithFormat:kRecordFile]];
    ////    NSLock* tempLock = [[NSLock alloc]init];
    ////    [tempLock lock];
    if ([[NSFileManager defaultManager] fileExistsAtPath:recordAudioFullPath])
    {
        //        NSLog(@"文件存在");
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setCategory:AVAudioSessionCategoryPlayback error:nil];
        if (commPlayer) {
            commPlayer = nil;
        }
        commPlayer = [[AVPlayer alloc]  initWithURL:[NSURL fileURLWithPath:recordAudioFullPath]];
        //        [self changePlayRecordTimer];
        [commPlayer play];
        
    }else {
        //        NSLog(@"文件不存在");
    }
}

#pragma mark - Motion
/**
 * 检测振动，控制播放
 */
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    //    NSLog(@"%d",[[NSUserDefaults standardUserDefaults] boolForKey:@"shakeCtrlPlay"]);
        if (motion == UIEventSubtypeMotionShake)
    if ((motion == UIEventSubtypeMotionShake)&&([[NSUserDefaults standardUserDefaults] boolForKey:@"shakeChange"]))
    {
        [myIntroControl tick];
        NSLog(@"shake1");
    }
}

@end
