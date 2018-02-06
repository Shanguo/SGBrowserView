//
//  FunctionDefines.h
//  LLImagePickerController
//
//  Created by 雷亮 on 16/8/16.
//  Copyright © 2016年 Leiliang. All rights reserved.
//


//#define WeakSelf(self) \
//__weak typeof(self) weakSelf = self;
//
//#define StrongSelf(weakSelf) \
//__strong typeof(weakSelf) strongSelf = weakSelf;

#ifdef DEBUG
#define LLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define LLog(format, ...)
#endif

#ifndef Class
#define Class(className) NSClassFromString(@#className)
#endif

#ifndef Format
#define Format(...) [NSString stringWithFormat:__VA_ARGS__]
#endif

#ifndef Block_exe
#define Block_exe(block, ...) \
if (block) { \
    block(__VA_ARGS__); \
}
#endif

#if __has_feature(objc_arc)
    #define system_iOS_ARC
#else
    #define system_iOS_MRC
#endif

/** UIFont
 * @brief return UIFont object
 */
#define Font(x)          [UIFont systemFontOfSize : x]
#define ItalicFont(x)    [UIFont italicSystemFontOfSize:x]
#define BoldFont(x)      [UIFont boldSystemFontOfSize : x]

/** UIColor
 * @brief return UIColor object
 */
#define HEXCOLOR(hexValue)              [UIColor colorWithRed : ((CGFloat)((hexValue & 0xFF0000) >> 16)) / 255.0 green : ((CGFloat)((hexValue & 0xFF00) >> 8)) / 255.0 blue : ((CGFloat)(hexValue & 0xFF)) / 255.0 alpha : 1.0]

#define HEXACOLOR(hexValue, alphaValue) [UIColor colorWithRed : ((CGFloat)((hexValue & 0xFF0000) >> 16)) / 255.0 green : ((CGFloat)((hexValue & 0xFF00) >> 8)) / 255.0 blue : ((CGFloat)(hexValue & 0xFF)) / 255.0 alpha : (alphaValue)]

/** UIImage
 * @brief return UIImage object with param imageName
 */
#define loadImage(imageName) [UIImage imageNamed:imageName]

/**
 * @brief release UIView object to nil
 */
#ifndef Release_UIView
#define Release_UIView(__ref) \
{ \
    if (__ref) { \
        [__ref removeFromSuperview]; \
        __ref = nil; \
    } \
}
#endif

/**
 Synthsize a dynamic object property in @implementation scope.
 It allows us to add custom properties to existing classes in categories.
 
 @param association  ASSIGN / RETAIN / COPY / RETAIN_NONATOMIC / COPY_NONATOMIC
 @warning #import <objc/runtime.h>
 *******************************************************************************
 Example:
 @interface NSObject (MyAdd)
 @property (nonatomic, retain) UIColor *myColor;
 @end
 
 #import <objc/runtime.h>
 @implementation NSObject (MyAdd)
 YYSYNTH_DYNAMIC_PROPERTY_OBJECT(myColor, setMyColor, RETAIN, UIColor *)
 @end
 */
#ifndef YYSYNTH_DYNAMIC_PROPERTY_OBJECT
#define YYSYNTH_DYNAMIC_PROPERTY_OBJECT(_getter_, _setter_, _association_, _type_) \
- (void)_setter_ : (_type_)object { \
    [self willChangeValueForKey:@#_getter_]; \
    objc_setAssociatedObject(self, _cmd, object, OBJC_ASSOCIATION_ ## _association_); \
    [self didChangeValueForKey:@#_getter_]; \
} \
- (_type_)_getter_ { \
    return objc_getAssociatedObject(self, @selector(_setter_:)); \
}
#endif

#ifndef YYSYNTH_DYNAMIC_BASIC_PROPERTY_OBJECT
#define YYSYNTH_DYNAMIC_BASIC_PROPERTY_OBJECT(_getter_, _setter_, _association_, _type_) \
- (void)_setter_ : (_type_)object { \
    [self willChangeValueForKey:@#_getter_]; \
    objc_setAssociatedObject(self, _cmd, @(object), OBJC_ASSOCIATION_ ## _association_); \
    [self didChangeValueForKey:@#_getter_]; \
} \
- (_type_)_getter_ { \
    NSNumber *number = objc_getAssociatedObject(self, @selector(_setter_:)); \
    return [number longValue]; \
}
#endif


/**
 Synthsize a dynamic c type property in @implementation scope.
 It allows us to add custom properties to existing classes in categories.
 
 @warning #import <objc/runtime.h>
 *******************************************************************************
 Example:
 @interface NSObject (MyAdd)
 @property (nonatomic, retain) CGPoint myPoint;
 @end
 
 #import <objc/runtime.h>
 @implementation NSObject (MyAdd)
 YYSYNTH_DYNAMIC_PROPERTY_CTYPE(myPoint, setMyPoint, CGPoint)
 @end
 */
#ifndef YYSYNTH_DYNAMIC_PROPERTY_CTYPE
#define YYSYNTH_DYNAMIC_PROPERTY_CTYPE(_getter_, _setter_, _type_) \
- (void)_setter_ : (_type_)object { \
    [self willChangeValueForKey:@#_getter_]; \
    NSValue *value = [NSValue value:&object withObjCType:@encode(_type_)]; \
    objc_setAssociatedObject(self, _cmd, value, OBJC_ASSOCIATION_RETAIN); \
    [self didChangeValueForKey:@#_getter_]; \
} \
- (_type_)_getter_ { \
    _type_ cValue = { 0 }; \
    NSValue *value = objc_getAssociatedObject(self, @selector(_setter_:)); \
    [value getValue:&cValue]; \
    return cValue; \
}
#endif
