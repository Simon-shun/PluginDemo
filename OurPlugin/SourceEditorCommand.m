//
//  SourceEditorCommand.m
//  OurPlugin
//
//  Created by wxs on 2017/11/3.
//  Copyright © 2017年 王希顺. All rights reserved.
//

#import "SourceEditorCommand.h"
#import "SourceEditorExtension.h"

@implementation SourceEditorCommand

- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation completionHandler:(void (^)(NSError * _Nullable nilOrError))completionHandler
{
    NSDate *starTime = [[NSUserDefaults standardUserDefaults] valueForKey:@"StarTimes"];
    NSDate *stopTime = [[NSUserDefaults standardUserDefaults] valueForKey:@"StopTimes"];
     
    XCSourceTextRange *selection = invocation.buffer.selections.firstObject;
    NSInteger lineIndex = selection.start.line;//行
    NSString *lineText = invocation.buffer.lines[lineIndex];//行的文本
    NSArray *lines = invocation.buffer.lines;
    
    if (VerifyInstanceMethod(lineText)) {
        [invocation.buffer.lines removeObjectAtIndex:lineIndex];//删除光标所在行，后面有自定义
        NSArray *array = AutomatedCompletionWithClsAndProperty(starTime, stopTime);
        for (NSInteger index = 0; index <= array.count - 1; index++ ) {
            NSString *string = array[index];
            [invocation.buffer.lines insertObject:string atIndex:lineIndex + index];
        }
    }
    
    completionHandler(nil);
}
static inline NSArray *AutomatedCompletionWithClsAndProperty(NSDate *starTime, NSDate *stopTime) {
    
    NSMutableArray *array = @[].mutableCopy;
    NSString *starSting = [NSString stringWithFormat:@"开始于:%@",getTimesStringWithDate(starTime)];
    NSString *contentModeString = dateTimeDifferenceWithStartTime(starTime,stopTime);
    [array addObject:starSting];
    [array addObject:contentModeString];
    
    return array.copy;
}

static inline BOOL VerifyInstanceMethod(NSString *string) {
    if ([string hasPrefix:@" "]) {
        return YES;
    }
    return NO;
}
//计算时间差
static inline NSString *dateTimeDifferenceWithStartTime(NSDate *startD,NSDate *endD) {
//    NSDateFormatter *date = [[NSDateFormatter alloc]init];
//    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSDate *startD =[date dateFromString:startTime];
//    NSDate *endD = [date dateFromString:endTime];
    NSTimeInterval start = [startD timeIntervalSince1970]*1;
    NSTimeInterval end = [endD timeIntervalSince1970]*1;
    NSTimeInterval value = end - start;
    int second = (int)value %60;//秒
    int minute = (int)value /60%60;
    int house = (int)value / (24 *3600)%3600;
    int day = (int)value / (24 *3600);
    NSString *str;
    if (day != 0) {
        str = [NSString stringWithFormat:@"您已使用Xcode %d天%d小时%d分%d秒",day,house,minute,second];
    }else if (day==0 && house !=0) {
        str = [NSString stringWithFormat:@"您已使用Xcode %d小时%d分%d秒",house,minute,second];
    }else if (day==0 && house==0 && minute!=0) {
        str = [NSString stringWithFormat:@"您已使用Xcode %d分%d秒",minute,second];
    }else{
        str = [NSString stringWithFormat:@"您已使用Xcode %d秒",second];
    }
    return str;
}


//格式化时间
static inline NSString *getTimesStringWithDate(NSDate*date){
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"dd HH:mm:ss"];
    NSString *TimesString = [formatter stringFromDate:date];
        return TimesString;
}

@end
