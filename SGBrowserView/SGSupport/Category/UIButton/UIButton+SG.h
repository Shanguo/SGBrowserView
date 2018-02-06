//
//  UIButton+SG.h
//  ToingiOS
//
//  Created by 刘山国 on 15/11/5.
//  Copyright © 2015年 云葵科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonClickBlock)(UIButton *btn);

@interface UIButton (SG)

@property (nonatomic,copy  ) ButtonClickBlock block;

- (void)color:(UIColor*)color;
- (void)title:(NSString*)text;
- (void)font:(UIFont*)font;
- (void)image:(UIImage*)image;
- (void)backgroundImage:(UIImage*)image;
- (void)addTarget:(id)target Listener:(SEL)listener;
- (void)textLRAlignment:(UIControlContentHorizontalAlignment)alignment;
//-(void)onClick:(void(^)(UIButton *btn))onClick;
@end
