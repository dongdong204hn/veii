//
//  VoaTitle.h
//  VOAImage
//
//  Created by 赵松 on 13-7-23.
//  Copyright (c) 2013年 Dmitry Kondratyev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegexKitLite.h"

@interface VOATitle : NSObject {
    NSInteger _voaid; //标志日期
    NSString *_creatTime; //发布时间
    NSString *_pic; //图片URL
    NSString *_descCn; //该天的描述性语言
}


@property NSInteger voaid;
@property (nonatomic, strong) NSString *creatTime;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSString *descCn;

- (BOOL) insert;

//全赋值初始化VOAView对象
- (id) initWithVoaId: (NSInteger)voaid creatTime: (NSString *)creatTime pic: (NSString *)pic descCn: (NSString *)descCn;

+ (NSString *) catchCreatTimeBy: (NSInteger)voaid;

+ (NSInteger) findLastId;

+ (NSInteger) catchVoaidBelow: (NSInteger)voaid;

+ (void)findAll: (NSMutableArray *)voaTitles;

@end
