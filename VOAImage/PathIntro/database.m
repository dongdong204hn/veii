//
//  database.m
//  TableTest
//
//  Created by Cui Celim on 11-11-14.
//  Copyright 2011 DMS. All rights reserved.
//

#import "database.h"

static PLSqliteDatabase * dbPointer;

@implementation database

/**
 *  announce the url don't need to be backed up to iCloud
 */
+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    const char* filePath = [[URL path] fileSystemRepresentation];
    
    const char* attrName = "com.apple.MobileBackup";
    u_int8_t attrValue = 1;
    
    int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
    return result == 0;
}

/*
+ (PLSqliteDatabase *) setup{
	
	if (dbPointer) {
		return dbPointer;
	}

	
	NSLog(@"%@",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES));
	NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSString *realPath = [documentPath stringByAppendingPathComponent:@"mydatabase.sqlite"];
    NSLog(@"realPath:%@",realPath);
	
	NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"voadata" ofType:@"sqlite"];
	
	NSLog(@"sourcePath:%@",sourcePath);
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	if (![fileManager fileExistsAtPath:realPath]) {
		NSError *error;
		if (![fileManager copyItemAtPath:sourcePath toPath:realPath error:&error]) {
			NSLog(@"%@",[error localizedDescription]);
		}
	}
	
	NSLog(@"复制sqlite到路径：%@成功。",realPath);
	
//	把dbpointer地址修改为可修改的realPath。
	dbPointer = [[PLSqliteDatabase alloc] initWithPath:realPath];
//	dbPointer = [[PLSqliteDatabase alloc] initWithPath:sourcePath];
	if ([dbPointer open]) {
		NSLog(@"open voa succeed!");
	};
	
	return dbPointer;
}*/

+ (PLSqliteDatabase *) setup{
	
	if (dbPointer) {
		return dbPointer;
	}
	
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"voadata" ofType:@"sqlite"];
	
    //	把dbpointer地址修改为可修改的realPath。
	dbPointer = [[PLSqliteDatabase alloc] initWithPath:sourcePath];
	
	if ([dbPointer open]) {
        //		NSLog(@"open fav succeed!");
	};
    
	return dbPointer;
}




+ (void) close{
	if (dbPointer) {
		[dbPointer close];
		dbPointer = NULL;
	}
}


@end

