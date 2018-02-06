//
//  UIView+DefaulFont.m
//  SGFont
//
//  Created by 刘山国 on 16/7/26.
//  Copyright © 2016年 山国. All rights reserved.
//

#import "UIView+DefaulFont.h"
#import <objc/runtime.h>


@implementation UIView (DefaulFont)

/**
 *每个NSObject的子类都会调用下面这个方法 在这里将init方法进行替换，使用我们的新字体
 *如果在程序中又特殊设置了字体 则特殊设置的字体不会受影响 但是不要在Label的init方法中设置字体
 *从init和initWithFrame和nib文件的加载方法 都支持更换默认字体
 */
+(void)load{
    //只执行一次这个方法
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        // When swizzling a class method, use the following:
        // Class class = object_getClass((id)self);
        //替换三个方法
        SEL originalSelector = @selector(init);
        SEL originalSelector2 = @selector(initWithFrame:);
        SEL originalSelector3 = @selector(awakeFromNib);
        SEL swizzledSelector = @selector(baseInit);
        SEL swizzledSelector2 = @selector(baseInitWithFrame:);
        SEL swizzledSelector3 = @selector(baseAwakeFromNib);
        
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method originalMethod2 = class_getInstanceMethod(class, originalSelector2);
        Method originalMethod3 = class_getInstanceMethod(class, originalSelector3);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        Method swizzledMethod2 = class_getInstanceMethod(class, swizzledSelector2);
        Method swizzledMethod3 = class_getInstanceMethod(class, swizzledSelector3);
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        BOOL didAddMethod2 =
        class_addMethod(class,
                        originalSelector2,
                        method_getImplementation(swizzledMethod2),
                        method_getTypeEncoding(swizzledMethod2));
        BOOL didAddMethod3 =
        class_addMethod(class,
                        originalSelector3,
                        method_getImplementation(swizzledMethod3),
                        method_getTypeEncoding(swizzledMethod3));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
            
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        if (didAddMethod2) {
            class_replaceMethod(class,
                                swizzledSelector2,
                                method_getImplementation(originalMethod2),
                                method_getTypeEncoding(originalMethod2));
        }else {
            method_exchangeImplementations(originalMethod2, swizzledMethod2);
        }
        if (didAddMethod3) {
            class_replaceMethod(class,
                                swizzledSelector3,
                                method_getImplementation(originalMethod3),
                                method_getTypeEncoding(originalMethod3));
        }else {
            method_exchangeImplementations(originalMethod3, swizzledMethod3);
        }
    });
    
}
/**
 *在这些方法中将你的字体名字换进去
 */
- (instancetype)baseInit
{
    id __self = [self baseInit];
    [self defaultSettingFont];
    return __self;
}

-(instancetype)baseInitWithFrame:(CGRect)rect{
    id __self = [self baseInitWithFrame:rect];
    [self defaultSettingFont];
    return __self;
}
-(void)baseAwakeFromNib{
    [self baseAwakeFromNib];
    [self defaultSettingFont];
}


- (void)setFontSize:(CGFloat)fontSize{
    if ([self isKindOfClass:[UILabel class]] || [self isKindOfClass:[UITextView class]] || [self isKindOfClass:[UITextField class]]) {
        UIFont * font = [UIFont fontWithName:kDefaultFontName size:fontSize];
        if (font)  [((UILabel*)self) setFont:font];
    }
}

- (void)defaultSettingFont{
    if ([self isKindOfClass:[UILabel class]] || [self isKindOfClass:[UITextView class]] || [self isKindOfClass:[UITextField class]]) {
        UIFont * font = [UIFont fontWithName:kDefaultFontName size:((UILabel*)self).font.pointSize];
        if (font)  ((UILabel*)self).font = font;
    }
}


@end
