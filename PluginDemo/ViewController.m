//
//  ViewController.m
//  PluginDemo
//
//  Created by wxs on 2017/11/3.
//  Copyright © 2017年 王希顺. All rights reserved.
//

#import "ViewController.h"



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self btnAction];
    
}

- (void)btnAction {
//    写入
//    NSString *homePath = NSHomeDirectory();
    
//    NSArray * paths = NSSearchPathForDirectoriesInDomains (NSCachesDirectory, NSUserDomainMask, YES);
//    NSString * homePath = [paths objectAtIndex:0];
//    NSArray *words = @[@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j", @"k", @"l", @"m", @"n", @"o", @"p", @"q", @"r", @"s", @"t", @"u", @"v", @"w", @"x", @"y", @"z"];
//    //获取设备缓存路径
//    NSString *cachePatch = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
////    NSString * cachePatch = @"/Users/wangxishun/Desktop";
//    //拼接file路径，最终数据存储到words.plist文件中
//    NSString *filePath = [cachePatch stringByAppendingPathComponent:@"words.plist"];
//    NSLog(@"%@",filePath);
//    [words writeToFile:filePath atomically:YES];
    
//    读取
    //第一种方法： NSFileManager实例方法读取数据
//    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES);
//    NSString* thepath = [paths lastObject];
//    NSString* thepath= @"/Users/wangxishun/Desktop";
//    thepath = [thepath stringByAppendingPathComponent:@"words.txt"];
//    NSLog(@"桌面目录：%@", thepath);
//    NSFileManager* fileManager = [NSFileManager defaultManager];
//    NSData* data = [[NSData alloc] init];
//    data = [fm contentsAtPath:thepath];
//    NSLog(@"%@",data);
    
//    NSDictionary *dic = [fileManager attributesOfItemAtPath:thepath error:nil];
//    NSLog(@"%@", dic);
    
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSString *str1 = NSHomeDirectory();
    NSString *filePath = @"/Users/wangxishun/Desktop/test.plist";

    NSLog(@"%@",filePath);
    if(![fileManager fileExistsAtPath:filePath]){//如果不存在,则说明是第一次运行这个程序，那么建立这个文件夹
        NSLog(@"first run");
        NSString *filePath = @"/Users/wangxishun/Desktop/";
        NSString *path = [filePath stringByAppendingPathComponent:@"test.plist"];
        NSLog(@"%@",path);
        NSError *error;
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        NSLog(@"%@",error);
    }
    
//    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES);
//    NSString* thepath = [paths lastObject];
//    NSLog(@"桌面目录：%@", thepath);
//
//    thepath = [thepath stringByAppendingPathComponent:@"testfolder"];
//    NSLog(@"桌面目录：%@", thepath);
//    NSFileManager* fm = [NSFileManager defaultManager];
//    BOOL b = [fm createDirectoryAtPath:thepath withIntermediateDirectories:NO attributes:nil error:nil];
//    thepath= [thepath stringByAppendingPathComponent:@"a.txt"];
//
//    NSData * data = [@"爱是恒久远" dataUsingEncoding:NSUTF8StringEncoding];
//    b = [fm createFileAtPath:thepath contents:data attributes:nil];
    
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
