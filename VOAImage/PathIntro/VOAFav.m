//
//  VOAFav.m
//  VOA
//
//  Created by song zhao on 12-2-8.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import "VOAFav.h"

@implementation VOAFav
@synthesize voaid = _voaid;
@synthesize paraid = _paraid;
@synthesize collect = _collect;
@synthesize date = _date;

- (id) initWithVoaId:(NSInteger) voaid  paraid:(NSInteger)paraid collect:(NSString *) collect date:(NSString *) date 
{
    if (self = [super init]) {
        _voaid = voaid;
        _paraid = paraid;
        _collect = collect;
        _date = date;
    }
    return self;
}

+ (BOOL) isCollected:(NSInteger)voaid paraid:(NSInteger)paraid{
    PLSqliteDatabase *dataBase = [favdatabase setup];
    
	id<PLResultSet> rs;
	NSString *findSql = [NSString stringWithFormat:@"select * FROM fav WHERE voaid = %d and paraid = %d and collect = 1 ", voaid,paraid];
	rs = [dataBase executeQuery:findSql];
	BOOL flg = NO;
	if([rs next]) {
        flg = YES;
	}
	else {
        //		UIAlertView *errAlert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Can not find!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //		[errAlert show];
	}
	
	[rs close];
    //	[voaDetail release];
	return flg;
}

+ (NSArray *) findCollect
{
    PLSqliteDatabase *dataBase = [favdatabase setup];
	
	id<PLResultSet> rs;
	rs = [dataBase executeQuery:@"SELECT * FROM fav where collect = 1 order by date desc"];
    
	//定义一个数组存放所有信息
	NSMutableArray *voaFavs = [[NSMutableArray alloc] init];
	
	//把rs中的数据库信息遍历到voaViews数组
	while ([rs next]) {
        int voaid = [rs intForColumn:@"voaid"];
        int paraid = [rs intForColumn:@"paraid"];
        NSString *collect = [rs objectForColumn:@"collect"];
        NSString *date = [rs objectForColumn:@"date"];
        
        VOAFav *voaFav = [[VOAFav alloc] initWithVoaId:voaid paraid:paraid collect:collect date:date];
		[voaFavs addObject:voaFav];
	}
	//关闭数据库
	[rs close];
    //	[dataBase close];//
	return voaFavs;
}

/**
 *  non-used
 *  根据voaid获取对象的方法
 */
+ (id) find:(NSInteger ) voaid{
	PLSqliteDatabase *dataBase = [favdatabase setup];
//    const char *myVoaid = [voaid UTF8String];//NSString转变为字符数组
    //    int myVoaid = voaid.intValue;//NSString转变为整型
	id<PLResultSet> rs;
	NSString *findSql = [NSString stringWithFormat:@"select * FROM fav WHERE voaid = %d", voaid];
	rs = [dataBase executeQuery:findSql];
	
	VOAFav *voaFav = nil;
	
	if([rs next]) {
        int paraid = [rs intForColumn:@"paraid"];
        NSString *collect = [rs objectForColumn:@"collect"];
        NSString *date = [rs objectForColumn:@"date"];
        //        NSString *title_cn = [rs objectForColumn:@"title_cn"];
        //        NSString *title_jp = [rs objectForColumn:@"title_jp"];
        //        NSString *collect = [rs objectForColumn:@"collect"];
        
        voaFav = [[VOAFav alloc] initWithVoaId:voaid paraid:paraid collect:collect date:date];
	}
	else {
//		UIAlertView *errAlert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Can not find!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//		[errAlert show];
	}
	
	[rs close];
    //	[dataBase close];//
	return voaFav;
}


