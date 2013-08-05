//
//  VOAFav.h
//  VOA
//  下载的新闻数据类
//  Created by song zhao on 12-2-8.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "favdatabase.h"
#import "VOAView.h"
@interface VOAFav : NSObject
{
    NSInteger _voaid;
    NSInteger _paraid;
    NSString *_collect;
    NSString *_date;
}

@property NSInteger voaid;
@property NSInteger paraid;
@property (nonatomic, retain) NSString *collect;
@property (nonatomic, retain) NSString *date;

- (id) initWithVoaId:(NSInteger)voaid paraid:(NSInteger)paraid collect:(NSString *) collect date:(NSString *) date ;
+ (BOOL) isCollected:(NSInteger)voaid  paraid:(NSInteger)paraid;
+ (void) alterCollect:(NSInteger)voaid paraid: (NSInteger) paraid;
+ (void) deleteCollect:(NSInteger)voaid paraid: (NSInteger) paraid;
//查找并返回指定id的对象
+ (id) find:(NSInteger ) voaid;

+ (NSMutableArray *) findCollect;
+ (void) getList:(NSMutableArray *)listArray;
+ (BOOL) isExist:(NSInteger)voaid paraid:(NSInteger)paraid;
+ (NSInteger) countOfCollected;

////查找并返回全部对象
//+ (NSMutableArray *) findAll;
@end
