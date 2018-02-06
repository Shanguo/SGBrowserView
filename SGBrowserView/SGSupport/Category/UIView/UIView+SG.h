//
//  UIView+SG.h
//  Toing
//
//  Created by Rdd7 on 7/5/15.
//  Copyright (c) 2015 bibibi. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <objc/runtime.h>

@interface UIView(SG)

/**
 *  设置View的圆角
 *
 *  @param radius 圆角半径
 */
- (void)setCircleRadius:(CGFloat)radius;

- (void)setBorderWidth:(CGFloat)width Color:(UIColor*)color;

/**
 *  快捷方法，获取view的x,y,width,height等
 *
 *  return CGFloat
 */
//CGFloat widthOf(id view);
- (CGFloat)mwidth;
- (CGFloat)mheight;
- (CGFloat)minX;
- (CGFloat)midX;
- (CGFloat)maxX;
- (CGFloat)minY;
- (CGFloat)midY;
- (CGFloat)maxY;

@end