+ (void) alterCollect:(NSInteger)voaid paraid: (NSInteger)paraid{
    PLSqliteDatabase *dataBase = [favdatabase setup];
    NSString* date;
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd/HH:mm:ss"];
    date = [formatter stringFromDate:[NSDate date]];
//    NSLog(@"%@",date);
    if ([self find:voaid]) {
        //	PLSqliteDatabase *dataBase = [favdatabase setup];
        //    [dataBase beginTransaction];
        //    const char *myVoaid = [voaid UTF8String];//NSString转变为字符数组
        //    int myVoaid = voaid.intValue;//NSString转变为整型
//        NSString* date;
//        NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
//        [formatter setDateFormat:@"YYYY-MM-dd/HH:mm:ss"];
//        date = [formatter stringFromDate:[NSDate date]];
//        NSLog(@"%@",date);
        //    const char *myDate = [date UTF8String];//NSString转变为字符数组
        //    date 显示为 2011-11-01%2012:12:12
        NSString *findSql = [NSString stringWithFormat:@"update fav set collect = 1,date = \"%@\" WHERE voaid = %d and paraid = %d ;",date,voaid,paraid];
        //    id<PLPreparedStatement> stmt = [dataBase prepareStatement: findSql];
        //    NSString *findSql = [NSString stringWithFormat:@"insert into voaview(collect) values(1) where voaid = %s", myVoaid];
        //    NSLog(@"---------->%@",[[VOAFav find:voaid] _collect]);
        //    if ([stmt executeUpdate] == NO)
        //        NSLog(@"INSERT failed");
        //    [stmt ];
        
        if([dataBase executeUpdate:findSql]) {
//            NSLog(@"--success!");
        }
        else {
//            UIAlertView *errAlert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Update failture!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [errAlert show];
        }
        
        //    [dataBase executeUpdate:@"commit"];
        //    id<PLPreparedStatement> stmt = [dataBase prepareStatement: @"INSERT INTO example (name, color) VALUES (?, ?)"];
        //    // Bind the parameters
        //    [stmt bindParameters: [NSArray arrayWithObjects: @"Widget", @"Blue", nil]];
        //    // Execute the INSERT
        //    if ([stmt executeUpdate] == NO)
        //        NSLog(@"INSERT failed");
        
        //    NSLog(@"---------->%@",[[VOAFav find:voaid] _date]);
        //    [dataBase commitTransaction];
        //    [dataBase ];
        //    [dataBase update];
        //    [dataBase close];

    }else
    {
        
        //    const char *myDate = [date UTF8String];//NSString转变为字符数组
        //    date 显示为 2011-11-01%2012:12:12
        NSString *findSql = [NSString stringWithFormat:@"insert into fav(voaid,paraid,collect,date) values(%d,%d,1,\"%@\");",voaid,paraid,date];
        //    id<PLPreparedStatement> stmt = [dataBase prepareStatement: findSql];
        //    NSString *findSql = [NSString stringWithFormat:@"insert into voaview(collect) values(1) where voaid = %s", myVoaid];
        //    NSLog(@"---------->%@",[[VOAFav find:voaid] _collect]);
        //    if ([stmt executeUpdate] == NO)
        //        NSLog(@"INSERT failed");
        //    [stmt ];
        
        if([dataBase executeUpdate:findSql]) {
//            NSLog(@"--success!");
        }
        else {
//            UIAlertView *errAlert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Update failture!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [errAlert show];
//            [errAlert release];
        }
        
        //    [dataBase executeUpdate:@"commit"];
        //    id<PLPreparedStatement> stmt = [dataBase prepareStatement: @"INSERT INTO example (name, color) VALUES (?, ?)"];
        //    // Bind the parameters
        //    [stmt bindParameters: [NSArray arrayWithObjects: @"Widget", @"Blue", nil]];
        //    // Execute the INSERT
        //    if ([stmt executeUpdate] == NO)
        //        NSLog(@"INSERT failed");
        
        //    NSLog(@"---------->%@",[[VOAFav find:voaid] _date]);
        //    [dataBase commitTransaction];
        //    [dataBase ];
        //    [dataBase update];
        //    [dataBase close];
    }
//    [formatter release],formatter = nil;
}

