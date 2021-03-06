//
//  NetTest.h
//  AEHTS
//  对网络情况进行查询和检测等服务
//  Created by zhao song on 12-11-30.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

/**
 *  
 */
@interface NetTest : NSObject <ASIHTTPRequestDelegate>

@property (nonatomic) BOOL isExisitNet; //标识是否存在网络
@property (nonatomic) BOOL hasResultQQWeibo; //标志腾讯微博分享是否已经提交用户名密码

+ (NetTest *)sharedNet; 
- (void)netEnable;
- (void)netDisable;
- (void)catchNet;

@end
