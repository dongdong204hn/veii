//
//  InforController.h
//  VOA
//  "更多应用"容器
//  Created by song zhao on 12-3-31.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

/**
 *
 */
@interface InforController : UIViewController<UIWebViewDelegate>
{    
    UIWebView *             _webView;
    BOOL isiPhone;
}

@property (nonatomic, retain) IBOutlet UIView *          myTopView;
@property (nonatomic, retain) IBOutlet UIWebView *          webView;
@property (nonatomic, retain) NSMutableArray *          urlArray;
@property (nonatomic) BOOL isiPhone;

- (IBAction) didBackBtnPressed:(id)sender;

@end
