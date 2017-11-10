//
//  SourceEditorExtension.h
//  OurPlugin
//
//  Created by wxs on 2017/11/3.
//  Copyright © 2017年 王希顺. All rights reserved.
//

#import <XcodeKit/XcodeKit.h>

@interface SourceEditorExtension : NSObject <XCSourceEditorExtension>


@property(nonatomic,strong)NSTimer *timer;

@end
