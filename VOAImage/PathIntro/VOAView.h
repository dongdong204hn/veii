//
//  VOAView.h
//  VOA
//  新闻信息数据类
//  Created by song zhao on 12-2-3.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RegexKitLite.h"
#import "VOAView.h"
//#import "VOAContent.h"
//#import "VOAFav.h"

@interface VOAView : NSObject
{
    NSInteger _voaid; //同一天的新闻id相同
    NSInteger _paraid; //同一天的新闻的序号
    NSString *_title; //英文内容
    NSString *_title_Cn; //中文内容
    NSString *_descCn; //解析
    NSString *_pic; //图片url
    NSString *_creatTime; //发布时间
    NSInteger _isRead; //是否已读
    NSInteger _isDownload; //标记是否正在下载 1：音频已缓存到本地
    NSInteger _userid; //被选为图片之声的用户id
    NSString *_sound; //声音url
    NSString *_userName; //图片之声用户名
    NSString *_userImgUrl; //图片之声用户头像
//    NSString *_title_cn;
//    NSString *_title_jp;
    
    

}

@property NSInteger voaid;
@property NSInteger paraid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *title_Cn;
@property (nonatomic, strong) NSString *descCn;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSString *creatTime;
//@property NSInteger readCount;
@property NSInteger isRead;
@property NSInteger isDownload;
@property NSInteger userid;
@property (nonatomic, strong) NSString *sound;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userImgUrl;

//@property (nonatomic, retain) NSString *_title_jp;

- (BOOL) insert;

//全赋值初始化VOAView对象
//<<<<<<< HEAD
- (id) initWithVoaId: (NSInteger)voaid paraid: (NSInteger)paraid title: (NSString *)title title_Cn: (NSString *)title_Cn descCn: (NSString *)descCn pic: (NSString *)pic  creatTime: (NSString *)creatTime isRead: (NSInteger)isRead isDownload: (NSInteger)isDownload userid: (NSInteger)userid sound: (NSString *)sound userName: (NSString *)userName userImgUrl: (NSString *)userImgUrl ;

+ (NSInteger) findNew:(NSInteger)offset newVoas:(NSMutableArray *) newVoas;

+ (NSInteger) findNewByVoaid: (NSInteger)voaid myArray:(NSMutableArray *) myArray;

+ (NSInteger) findNewByVoaidParaid: (NSInteger)voaid paraid:(NSInteger)paraid myArray:(NSMutableArray *) myArray;
//=======
- (id)initWithVoaId: (NSInteger)voaid paraid: (NSInteger)paraid title: (NSString *)title title_Cn: (NSString *)title_Cn descCn: (NSString *)descCn pic: (NSString *)pic  creatTime: (NSString *)creatTime readCount: (NSInteger)readCount isRead: (NSInteger)isRead isDownload: (NSInteger)isDownload userid: (NSInteger)userid sound: (NSString *)sound userName: (NSString *)userName userImgUrl: (NSString *)userImgUrl ;
//>>>>>>> 416dbaff103c1c4eac6d20b8d1b53791ec71a232

+ (NSInteger) findNewBelowVoaid: (NSInteger)voaid myArray:(NSMutableArray *) myArray  offset:(NSInteger)offset;

+ (NSInteger) findNewBelowVoaidParaid: (NSInteger)voaid paraid:(NSInteger)paraid myArray:(NSMutableArray *) myArray offset:(NSInteger)offset;

//查找并返回指定id的对象
+ (id) find:(NSInteger)voaid paraid: (NSInteger)paraid;

- (void)updateImgSound;

- (void)updateByVoaid;

+ (BOOL) isSimilar:(NSInteger) voaid search:(NSString *) search;

+ (NSString *) getContent:(NSInteger) voaid;

//+ (NSMutableArray *) findFavSimilar:(NSArray *) favsArray search:(NSString *) search;

+ (int) numberOfMatch:(NSString *) sentence search:(NSString *)search;

+ (NSInteger) findLastId;

//+ (void) alterRead:(NSInteger)voaid;

+ (NSMutableArray *) findDownloading;

//+ (void) alterDownload:(NSInteger)voaid;

//+ (void) deleteByVoaid:(NSInteger)voaid;

//+ (void) clearDownload:(NSInteger)voaid;

+ (void) clearAllDownload;

+ (BOOL) isDownloading:(NSInteger)voaid;

+ (BOOL) isVoaidExist: (NSInteger)voaid;

+ (BOOL) isExist: (NSInteger)voaid paraid: (NSInteger)paraid;

+ (NSArray *) getList:(NSMutableArray *)listArray category:(NSInteger)category;

+ (BOOL) isRead:(NSInteger)voaid;

//+ (void) alterReadCount:(NSInteger)voaid count:(NSInteger)count;

+ (NSInteger) findReadCount:(NSInteger)voaid;

+ (NSInteger) countOfReaded;

+ (NSInteger) findLoveClass;

//查找并返回全部对象
//+ (NSMutableArray *) findAll;

//+ (NSMutableArray *) findVoaBetween:(NSInteger)max mix:(NSInteger)mix;
//+ (NSMutableArray *) findNew:(NSInteger)offset;
//+ (NSMutableArray *) findByCategory:(NSString *) category;

//+ (NSMutableArray *) findDate;

//+ (NSMutableArray *) findDateByCategory:(NSString *) category;

//+ (NSMutableArray *) findByDate:(NSString *) Date;

//+ (NSInteger) findNumberByDate:(NSString *) Date;

//+ (NSMutableArray *) findByCategoryDate:(NSString *) Date category:(NSString *) category;
//+ (NSMutableArray *) findSimilar:(NSArray *) voasArray search:(NSString *) search progressBar:progressView;
//+ (NSMutableArray *) findAfterByCategory:(NSInteger)voaid;
//+ (NSMutableArray *) findSimilar:(NSArray *) voasArray search:(NSString *) search;

@end
