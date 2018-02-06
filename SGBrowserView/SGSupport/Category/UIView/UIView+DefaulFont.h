//
//  UIView+DefaulFont.h
//  SGFont
//
//  Created by 刘山国 on 16/7/26.
//  Copyright © 2016年 山国. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 *  全局（整个app）设置UILabel,UITextField,UITextView默认字体，不包括UIBarButtonItem等，
 *  runtime方式。
 *  注意修改字体大小的时候不要用systemFontSize，会改变字体
 */


static NSString * const kDefaultFontName = @"FZLanTingHei-R-GBK";//默认字体名

@interface UIView (DefaulFont)

- (void)setFontSize:(CGFloat)fontSize;

@end
