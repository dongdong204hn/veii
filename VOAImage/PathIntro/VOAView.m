//
//  VOAView.m
//  VOA
//
//  Created by song zhao on 12-2-3.
//  Copyright (c) 2012年 buaa. All rights reserved.
//


#import "VOAView.h"
#import "database.h"

@implementation VOAView

@synthesize voaid = _voaid;
@synthesize paraid = _paraid;
@synthesize title = _title;
@synthesize title_Cn = _title_Cn;
@synthesize descCn = _descCn;
@synthesize pic = _pic;
@synthesize creatTime = _creatTime;
//@synthesize readCount = _readCount;
@synthesize isRead = _isRead;
@synthesize isDownload = _isDownload;
@synthesize userid = _userid;
@synthesize sound = _sound;
@synthesize userName = _userName;
@synthesize userImgUrl = _userImgUrl;

//<<<<<<< HEADs
- (id) initWithVoaId: (NSInteger)voaid paraid: (NSInteger)paraid title: (NSString *)title title_Cn: (NSString *)title_Cn descCn: (NSString *)descCn pic: (NSString *)pic  creatTime: (NSString *)creatTime isRead: (NSInteger)isRead isDownload: (NSInteger)isDownload userid: (NSInteger)userid sound: (NSString *)sound userName: (NSString *)userName userImgUrl: (NSString *)userImgUrl{
//=======
//- (id)initWithVoaId: (NSInteger)voaid paraid: (NSInteger)paraid title: (NSString *)title title_Cn: (NSString *)title_Cn descCn: (NSString *)descCn pic: (NSString *)pic  creatTime: (NSString *)creatTime readCount: (NSInteger)readCount isRead: (NSInteger)isRead isDownload: (NSInteger)isDownload userid: (NSInteger)userid sound: (NSString *)sound userName: (NSString *)userName userImgUrl: (NSString *)userImgUrl {
//>>>>>>> 416dbaff103c1c4eac6d20b8d1b53791ec71a232
	if (self = [super init]) {
		_voaid = voaid;
        _paraid = paraid;
        _title = title;
        _title_Cn = title_Cn;
        _descCn = descCn;
        _pic = pic;
        _creatTime = creatTime;
//        _readCount = readCount;
        _isRead = isRead;
        _isDownload = isDownload;
        _userid = userid;
        _sound = sound;
        _userName = userName;
        _userImgUrl = userImgUrl;
	}
	return self;
}

/**
 *  插入数据
 */
