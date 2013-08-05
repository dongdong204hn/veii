//
//  FeedbackViewController.m
//  VOAImage
//
//  Created by 赵松 on 13-7-28.
//  Copyright (c) 2013年 Dmitry Kondratyev. All rights reserved.
//

#import "FeedbackViewController.h"
#import "RegexKitLite.h"

@interface FeedbackViewController ()

@end

@implementation FeedbackViewController
@synthesize mainScroll;
@synthesize submitBtn;
@synthesize sendLock;
@synthesize feedback;
@synthesize mailLabel;
@synthesize mail;
@synthesize alert;


- (id)init {
    return [self initWithNibName:@"FeedbackViewController" bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    NSInteger userId = [[[NSUserDefaults standardUserDefaults] objectForKey:@"nowUser"] integerValue];
    //    NSLog(@"生词本添加用户：%d",userId);
    if (userId>0) {
        [mailLabel setHidden:YES];
        [mail setHidden:YES];
        [submitBtn setFrame:CGRectMake(30, 280, 85, 30)];
    } else {
        [mailLabel setHidden:NO];
        [mail setHidden:NO];
        [submitBtn setFrame:CGRectMake(30, 345, 85, 30)];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [mainScroll setContentSize:CGSizeMake(320, 600)];
    [[submitBtn layer] setCornerRadius:5.0f];
    [[submitBtn layer] setMasksToBounds:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 对网路情况进行判断，若无网络弹出提示框
 */
-(BOOL) isExistenceNetwork
{
	BOOL isExistenceNetwork = TRUE;
	Reachability *r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
			isExistenceNetwork=FALSE;
            break;
        case ReachableViaWWAN:
			isExistenceNetwork=TRUE;
            break;
        case ReachableViaWiFi:
			isExistenceNetwork=TRUE;
            break;
    }
	if (!isExistenceNetwork) {
        UIAlertView *myalert = nil;
        myalert = [[UIAlertView alloc] initWithTitle:kFeedbackThree message:kFeedbackFour delegate:nil cancelButtonTitle:kFeedbackFive otherButtonTitles:nil,nil];
        [myalert show];
//        [myalert release];
	}
	return isExistenceNetwork;
}

/**
 alert自动消失时调用的函数
 */
-(void)c
{
    [alert dismissWithClickedButtonIndex:0 animated:YES];
//    [_alert release];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - http connect

/**
 asyn request to send feedback
 */
- (void)sendFeedback{
    if (sendLock) {
    } else {
        if ([self isExistenceNetwork]) {
            if (feedback.text.length > 0) {
                sendLock = YES;
                ASIFormDataRequest * request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://api.iyuba.com/mobile/ios/itu/feedback.xml"]];
                request.delegate = self;
                NSInteger nowUserId = [[[NSUserDefaults standardUserDefaults] objectForKey:@"nowUser"] integerValue];
                NSString * decodedText = [[NSString alloc] initWithUTF8String:[feedback.text UTF8String]];
                if (nowUserId > 0) {
                    [request setPostValue:[NSString stringWithFormat:@"%d",nowUserId] forKey:@"uid"];
                    [request setPostValue:decodedText forKey:@"content"];
                    //            [decodedText release];
                    [request startAsynchronous];
                }
                else
                {
                    if ([mail.text isMatchedByRegex:@"^([a-zA-Z0-9_\\.\\-])+\\@(([a-zA-Z0-9\\-])+\\.)+([a-zA-Z0-9]{2,4})+$"]) {
                        [request setPostValue:mail.text forKey:@"email"];
                        [request setPostValue:decodedText forKey:@"content"];
                        //            [decodedText release];
                        [request startAsynchronous];
                    } else {
                        sendLock = NO;
                        alert = [[UIAlertView alloc] initWithTitle:kFeedback9 message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
                        
                        [alert setBackgroundColor:[UIColor clearColor]];
                        
                        [alert setContentMode:UIViewContentModeScaleAspectFit];
                        
                        [alert show];
                        
                        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(c) userInfo:nil repeats:NO];
                    }
                }
                
            } else {
                alert = [[UIAlertView alloc] initWithTitle:kFeedback8 message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
                
                [alert setBackgroundColor:[UIColor clearColor]];
                
                [alert setContentMode:UIViewContentModeScaleAspectFit];
                
                [alert show];
                
                [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(c) userInfo:nil repeats:NO];
            }
            
        }
    }
}


- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders{
    if ([request responseStatusCode] >= 400) {
        UIAlertView *alertOne = [[UIAlertView alloc] initWithTitle:kSearchEleven message:[NSString stringWithFormat:@"%@,%@",kSearchEleven,kSearchTwelve] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertOne show];
//        [alertOne release];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    sendLock = NO;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        kNetTest;
    });
    UIAlertView *alertOne = [[UIAlertView alloc] initWithTitle:kVoaWordOne message:kFeedbackThree delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alertOne show];
//    [alertOne release];
    
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    kNetEnable;
    NSData *myData = [request responseData];
    DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:myData options:0 error:nil];
    /////解析
    NSArray *items = [doc nodesForXPath:@"response" error:nil];
    if (items) {
        for (DDXMLElement *obj in items) {
            NSString *status = [[obj elementForName:@"status"] stringValue];
            if ([status isEqualToString:@"OK"]) {
                alert = [[UIAlertView alloc] initWithTitle:kFeedbackTwo message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
                
                [alert setBackgroundColor:[UIColor clearColor]];
                
                [alert setContentMode:UIViewContentModeScaleAspectFit];
                
                [alert show];
                
                [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(c) userInfo:nil repeats:NO];
            }else
            {
                NSString *msg = [[obj elementForName:@"msg"] stringValue] ;
                UIAlertView * alertOne = [[UIAlertView alloc] initWithTitle:kFeedbackThree message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alertOne show];
//                [alertOne release];
            }
            sendLock = NO;
        }
    }
//    [doc release],doc = nil;
}



#pragma mark - My Action
- (IBAction) didBackBtnPressed:(id)sender {
    [self.view endEditing:YES];
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction) didSubmitBtnPressed:(id)sender {
    [self sendFeedback];
    [self.view endEditing:YES];
}



#pragma mark - UiTextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [textView setText:@""];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [mainScroll setContentOffset:CGPointMake(0, 200)];
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [textField setTextColor:[UIColor blackColor]];
    [textField setText:@""];
//    if (textField.tag == 1 || textField.tag == 2) {
//        [textField setSecureTextEntry:YES];
//    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField.text isMatchedByRegex:@"^([a-zA-Z0-9_\\.\\-])+\\@(([a-zA-Z0-9\\-])+\\.)+([a-zA-Z0-9]{2,4})+$"]){
    }else{
        [textField setText:kRegEleven];
        [textField setTextColor:[UIColor redColor]];
    }
}

@end
