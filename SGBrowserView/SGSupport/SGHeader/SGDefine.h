//
//  SGDefine.h
//  ADCC
//
//  Created by 刘山国 on 16/6/7.
//  Copyright © 2016年 山国. All rights reserved.
//

#ifndef SGDefine_h
#define SGDefine_h

// 屏幕尺寸和比例
#define SCREEN_BOUNDS ([UIScreen mainScreen].bounds)
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define YScale (SCREEN_HEIGHT/736.0)
#define XScale (SCREEN_WIDTH/414.0)

// 状态栏、导航栏高度
#define STATUS_BAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height
#define NAVIGATION_BAR_HEIGHT 44.0
#define TAB_BAR_HEIGHT 49.0

// 系统版本
#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
//#define IOS8 [[[UIDevice currentDevice]systemVersion] floatValue] >= 8.0

// 颜色定义
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)
#define RGBS(sameRGB) RGB(sameRGB,sameRGB,sameRGB)

#define FontHelveticalNeue      @"HelveticaNeue"
#define FontHelveticalNeue_B    @"HelveticaNeue-Bold"

//#import "SGGlobal.h"
#import "UIButton+SG.h"
#import "UIView+SG.h"

#import "FunctionDefines.h"
#import "iPhoneVersion.h"

#define kDefaultCellID @"Cell"

// 默认字体名称
#define FontHelveticalNeue      @"HelveticaNeue"
#define FontHelveticalNeue_T    @"HelveticaNeue-Thin"
#define FontHelveticalNeue_B    @"HelveticaNeue-Bold"

// 常用Block
typedef void(^SGActionBlock)(UIView *view, id value, NSInteger index, NSInteger senderTag);
typedef void(^SGActionIPBlock)(UIView *view, id value, NSIndexPath *indexPath, NSInteger senderTag);


// 自定义Log
#ifdef DEBUG
//#define __FILENAME__ (strrchr(__FILE__, '/') ? (strrchr(__FILE__, '/') + 1):__FILE__)
//# define DLog(format, ...) NSLog((@"[文件名:%s]" "[函数名:%s]" "[行号:%d]" format), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
//# define DLog(format, ...) NSLog((@"文件:%s" "-第%d行-->" format), __FILENAME__, __LINE__, ##__VA_ARGS__);
#define DLog(FORMAT,...) fprintf(stderr,"文件：%s  行号: %d-->\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
# define DLog(...);
#endif

#endif /* SGDefine_h */