- (BOOL) insert
{
    PLSqliteDatabase *dataBase = [database setup];
    //    const char *myDate = [date UTF8String];//NSString转变为字符数组
    //    date 显示为 2011-11-01%2012:12:12
	NSString *insertSql = [NSString stringWithFormat:@"insert into voa(voaid,paraid,Title,Title_cn,DescCn,pic,creatTime,isRead,isDownload,userid,sound,userName,userImgUrl) values(%d,%d,\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",%d,%d,%d,\"%@\",\"%@\",\"%@\") ;",self.voaid,self.paraid,self.title,self.title_Cn,self.descCn,self.pic,self.creatTime,self.isRead,self.isDownload,self.userid,self.sound,self.userName,self.userImgUrl];
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

/**
 *  获取小于offset的十个数据存入数组newVoas
 */
+ (NSInteger) findNew:(NSInteger)offset  newVoas:(NSMutableArray *) newVoas{
	PLSqliteDatabase *dataBase = [database setup];
	
	id<PLResultSet> rs;
    NSString *findSql = [NSString stringWithFormat:@"SELECT * FROM voa ORDER BY voaid desc,paraid LIMIT 10 offset %d;",offset];
	rs = [dataBase executeQuery:findSql];
    NSInteger addNum = 0;
//    NSLog(@"sql:%@",findSql);
	//定义一个数组存放所有信息
//	NSMutableArray *voaViews = [[NSMutableArray alloc] init];
    
	//把rs中的数据库信息遍历到voaViews数组
	while ([rs next]) {
        NSInteger voaid = [rs intForColumn:@"voaid"];
        NSInteger paraid = [rs intForColumn:@"paraid"];
        NSString *title = [rs objectForColumn:@"title"];
        NSString *title_Cn = [rs objectForColumn:@"title_Cn"];
        NSString *descCn = [rs objectForColumn:@"descCn"];
        NSString *pic = [rs objectForColumn:@"pic"];
//<<<<<<< HEAD
        NSString *creatTime;
//        NSInteger readCount = [rs intForColumn:@"readCount"];
//=======
//        NSInteger readCount = [rs intForColumn:@"readCount"];
//>>>>>>> 416dbaff103c1c4eac6d20b8d1b53791ec71a232
        NSInteger isRead = [rs intForColumn:@"isRead"];
        NSInteger isDownload = [rs intForColumn:@"isDownload"];
        NSInteger userid = [rs intForColumn:@"userid"];
        NSString *sound = [rs objectForColumn:@"sound"];
        NSString *userName = [rs objectForColumn:@"userName"];
        NSString *userImgUrl = [rs objectForColumn:@"userImgUrl"];
//<<<<<<< HEAD

//=======
//        
//        NSString *creatTime;
//>>>>>>> 416dbaff103c1c4eac6d20b8d1b53791ec71a232
        NSString *regEx = @"\\S+";
        for(NSString *matchOne in [[rs objectForColumn:@"creatTime"] componentsMatchedByRegex:regEx]) {
            creatTime = matchOne;
            break;
        }
        
        VOAView *voaView = [[VOAView alloc] initWithVoaId:voaid paraid:paraid title:title title_Cn:title_Cn descCn:descCn pic:pic creatTime:creatTime isRead:isRead isDownload:isDownload userid:userid sound:sound userName:userName userImgUrl:userImgUrl];
		[newVoas addObject:voaView];
        addNum++;
	}
	//关闭数据库
	[rs close];
    //	[dataBase close];//
	return addNum;
}

//<<<<<<< HEAD
+ (NSInteger) findNewByVoaid: (NSInteger)voaid myArray:(NSMutableArray *) myArray {
//=======
/**
 *  获取指定voaid的数据存入数组newVoas
 */
//+ (NSArray *) findByVoaid:(NSInteger)voaid  newVoas:(NSMutableArray *) newVoas{
//	PLSqliteDatabase *dataBase = [database setup];
//	
//	id<PLResultSet> rs;
//    NSString *findSql = [NSString stringWithFormat:@"SELECT * FROM voa ORDER BY paraid desc where voaid = %d;", voaid];
//	rs = [dataBase executeQuery:findSql];
//    //    NSLog(@"sql:%@",findSql);
//	//定义一个数组存放所有信息
//    //	NSMutableArray *voaViews = [[NSMutableArray alloc] init];
//    
//	//把rs中的数据库信息遍历到voaViews数组
//	while ([rs next]) {
//        NSInteger voaid = [rs intForColumn:@"voaid"];
//        NSInteger paraid = [rs intForColumn:@"paraid"];
//        NSString *title = [rs objectForColumn:@"title"];
//        NSString *title_Cn = [rs objectForColumn:@"title_Cn"];
//        NSString *descCn = [rs objectForColumn:@"descCn"];
//        NSString *pic = [rs objectForColumn:@"pic"];
//        NSInteger readCount = [rs intForColumn:@"readCount"];
//        NSInteger isRead = [rs intForColumn:@"isRead"];
//        NSInteger isDownload = [rs intForColumn:@"isDownload"];
//        NSInteger userid = [rs intForColumn:@"userid"];
//        NSString *sound = [rs objectForColumn:@"sound"];
//        NSString *userName = [rs objectForColumn:@"userName"];
//        NSString *userImgUrl = [rs objectForColumn:@"userImgUrl"];
//        
//        NSString *creatTime;
//        NSString *regEx = @"\\S+";
//        for(NSString *matchOne in [[rs objectForColumn:@"creatTime"] componentsMatchedByRegex:regEx]) {
//            creatTime = matchOne;
//            break;
//        }
//        
//        VOAView *voaView = [[VOAView alloc] initWithVoaId:voaid paraid:paraid title:title title_Cn:title_Cn descCn:descCn pic:pic creatTime:creatTime readCount:readCount isRead:isRead isDownload:isDownload userid:userid sound:sound userName:userName userImgUrl:userImgUrl];
//        //		[voaViews addObject:voaView];
//		[newVoas addObject:voaView];
//	}
//	//关闭数据库
//	[rs close];
//    //	[dataBase close];//
//	return newVoas;
//}
//
//+ (NSArray *) findNewByCategory:(NSInteger)offset category:(NSInteger)category myArray:(NSMutableArray *) myArray{
//>>>>>>> 416dbaff103c1c4eac6d20b8d1b53791ec71a232
	PLSqliteDatabase *dataBase = [database setup];
	id<PLResultSet> rs;
    NSString *findSql = [NSString stringWithFormat:@"SELECT * FROM voa where voaid <= %d ORDER BY voaid desc,paraid LIMIT 10;",voaid];
	rs = [dataBase executeQuery:findSql];
//    NSLog(@"sql:%@",findSql);
    
    
	//定义一个数组存放所有信息
//	NSMutableArray *voaViews = [[NSMutableArray alloc] init];
	NSInteger addNum = 0;
	//把rs中的数据库信息遍历到voaViews数组
	while ([rs next]) {
        NSInteger voaid = [rs intForColumn:@"voaid"];
        NSInteger paraid = [rs intForColumn:@"paraid"];
        NSString *title = [rs objectForColumn:@"title"];
        NSString *title_Cn = [rs objectForColumn:@"title_Cn"];
        NSString *descCn = [rs objectForColumn:@"descCn"];
        NSString *pic = [rs objectForColumn:@"pic"];
//<<<<<<< HEAD
        NSString *creatTime;
        //        NSInteger readCount = [rs intForColumn:@"readCount"];
//=======
//        NSInteger readCount = [rs intForColumn:@"readCount"];
//>>>>>>> 416dbaff103c1c4eac6d20b8d1b53791ec71a232
        NSInteger isRead = [rs intForColumn:@"isRead"];
        NSInteger isDownload = [rs intForColumn:@"isDownload"];
        NSInteger userid = [rs intForColumn:@"userid"];
        NSString *sound = [rs objectForColumn:@"sound"];
        NSString *userName = [rs objectForColumn:@"userName"];
        NSString *userImgUrl = [rs objectForColumn:@"userImgUrl"];
        
//<<<<<<< HEAD
//=======
//        NSString *creatTime;
//>>>>>>> 416dbaff103c1c4eac6d20b8d1b53791ec71a232
        NSString *regEx = @"\\S+";
        for(NSString *matchOne in [[rs objectForColumn:@"creatTime"] componentsMatchedByRegex:regEx]) {
            creatTime = matchOne;
            break;
        }
        
        VOAView *voaView = [[VOAView alloc] initWithVoaId:voaid paraid:paraid title:title title_Cn:title_Cn descCn:descCn pic:pic creatTime:creatTime isRead:isRead isDownload:isDownload userid:userid sound:sound userName:userName userImgUrl:userImgUrl];
		[myArray addObject:voaView];
        addNum++;
		
	}
	//关闭数据库
	[rs close];
    //	[dataBase close];//
	return addNum;
}

+ (NSInteger) findNewByVoaidParaid: (NSInteger)voaid paraid:(NSInteger)paraid myArray:(NSMutableArray *) myArray {
	PLSqliteDatabase *dataBase = [database setup];
	id<PLResultSet> rs;
    NSString *findSql = [NSString stringWithFormat:@"SELECT * FROM voa where (voaid = %d and paraid>=%d) or (voaid < %d)  ORDER BY voaid desc,paraid LIMIT 10;",voaid,paraid,voaid];
	rs = [dataBase executeQuery:findSql];
    //    NSLog(@"sql:%@",findSql);
    
    
	//定义一个数组存放所有信息
    //	NSMutableArray *voaViews = [[NSMutableArray alloc] init];
	NSInteger addNum = 0;
	//把rs中的数据库信息遍历到voaViews数组
	while ([rs next]) {
        NSInteger voaid = [rs intForColumn:@"voaid"];
        NSInteger paraid = [rs intForColumn:@"paraid"];
        NSString *title = [rs objectForColumn:@"title"];
        NSString *title_Cn = [rs objectForColumn:@"title_Cn"];
        NSString *descCn = [rs objectForColumn:@"descCn"];
        NSString *pic = [rs objectForColumn:@"pic"];
        NSString *creatTime;
        //        NSInteger readCount = [rs intForColumn:@"readCount"];
        NSInteger isRead = [rs intForColumn:@"isRead"];
        NSInteger isDownload = [rs intForColumn:@"isDownload"];
        NSInteger userid = [rs intForColumn:@"userid"];
        NSString *sound = [rs objectForColumn:@"sound"];
        NSString *userName = [rs objectForColumn:@"userName"];
        NSString *userImgUrl = [rs objectForColumn:@"userImgUrl"];
        
        NSString *regEx = @"\\S+";
        for(NSString *matchOne in [[rs objectForColumn:@"creatTime"] componentsMatchedByRegex:regEx]) {
            creatTime = matchOne;
            break;
        }
        
        VOAView *voaView = [[VOAView alloc] initWithVoaId:voaid paraid:paraid title:title title_Cn:title_Cn descCn:descCn pic:pic creatTime:creatTime isRead:isRead isDownload:isDownload userid:userid sound:sound userName:userName userImgUrl:userImgUrl];
		[myArray addObject:voaView];
        addNum++;
		
	}
	//关闭数据库
	[rs close];
    //	[dataBase close];//
	return addNum;
}

+ (NSInteger) findNewBelowVoaid: (NSInteger)voaid myArray:(NSMutableArray *) myArray offset:(NSInteger)offset{
	PLSqliteDatabase *dataBase = [database setup];
	id<PLResultSet> rs;
    NSString *findSql = [NSString stringWithFormat:@"SELECT * FROM voa where voaid <= %d ORDER BY voaid desc,paraid LIMIT 10 offset %d;", voaid, offset];
	rs = [dataBase executeQuery:findSql];
    //    NSLog(@"sql:%@",findSql);
    
    
	//定义一个数组存放所有信息
    //	NSMutableArray *voaViews = [[NSMutableArray alloc] init];
	NSInteger addNum = 0;
	//把rs中的数据库信息遍历到voaViews数组
	while ([rs next]) {
        NSInteger voaid = [rs intForColumn:@"voaid"];
        NSInteger paraid = [rs intForColumn:@"paraid"];
        NSString *title = [rs objectForColumn:@"title"];
        NSString *title_Cn = [rs objectForColumn:@"title_Cn"];
        NSString *descCn = [rs objectForColumn:@"descCn"];
        NSString *pic = [rs objectForColumn:@"pic"];
        NSString *creatTime;
        //        NSInteger readCount = [rs intForColumn:@"readCount"];
        NSInteger isRead = [rs intForColumn:@"isRead"];
        NSInteger isDownload = [rs intForColumn:@"isDownload"];
        NSInteger userid = [rs intForColumn:@"userid"];
        NSString *sound = [rs objectForColumn:@"sound"];
        NSString *userName = [rs objectForColumn:@"userName"];
        NSString *userImgUrl = [rs objectForColumn:@"userImgUrl"];
        
        NSString *regEx = @"\\S+";
        for(NSString *matchOne in [[rs objectForColumn:@"creatTime"] componentsMatchedByRegex:regEx]) {
            creatTime = matchOne;
            break;
        }
        
        VOAView *voaView = [[VOAView alloc] initWithVoaId:voaid paraid:paraid title:title title_Cn:title_Cn descCn:descCn pic:pic creatTime:creatTime isRead:isRead isDownload:isDownload userid:userid sound:sound userName:userName userImgUrl:userImgUrl];
		[myArray addObject:voaView];
        addNum++;
		
	}
	//关闭数据库
	[rs close];
    //	[dataBase close];//
	return addNum;
}

+ (NSInteger) findNewBelowVoaidParaid: (NSInteger)voaid paraid:(NSInteger)paraid myArray:(NSMutableArray *) myArray offset:(NSInteger)offset{
	PLSqliteDatabase *dataBase = [database setup];
	id<PLResultSet> rs;
    NSString *findSql = [NSString stringWithFormat:@"SELECT * FROM voa where (voaid = %d and paraid>=%d) or (voaid < %d)  ORDER BY voaid desc,paraid LIMIT 10 offset %d;", voaid, paraid, voaid, offset];
	rs = [dataBase executeQuery:findSql];
    //    NSLog(@"sql:%@",findSql);
    
    
	//定义一个数组存放所有信息
    //	NSMutableArray *voaViews = [[NSMutableArray alloc] init];
	NSInteger addNum = 0;
	//把rs中的数据库信息遍历到voaViews数组
	while ([rs next]) {
        NSInteger voaid = [rs intForColumn:@"voaid"];
        NSInteger paraid = [rs intForColumn:@"paraid"];
        NSString *title = [rs objectForColumn:@"title"];
        NSString *title_Cn = [rs objectForColumn:@"title_Cn"];
        NSString *descCn = [rs objectForColumn:@"descCn"];
        NSString *pic = [rs objectForColumn:@"pic"];
        NSString *creatTime;
        //        NSInteger readCount = [rs intForColumn:@"readCount"];
        NSInteger isRead = [rs intForColumn:@"isRead"];
        NSInteger isDownload = [rs intForColumn:@"isDownload"];
        NSInteger userid = [rs intForColumn:@"userid"];
        NSString *sound = [rs objectForColumn:@"sound"];
        NSString *userName = [rs objectForColumn:@"userName"];
        NSString *userImgUrl = [rs objectForColumn:@"userImgUrl"];
        
        NSString *regEx = @"\\S+";
        for(NSString *matchOne in [[rs objectForColumn:@"creatTime"] componentsMatchedByRegex:regEx]) {
            creatTime = matchOne;
            break;
        }
        
        VOAView *voaView = [[VOAView alloc] initWithVoaId:voaid paraid:paraid title:title title_Cn:title_Cn descCn:descCn pic:pic creatTime:creatTime isRead:isRead isDownload:isDownload userid:userid sound:sound userName:userName userImgUrl:userImgUrl];
		[myArray addObject:voaView];
        addNum++;
		
	}
	//关闭数据库
	[rs close];
    //	[dataBase close];//
	return addNum;
}

/**
 *  根据voaid获取对象的方法
 */
+ (id) find:(NSInteger)voaid paraid: (NSInteger)paraid{
	PLSqliteDatabase *dataBase = [database setup];
//    const char *myVoaid = [voaid UTF8String];//NSString转变为字符数组
//    int myVoaid = voaid.intValue;//NSString转变为整型
	id<PLResultSet> rs;
	NSString *findSql = [NSString stringWithFormat:@"select * FROM voa WHERE voaid = %d and paraid = %d", voaid, paraid];
	rs = [dataBase executeQuery:findSql];
	
	VOAView *voaView = nil;
	
	if([rs next]) {
        NSInteger voaid = [rs intForColumn:@"voaid"];
        NSInteger paraid = [rs intForColumn:@"paraid"];
        NSString *title = [rs objectForColumn:@"title"];
        NSString *title_Cn = [rs objectForColumn:@"title_Cn"];
        NSString *descCn = [rs objectForColumn:@"descCn"];
        NSString *pic = [rs objectForColumn:@"pic"];
//<<<<<<< HEAD
        NSString *creatTime;
        //        NSInteger readCount = [rs intForColumn:@"readCount"];
//=======
//        NSInteger readCount = [rs intForColumn:@"readCount"];
//>>>>>>> 416dbaff103c1c4eac6d20b8d1b53791ec71a232
        NSInteger isRead = [rs intForColumn:@"isRead"];
        NSInteger isDownload = [rs intForColumn:@"isDownload"];
        NSInteger userid = [rs intForColumn:@"userid"];
        NSString *sound = [rs objectForColumn:@"sound"];
        NSString *userName = [rs objectForColumn:@"userName"];
        NSString *userImgUrl = [rs objectForColumn:@"userImgUrl"];
        
//<<<<<<< HEAD
//=======
//        NSString *creatTime;
//>>>>>>> 416dbaff103c1c4eac6d20b8d1b53791ec71a232
        NSString *regEx = @"\\S+";
        for(NSString *matchOne in [[rs objectForColumn:@"creatTime"] componentsMatchedByRegex:regEx]) {
            creatTime = matchOne;
            break;
        }
        
        voaView = [[VOAView alloc] initWithVoaId:voaid paraid:paraid title:title title_Cn:title_Cn descCn:descCn pic:pic creatTime:creatTime isRead:isRead isDownload:isDownload userid:userid sound:sound userName:userName userImgUrl:userImgUrl];
	}
	else {
//		UIAlertView *errAlert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Can not find!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//		[errAlert show];
	}
	
	[rs close];
//	[dataBase close];//
    return voaView;
}

/**
 *  消除所有新闻的正在下载标记
 */
- (void)updateImgSound
{
    PLSqliteDatabase *dataBase = [database setup];
    NSString *findSql = [NSString stringWithFormat:@"update voa set sound = \"%@\", userid = %d, userName = \"%@\", userImgUrl = \"%@\" WHERE voaid = %d and paraid = %d;", _sound, _userid, _userName, _userImgUrl, _voaid, _paraid];
    NSLog(@"findSql:%@", findSql);
    if([dataBase executeUpdate:findSql]) {
        NSLog(@"--success!");
    }
}

/**
 *  消除所有新闻的正在下载标记
 */
- (void)updateByVoaid
{
    PLSqliteDatabase *dataBase = [database setup];
    NSString *findSql = [NSString stringWithFormat:@"update voa set title = \"%@\", title_cn = \"%@\", descCn = \"%@\", pic = \"%@\", creattime = \"%@\",  sound = \"%@\", userid = %d, userName = \"%@\", userImgUrl = \"%@\" WHERE voaid = %d and paraid = %d;", _title, _title_Cn, _descCn, _pic, _creatTime, _sound, _userid, _userName, _userImgUrl, _voaid, _paraid];
//    NSLog(@"updateByVoaidSql:%@", findSql);
    if([dataBase executeUpdate:findSql]) {
        NSLog(@"--success!");
    }
}

/**
 *  查询voaid的新闻内容是否包含关键字
 */
+ (BOOL) isSimilar:(NSInteger) voaid search:(NSString *) search
{
    PLSqliteDatabase *dataBase = [database setup];
	id<PLResultSet> rs;
    NSString *nowSearch = [[NSString alloc] initWithFormat:@"\"%%%@%%\"", search];
//    NSLog(@"%@", nowSearch);
	NSString *findSql = [NSString stringWithFormat:@"select * FROM voadetail WHERE voaid = %d and sentence like %@ order by paraid ", voaid, nowSearch];
//    NSLog(@"%@", findSql);
	rs = [dataBase executeQuery:findSql];
//    [nowSearch release];
	if ([rs next]) {
//        NSString *sentence = [rs objectForColumn:@"sentence"];
//        NSLog(@"%@", sentence);
        [rs close];
        return YES;
	}	
	
	return NO;	
}

/**
 *  获取文章标题
 */
+ (NSString *) getTitleContent:(NSInteger) voaid
{
    PLSqliteDatabase *dataBase = [database setup];
	id<PLResultSet> rs;
    NSString *findSql = [NSString stringWithFormat:@"select title FROM voa WHERE voaid = %d;", voaid];
	rs = [dataBase executeQuery:findSql];
    NSString *sentence = @"";
	if ([rs next]) {
        sentence = [rs objectForColumn:@"title"];
//        content = [content stringByAppendingString: sentence];
	}
    
	[rs close];
	return sentence;
}

/**
 *  获取文章内容
 */
+ (NSString *) getContent:(NSInteger) voaid
{
    PLSqliteDatabase *dataBase = [database setup];
	id<PLResultSet> rs;
    NSString *findSql = [NSString stringWithFormat:@"select sentence FROM voadetail WHERE voaid = %d order by paraid ", voaid];
	rs = [dataBase executeQuery:findSql];
    NSString *content = @"";
	while ([rs next]) {
        NSString *sentence = [rs objectForColumn:@"sentence"];
        content = [content stringByAppendingString: sentence];
	}
    
	[rs close];
	return content;
}

/**
 *  查询句子中字符串search出现的次数
 */
+ (int) numberOfMatch:(NSString *) sentence search:(NSString *)search
{
//    NSMutableString *source = [[NSMutableString alloc] init];
    NSMutableString *source = [NSMutableString stringWithString:sentence]; 
    NSRange substr = [source rangeOfString:search options:NSCaseInsensitiveSearch];   
    int number = 0;
    while (substr.location != NSNotFound) { 
//        NSLog(@"有！");
        [source replaceCharactersInRange:substr withString:@""]; 
        substr = [source rangeOfString:search options:NSCaseInsensitiveSearch]; 
        number++;
    } //字符串查找,可以判断字符串中是否有 
//       NSLog(@"%d", number);
    return number;
}

/**
 *  得到关键字搜索匹配结果列表，并排序
 */
/*+ (NSArray *) findFavSimilar:(NSArray *) favsArray search:(NSString *) search
{
    NSMutableArray *voaContents = [[NSMutableArray alloc] init];
    //    voaContents = nil;
    VOAView *voa = nil;
    NSInteger titleNum = 0;
    NSInteger number = 0;
    for (VOAFav *fav in favsArray) {
//        NSLog(@"%d", fav._voaid);
        voa = [VOAView find:fav._voaid];
        //		[voasArray addObject:voa];
        if ([self isSimilar:voa._voaid search:search]) {
            NSString *content = [self getContent:voa._voaid];
            NSString *titleCon = [self getTitleContent:voa._voaid];
            //            NSLog(@"%@", content);
            number = [self numberOfMatch:content search:search];
            titleNum = [self numberOfMatch:titleCon search:search];
            VOAContent *voaContent = [[VOAContent alloc] initWithVoaId:voa._voaid content:content title:[voa _title] creattime:[voa _creatTime] pic:[voa _pic] number:number titleNum:titleNum];
            [voaContents addObject:voaContent];
            [voaContent release], voaContent = nil;
        }
    }
    [voaContents sortUsingSelector:@selector(compareNumber:)];//对数组进行排序 
    return [voaContents autorelease];
    //    return [self QuickSort:voaContents left:0 right:([voaContents count]-1)];
    //    NSTimer *myTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(setProgress:) userInfo: repeats:<#(BOOL)#>]
    //    
}*/

+ (NSInteger) findLastId
{
    PLSqliteDatabase *dataBase = [database setup];
	id<PLResultSet> rs;
	NSString *findSql = [NSString stringWithFormat:@"select max(voaid) last from voa"];
	rs = [dataBase executeQuery:findSql];
    NSString *last = @"0";
	if([rs next]) {
        last = [rs objectForColumn:@"last"];
//        NSLog(@"%@", last);
	}
	else {
//		UIAlertView *errAlert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Can not find!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//		[errAlert show];
	}	
	[rs close];
    //	[dataBase close];//
	return last.integerValue;	

}

/**
 *  设置新闻已读
 */
/*
+ (void) alterRead:(NSInteger)voaid
{
    PLSqliteDatabase *dataBase = [database setup];
    if ([self find:voaid]) {
        NSString *findSql = [NSString stringWithFormat:@"update voa set IsRead = 1 WHERE voaid = %d ;",voaid];
        if([dataBase executeUpdate:findSql]) {
//            NSLog(@"--success!");
        }
        else {
//            UIAlertView *errAlert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Update failture!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [errAlert show];
        }
    }
}
*/

/**
 *  设置新闻听读数
 */
/*
+ (void) alterReadCount:(NSInteger)voaid count:(NSInteger)count
{
    PLSqliteDatabase *dataBase = [database setup];
    if ([self find:voaid]) {
        NSString *findSql = [NSString stringWithFormat:@"update voa set ReadCount = %d WHERE voaid = %d ;", count, voaid];
        if([dataBase executeUpdate:findSql]) {
            //            NSLog(@"--success!");
        }
        else {
            //            UIAlertView *errAlert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Update failture!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            //            [errAlert show];
        }
    }
}
*/
/**
 *
 */
+ (NSInteger) findReadCount:(NSInteger)voaid {
    PLSqliteDatabase *dataBase = [database setup];
    id<PLResultSet> rs;
    NSString *findSql = [NSString stringWithFormat:@"select ReadCount FROM voa WHERE voaid = %d", voaid];
    rs = [dataBase executeQuery:findSql];
    NSInteger count = 0;
    if([rs next]) {
        count = [[rs objectForColumn:@"ReadCount"] integerValue];
    }
    
    [rs close];
    return count;
}

/**
 *  获取正在下载的新闻列表
 */
+ (NSMutableArray *) findDownloading
{
    NSMutableArray *downLoadArray = [[NSMutableArray alloc]init];
    PLSqliteDatabase *dataBase = [database setup];
    id<PLResultSet> rs;
    NSString *findSql = [NSString stringWithFormat:@"select * FROM voa WHERE Downloading = 1"];
    rs = [dataBase executeQuery:findSql];
    if([rs next]) {
        NSNumber *iid = [rs objectForColumn:@"voaid"];
        [downLoadArray addObject:iid];
    }
    
    [rs close];
    return downLoadArray;
}

/**
 *  标记新闻正在下载
 */
/*
+ (void) alterDownload:(NSInteger)voaid
{
    PLSqliteDatabase *dataBase = [database setup];
    if ([self find:voaid]) {
        NSString *findSql = [NSString stringWithFormat:@"update voa set Downloading = 1 WHERE voaid = %d ;",voaid];
        if([dataBase executeUpdate:findSql]) {
//            NSLog(@"--success!");
        }
    }
}
*/
/**
 *  根据voaid删除新闻
 */
/*
+ (void) deleteByVoaid:(NSInteger)voaid {
//    NSLog(@"删除标题-%d",voaid);
    PLSqliteDatabase *dataBase = [database setup];
    if ([self find:voaid]) {
        NSString *findSql = [NSString stringWithFormat:@"delete from voa where voaid = %d ;",voaid];
        if([dataBase executeUpdate:findSql]) {
            //            NSLog(@"--success!");
        }
    }
}
*/
/**
 *  消除指定voaid的新闻的已下载标记
 */
/*
+ (void) clearDownload:(NSInteger)voaid
{
    PLSqliteDatabase *dataBase = [database setup];
    if ([self find:voaid]) {
        NSString *findSql = [NSString stringWithFormat:@"update voa set Downloading = 0 WHERE voaid = %d ;",voaid];
        if([dataBase executeUpdate:findSql]) {
//            NSLog(@"--success!");
        }
    }
}
*/
/**
 *  消除所有新闻的正在下载标记
 */
+ (void) clearAllDownload
{
    PLSqliteDatabase *dataBase = [database setup];
    NSString *findSql = @"update voa set Downloading = 0 WHERE Downloading = 1;";
    if([dataBase executeUpdate:findSql]) {
        //            NSLog(@"--success!");
    }
}

/**
 *  查询指定voaid的新闻是否正在下载
 */
+ (BOOL) isDownloading:(NSInteger)voaid
{
    PLSqliteDatabase *dataBase = [database setup];
    id<PLResultSet> rs;
    NSString *findSql = [NSString stringWithFormat:@"select Downloading FROM voa WHERE voaid = %d", voaid];
    rs = [dataBase executeQuery:findSql];
    BOOL downLoad = NO;
    if([rs next]) {
        NSString *Downloading = [rs objectForColumn:@"Downloading"];
        downLoad = [Downloading isEqualToString:@"1"];
    }
    
    [rs close];
    return downLoad;
}

/**
 *  查询某天新闻是否存在
 */
+ (BOOL) isVoaidExist: (NSInteger)voaid{
    PLSqliteDatabase *dataBase = [database setup];
    
	id<PLResultSet> rs;
	NSString *findSql = [NSString stringWithFormat:@"select voaid FROM voa WHERE voaid = %d", voaid];
	rs = [dataBase executeQuery:findSql];
	BOOL flg = NO;
	if([rs next]) {
        flg = YES;
	}
	else {
	}
	
	[rs close];
	return flg;	
}

/**
 *  查询某篇新闻是否存在
 */
+ (BOOL) isExist: (NSInteger)voaid paraid: (NSInteger)paraid{
    PLSqliteDatabase *dataBase = [database setup];
    
	id<PLResultSet> rs;
	NSString *findSql = [NSString stringWithFormat:@"select voaid FROM voa WHERE voaid = %d and paraid = %d", voaid, paraid];
	rs = [dataBase executeQuery:findSql];
	BOOL flg = NO;
	if([rs next]) {
        flg = YES;
	}
	else {
	}
	
	[rs close];
	return flg;
}

/**
 *  获取指定类别的新闻列表
 */
+ (NSArray *) getList:(NSMutableArray *)listArray category:(NSInteger)category
{
    PLSqliteDatabase *dataBase = [database setup];
    id<PLResultSet>rs;
//    NSLog(@"获取列表:%@", category);
    if (category > 0) {
        rs = [dataBase executeQuery:[NSString stringWithFormat:@"select voaid from voa where category = %i order by voaid desc", category]];
    } else {
        rs = [dataBase executeQuery:[NSString stringWithFormat:@"select voaid from voa order by voaid desc"]];
    }
    [listArray removeAllObjects];
    while([rs next]){
        NSString * temp = [rs objectForColumn:@"voaid"];
        [listArray addObject:temp];
    }
    [rs close];
    return listArray;
}

/**
 *  查询指定新闻是否已读
 */
+ (BOOL) isRead:(NSInteger)voaid
{
    PLSqliteDatabase *dataBase = [database setup];
    id<PLResultSet> rs;
    NSString *findSql = [NSString stringWithFormat:@"select IsRead FROM voa WHERE voaid = %d", voaid];
    rs = [dataBase executeQuery:findSql];
    BOOL isRead = NO;
    if([rs next]) {
        NSString *Downloading = [rs objectForColumn:@"IsRead"];
        isRead = [Downloading isEqualToString:@"1"];
    }
    
    [rs close];
    return isRead;
}

/**
 *  查询已读的新闻数
 */
+ (NSInteger) countOfReaded {
    PLSqliteDatabase *dataBase = [database setup];
    id<PLResultSet> rs;
    NSString *findSql = [NSString stringWithFormat:@"select count(IsRead) readedCount FROM voa where IsRead=1"];
    rs = [dataBase executeQuery:findSql];
    NSInteger count = 0;
    if([rs next]) {
        count = [[rs objectForColumn:@"readedCount"] integerValue];
    }
    [rs close];
    return count;
}

/**
 *  获取已读新闻数最多的类别号
 */
+ (NSInteger) findLoveClass {
    PLSqliteDatabase *dataBase = [database setup];
    id<PLResultSet> rs;
    NSString *findSql = [NSString stringWithFormat:@"select category, count(category) count   FROM voa where IsRead=1 group by category  order by count desc"];
    rs = [dataBase executeQuery:findSql];
    NSInteger count = 0;
    if([rs next]) {
        count = [[rs objectForColumn:@"category"] integerValue];
    }
    [rs close];
    return count;
}

@end
