//
//  UIButton+SG.m
//  ToingiOS
//
//  Created by 刘山国 on 15/11/5.
//  Copyright © 2015年 云葵科技. All rights reserved.
//

#import "UIButton+SG.h"

@implementation UIButton (SG)

//YYSYNTH_DYNAMIC_PROPERTY_OBJECT(btnClickBlock, setBtnClickBlock, COPY, ButtonClickBlock)

-(void)color:(nullable UIColor *)color{
    [self setTitleColor:color forState:UIControlStateNormal];
}

-(void)font:(UIFont *)font{
    self.titleLabel.font = font;
}

-(void)title:(NSString *)text{
    [self setTitle:text forState:UIControlStateNormal];
}

-(void)image:(UIImage *)image{
    [self setImage:image forState:UIControlStateNormal];
}

-(void)backgroundImage:(UIImage *)image{
    [self setBackgroundImage:image forState:UIControlStateNormal];
}

-(void)addTarget:(id)target Listener:(SEL)listener{
    [self addTarget:target action:listener forControlEvents:UIControlEventTouchUpInside];
}
//
//-(void)onClick:(void(^)(UIButton *btn))onClick{
//    self.block = onClick;
//    [self addTarget:self action:@selector(defaultBtnListener:) forControlEvents:UIControlEventTouchUpInside];
//}

- (void)defaultBtnListener:(UIButton *)btn {
    self.block(btn);
}

-(void)textLRAlignment:(UIControlContentHorizontalAlignment)alignment{
    self.contentHorizontalAlignment = alignment;
}


@end
