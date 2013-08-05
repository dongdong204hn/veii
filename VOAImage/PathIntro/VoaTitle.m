//
//  VoaTitle.m
//  VOAImage
//
//  Created by 赵松 on 13-7-23.
//  Copyright (c) 2013年 Dmitry Kondratyev. All rights reserved.
//

#import "VOATitle.h"
#import "database.h"

@implementation VOATitle
@synthesize voaid = _voaid;
@synthesize creatTime = _creatTime;
@synthesize pic = _pic;
@synthesize descCn = _descCn;

//全赋值初始化VOAView对象
- (id) initWithVoaId: (NSInteger)voaid creatTime: (NSString *)creatTime pic: (NSString *)pic descCn: (NSString *)descCn{
    if (self = [super init]) {
		_voaid = voaid;
        _creatTime = creatTime;
        _pic = pic;
        _descCn = descCn;
	}
	return self;
}

- (BOOL) insert {
    PLSqliteDatabase *dataBase = [database setup];
    //    const char *myDate = [date UTF8String];//NSString转变为字符数组
    //    date 显示为 2011-11-01%2012:12:12
	NSString *insertSql = [NSString stringWithFormat:@"insert into voatitle(voaid,creatTime,pic,descCn) values(%d,\"%@\",\"%@\",\"%@\") ;",self.voaid,self.creatTime,self.pic,self.descCn];
//    NSLog(@"insertSql:%@", insertSql);
	if([dataBase executeUpdate:insertSql]) {
        //        NSLog(@"--success!");
        return YES;
	}
	else {
        //		UIAlertView *errAlert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Update failture!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //		[errAlert show];
        //        [errAlert release];
	}
    return NO;
}

+ (NSString *) catchCreatTimeBy: (NSInteger)voaid {
    PLSqliteDatabase *dataBase = [database setup];
	id<PLResultSet> rs;
    NSString *findSql = [NSString stringWithFormat:@"select creatTime FROM voatitle WHERE voaid = %d;", voaid];
	rs = [dataBase executeQuery:findSql];
    NSString *creatTime = @"";
	if ([rs next]) {
        creatTime = [rs objectForColumn:@"creatTime"];
        //        content = [content stringByAppendingString: sentence];
	}
    
	[rs close];
	return creatTime;
}

+ (NSInteger) findLastId
{
    PLSqliteDatabase *dataBase = [database setup];
	id<PLResultSet> rs;
	NSString *findSql = [NSString stringWithFormat:@"select max(voaid) last from voatitle"];
	rs = [dataBase executeQuery:findSql];
    NSInteger last = 0;
	if([rs next]) {
        @try {
            last = [rs intForColumn:@"last"];
        }
        @catch (NSException *exception) {
            
        }
        
        //        NSLog(@"%@", last);
	}
	else {
        //		UIAlertView *errAlert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Can not find!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //		[errAlert show];
	}
	[rs close];
    //	[dataBase close];//
	return last;
    
}

/**
 *  获取刚好小于voaid的值
 */
+ (NSInteger) catchVoaidBelow: (NSInteger)voaid{
	PLSqliteDatabase *dataBase = [database setup];
	
	id<PLResultSet> rs;
    NSString *findSql = [NSString stringWithFormat:@"SELECT voaid FROM voatitle where voaid<%d ORDER BY voaid desc LIMIT 1;", voaid];
	rs = [dataBase executeQuery:findSql];

    NSInteger newVoaid = 0;
	while ([rs next]) {
        newVoaid = [rs intForColumn:@"voaid"];
	}
	//关闭数据库
	[rs close];
    //	[dataBase close];//
	return newVoaid;
}

/**
 *  获取全部voaTitles
 */
+ (void) findAll: (NSMutableArray *) voaTitles{
	PLSqliteDatabase *dataBase = [database setup];
	id<PLResultSet> rs;
    NSString *findSql = [NSString stringWithFormat:@"SELECT * FROM voaTitle ORDER BY voaid desc;"];
	rs = [dataBase executeQuery:findSql];
    //    NSLog(@"sql:%@",findSql);
	//定义一个数组存放所有信息
    //	NSMutableArray *voaViews = [[NSMutableArray alloc] init];
    
	//把rs中的数据库信息遍历到voaViews数组
	while ([rs next]) {
        NSInteger voaid = [rs intForColumn:@"voaid"];
        NSString *pic = [rs objectForColumn:@"pic"];
        NSString *descCn = [rs objectForColumn:@"descCn"];
        NSString *creatTime;
        NSString *regEx = @"\\S+";
        for(NSString *matchOne in [[rs objectForColumn:@"creatTime"] componentsMatchedByRegex:regEx]) {
            creatTime = matchOne;
            break;
        }
        
        VOATitle *voaTitle = [[VOATitle alloc] initWithVoaId:voaid creatTime:creatTime pic:pic descCn:descCn];
		[voaTitles addObject:voaTitle];
	}
	//关闭数据库
	[rs close];
}

@end