+ (void) deleteCollect:(NSInteger) voaid paraid:(NSInteger)paraid{
	PLSqliteDatabase *dataBase = [favdatabase setup];
//	NSString* date;
//    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
//    [formatter setDateFormat:@"YYYY-MM-dd-HH-mm-ss"];
//    date = [formatter stringFromDate:[NSDate date]];
//    NSLog(@"%@",date);
	NSString *findSql = [NSString stringWithFormat:@"update fav set collect = 0 WHERE voaid = %d and paraid = %d ;",voaid, paraid];
	if([dataBase executeUpdate:findSql]) {
//        NSLog(@"--success!");
	}
	else {
//		UIAlertView *errAlert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Update failture!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//		[errAlert show];
//        [errAlert release];
	}
}

+ (void) getList:(NSMutableArray *)listArray
{
    PLSqliteDatabase *dataBase = [favdatabase setup];
    id<PLResultSet>rs;
    rs = [dataBase executeQuery:[NSString stringWithFormat:@"select * from fav where collect=1 order by date desc"]];
    [listArray removeAllObjects];
    while([rs next]){
        int voaid = [rs intForColumn:@"voaid"];
        int paraid = [rs intForColumn:@"paraid"];
        NSString *collect = [rs objectForColumn:@"collect"];
        NSString *date = [rs objectForColumn:@"date"];
        
        VOAFav *voaFav = [[VOAFav alloc] initWithVoaId:voaid paraid:paraid collect:collect date:date];
//        NSMutableDictionary *myDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:voaid,@"voaid",paraid,@"paraid", nil];
        [listArray addObject:voaFav];
    }
    [rs close];
//    return listArray;
}

+ (BOOL) isExist:(NSInteger) voaid paraid:(NSInteger)paraid{
    PLSqliteDatabase *dataBase = [favdatabase setup];
    
	id<PLResultSet> rs;
	NSString *findSql = [NSString stringWithFormat:@"select * FROM fav WHERE voaid = %d and paraid = %d", voaid, paraid];
	rs = [dataBase executeQuery:findSql];
	BOOL flg = NO;
	if([rs next]) {
        flg = YES;
	}
	else {
        //		UIAlertView *errAlert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Can not find!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //		[errAlert show];
	}
	
	[rs close];
    //	[voaDetail release];
	return flg;	
}

+ (NSInteger) countOfCollected {
    PLSqliteDatabase *dataBase = [favdatabase setup];
    id<PLResultSet> rs;
    NSString *findSql = [NSString stringWithFormat:@"select count(collect) collectCount FROM fav where collect=1"];
    rs = [dataBase executeQuery:findSql];
    NSInteger count = 0;
    if([rs next]) {
        count = [[rs objectForColumn:@"collectCount"] integerValue];
    }
    [rs close];
    return count;
}



//+ (NSArray *) findAll{
//	PLSqliteDatabase *dataBase = [favdatabase setup];
//	
//	id<PLResultSet> rs;
//	rs = [dataBase executeQuery:@"SELECT * FROM fav order by date desc"];
//    
//	//定义一个数组存放所有信息
//	NSMutableArray *voaFavs = [[NSMutableArray alloc] init];
//	
//	//把rs中的数据库信息遍历到voaViews数组
//	while ([rs next]) {
//        NSString *voaid = [rs objectForColumn:@"voaid"];
//        NSString *collect = [rs objectForColumn:@"collect"];
//        NSString *date = [rs objectForColumn:@"date"];
//        //        NSString *title_cn = [rs objectForColumn:@"title_cn"];
//        //        NSString *title_jp = [rs objectForColumn:@"title_jp"];
//        //		NSString *collect = [rs objectForColumn:@"collect"];
//        
//        VOAFav *voaFav = [[VOAFav alloc] initWithVoaId:voaid collect:collect date:date];
//		[voaFavs addObject:voaFav];
//		
//		[voaFav release];  
//	}
//	//关闭数据库
//	[rs close];
//    //	[dataBase close];//
//	return voaFavs;
//}
@end
