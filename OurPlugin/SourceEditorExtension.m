//
//  SourceEditorExtension.m
//  OurPlugin
//
//  Created by wxs on 2017/11/3.
//  Copyright © 2017年 王希顺. All rights reserved.
//

#import "SourceEditorExtension.h"
#import "TimeModel.h"

#define StarTimes @"StarTimes"
#define StopTimes @"StopTimes"
#define preStarTimes @"preStarTimes"
#define kStarTimes [[NSUserDefaults standardUserDefaults] valueForKey:@"StarTimes"]
#define kStopTimes [[NSUserDefaults standardUserDefaults] valueForKey:@"StopTimes"]
#define kpreStarTimes [[NSUserDefaults standardUserDefaults] valueForKey:@"preStarTimes"]

@implementation SourceEditorExtension

- (void)extensionDidFinishLaunching
{
    NSDate *datenow = [NSDate date];
    [[NSUserDefaults standardUserDefaults] setValue:datenow forKey:StarTimes];
//    NSLog(@"star");
    dispatch_queue_t queue = dispatch_queue_create("tk.bourne.testQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        while (YES) {
            [self recordTheTime];
            sleep(10);
        }
    });
    
}

- (void)recordTheTime {
    
    NSDate *datenow = [NSDate date];
    [[NSUserDefaults standardUserDefaults] setValue:datenow forKey:StopTimes];
//    NSLog(@"add...");
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *cachepath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [cachepath stringByAppendingPathComponent:@"userInfo.json"];

    NSLog(@"%@",filePath);
    if(![fileManager fileExistsAtPath:filePath]){//如果不存在,则说明是第一次运行这个程序，那么建立这个文件夹
        NSLog(@"first run");
        NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        NSString *path = [filePath stringByAppendingPathComponent:@"userInfo.json"];
        NSLog(@"%@",path);
        NSError *error;
        [fileManager createFileAtPath:path contents:nil attributes:nil];
        NSLog(@"%@",error);
    }

    [self writeToJsonWithpath:filePath];
}


- (void)writeToJsonWithpath:(NSString*)filePath{
    
    NSMutableDictionary* rootDict = [self rootDictWithpath:filePath];

    BOOL isYes = [NSJSONSerialization isValidJSONObject:rootDict];
    if (isYes) {
        NSLog(@"可以转换");
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:rootDict options:0 error:NULL];
        [jsonData writeToFile:filePath atomically:YES];
        NSLog(@"%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
    } else {
        NSLog(@"JSON数据生成失败，请检查数据格式");
    }
}

- (NSMutableDictionary*)rootDictWithpath:(NSString*)filePath{
    //    获取字json字符串
    NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
    NSDictionary * rootObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSMutableDictionary *rootDict = [NSMutableDictionary dictionaryWithDictionary:rootObject];
    if (rootDict == nil) {
        rootDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    
    NSString*begin = [self getTimeWith:kStarTimes];
    NSString*end = [self getTimeWith:kStopTimes];
    NSMutableDictionary* userDic = [NSMutableDictionary dictionary];
    
    if (![kStarTimes isEqualTo:kpreStarTimes]) {
        [userDic setValue:begin forKey:StarTimes];
        [userDic setValue:end forKey:StopTimes];
        [rootDict setValue:userDic forKey:begin];
        
    }else{
        userDic = [NSMutableDictionary dictionaryWithDictionary: rootObject[[self getTimeWith:kStarTimes]]];
        [userDic setValue:begin forKey:StarTimes];
        [userDic setValue:end forKey:StopTimes];
        [rootDict setValue:userDic forKey:begin];
    }
    [rootDict setValue:userDic forKey:begin];
    [[NSUserDefaults standardUserDefaults] setValue:kStarTimes forKey:preStarTimes];
    
    return rootDict;
}


- (NSString*)getTimeWith:(NSDate*)date{
    // 实例化NSDateFormatter
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置日期格式
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // 获取当前日期
    NSString *dateString = [formatter stringFromDate:date];
    
    return dateString;
}


/*
- (NSArray <NSDictionary <XCSourceEditorCommandDefinitionKey, id> *> *)commandDefinitions
{
//    NSDictionary*dict = @{@"XCSourceEditorCommandName":@"插件",@"XCSourceEditorCommandIdentifier":@"control +option +space",@"XCSourceEditorCommandClassName":@"1111"};
//    NSLog(@"%@",commandDefinitions);
    
    return @[];
}
*/

@end
