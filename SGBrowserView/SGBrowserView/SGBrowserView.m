//
//  SGBrowserView.m
//  SGXibView
//
//  Created by 刘山国 on 2016/11/2.
//  Copyright © 2016年 山国. All rights reserved.
//

#import "SGBrowserView.h"

@interface SGBrowserView()

@property (nonatomic,weak)   UIView     *viewSuperView;
@property (nonatomic,weak)   UIView     *view;

@property (nonatomic,assign) CGRect     fromBounds;
@property (nonatomic,assign) CGPoint    fromCenter;
@property (nonatomic,assign) CGFloat    fromAlpha;

@property (nonatomic,assign) CGRect     toBounds;
@property (nonatomic,assign) CGPoint    toCenter;
@property (nonatomic,assign) CGFloat    toAlpha;

@property (nonatomic,assign) CGRect     originBounds;
@property (nonatomic,assign) CGPoint    originCenter;
@property (nonatomic,assign) CGFloat    originAlpha;

@property (nonatomic,assign) BOOL canAutoHide;


@end

@implementation SGBrowserView

#pragma mark - public

/**
 *  动画弹出View 只有缩放！！在targetCenter缩放，
 *
 *  param view 被弹出的view,设置其被弹出之前的frame,隐藏时自动还原的初始的frame
 *  param yDistance 不带targetCenter参数的方法可用这个调整主屏中心点（window.center.x,window.center.y*0.8+yDistance）
 *  param targetCenter 不带此参数的方法，默认中心点为 主屏中心点偏上 window.center.x,window.center.y*0.8， 使用此参数可以自定义缩放中心点
 *  @return SGBrowserView
 */
+ (instancetype)showZoomView:(UIView *)view {
    return [SGBrowserView showZoomView:view yDistance:0];
}
+ (instancetype)showZoomView:(UIView *)view targetCenter:(CGPoint)fixCenter {
    return [SGBrowserView showView:view fromCenter:fixCenter toCenter:fixCenter yDistance:0 willZoom:YES];
}
+ (instancetype)showZoomView:(UIView *)view yDistance:(CGFloat)yDistance{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGPoint fixCenter = CGPointMake(window.center.x, window.center.y*0.8);
    return [SGBrowserView showView:view fromCenter:fixCenter toCenter:fixCenter yDistance:yDistance willZoom:YES];
}

/**
 *  动画弹出View，只有移动位置！！showMoveView
 *
 *  param view view
 *  param yDistance 不带moveToCenter参数的方法可用这个调整主屏中心点（window.center.x,window.center.y*0.8+yDistance）
 *  param targetCenter 不带此参数的方法，默认移动到主屏中心点偏上 window.center.x,window.center.y*0.8， 使用此参数可以自定义移动到的目标中心点
 *  @return SGBrowserView
 */
+ (instancetype)showMoveView:(UIView *)view {
    return [SGBrowserView showMoveView:view yDistance:0];
}
+ (instancetype)showMoveView:(UIView *)view yDistance:(CGFloat)yDistance{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGPoint windowCenter = CGPointMake(window.center.x, window.center.y*0.8);
    return  [SGBrowserView showView:view fromCenter:view.center toCenter:windowCenter yDistance:yDistance willZoom:NO];
}
+ (instancetype)showMoveView:(UIView *)view moveToCenter:(CGPoint)toCenter {
    return [SGBrowserView showView:view fromCenter:view.center toCenter:toCenter yDistance:0 willZoom:NO];
}


+ (instancetype)showView:(UIView *)view fromCenter:(CGPoint)fromCenter toCenter:(CGPoint)toCenter yDistance:(CGFloat)yDistance willZoom:(BOOL)willZoom {
    CGPoint newToCenter = CGPointMake(toCenter.x,toCenter.y+yDistance);
    return [SGBrowserView showView:view fromCenter:fromCenter toCenter:newToCenter fromBounds:willZoom?CGRectZero:view.bounds toBounds:view.bounds];
}

/**
 *  动画弹出View，自定义运动轨迹和大小变化
 */
+ (instancetype)showView:(UIView *)view fromFrame:(CGRect)fromFrame toFrame:(CGRect)toFrame {
    CGPoint fromCenter = CGPointMake(CGRectGetMidX(fromFrame), CGRectGetMidY(fromFrame)) ;
    CGPoint toCenter = CGPointMake(CGRectGetMidX(toFrame), CGRectGetMidY(toFrame));
    CGRect fromBounds = CGRectMake(0, 0, CGRectGetWidth(fromFrame), CGRectGetHeight(fromFrame));
    CGRect toBounds = CGRectMake(0, 0, CGRectGetWidth(toFrame), CGRectGetHeight(toFrame));
    return [SGBrowserView showView:view fromCenter:fromCenter toCenter:toCenter fromBounds:fromBounds toBounds:toBounds];
}

+ (instancetype)showView:(UIView *)view fromCenter:(CGPoint)fromCenter toCenter:(CGPoint)toCenter fromBounds:(CGRect)fromBounds toBounds:(CGRect)toBounds {
    SGBrowserView *browserView =  [[SGBrowserView alloc] initWithView:view];
    browserView.fromCenter  = fromCenter;
    browserView.fromBounds  = fromBounds;
    browserView.toBounds    = toBounds;
    browserView.toCenter    = toCenter;
    [SGBrowserView showView:view browserView:browserView];
    return browserView;
}

/**
 非手势隐藏方法
 */
+ (void)hide{
    SGBrowserView *browserView = [[self class] searchSelfInWindow];
    if (browserView) [SGBrowserView hideSelf:browserView];
}


/**
 time s后隐藏
 */
+ (void)hideAfterDelay:(CGFloat)time{
    SGBrowserView *browserView = [[self class] searchSelfInWindow];
    if (browserView) [SGBrowserView performSelector:@selector(hideSelf:) withObject:browserView afterDelay:time];
}

+ (void)setCanAutoHide:(BOOL)canAutoHide{
    SGBrowserView *browserView = [[self class] searchSelfInWindow];
    if (browserView) [browserView setCanAutoHide:canAutoHide];
}

+ (SGBrowserView *)searchSelfInWindow{
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    for (SGBrowserView *browserView in window.subviews) {
        if ([browserView isKindOfClass:[SGBrowserView class]]) {
            return browserView;
            break;
        }
    }
    return nil;
}

#pragma mark - init

- (instancetype)initWithView:(UIView *)view {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self = [super initWithFrame:window.bounds];
    if (self) {
        // 设置默认
        self.alpha              = 0.0;
        self.backgroundColor    = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        self.canAutoHide            = YES;
        self.fromBounds     = view.bounds;
        
        // 获取原来view 属性
        self.view               = view;
        self.viewSuperView      = view.superview;
        self.originCenter       = view.center;
        self.originBounds       = view.bounds;
        self.originAlpha        = view.alpha;
        [self addSubview:view];
        
        // 添加到window
        [window addSubview:self];
    }
    return self;
}


#pragma mark - action
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    if (!self.canAutoHide) return;
    //获取所有的触摸位置
    UITouch *touch = [touches anyObject];

    //触摸在self上
    CGPoint point = [touch locationInView:self];

    CGRect frame = CGRectMake(self.toCenter.x-CGRectGetWidth(self.toBounds)/2, self.toCenter.y-CGRectGetHeight(self.toBounds)/2, CGRectGetWidth(self.toBounds), CGRectGetHeight(self.toBounds));
    if (!CGRectContainsPoint(frame, point)) {
        __weak typeof(self) weakSelf = self;
        [SGBrowserView hideSelf:weakSelf];
    }

}


+ (void)showView:(UIView *)view browserView:(SGBrowserView *)browserView{
    view.alpha  = browserView.fromAlpha;
    view.center = browserView.fromCenter;
    view.bounds = browserView.fromBounds;
    [UIView animateWithDuration:0.3 animations:^{//2. show
        view.center         = browserView.toCenter;
        view.bounds         = browserView.toBounds;
        view.alpha          = browserView.originAlpha;
        browserView.alpha   = 1;
    }];
}

+ (void)hideSelf:(SGBrowserView *)browserView{
    [UIView animateWithDuration:0.3 animations:^{//3. end
        browserView.alpha        = browserView.fromAlpha;
        browserView.view.alpha   = browserView.fromAlpha;
        browserView.view.center  = browserView.fromCenter;
        browserView.view.bounds  = browserView.fromBounds;
    } completion:^(BOOL finished) {// 4.origin
        if (browserView.viewSuperView) [browserView.viewSuperView addSubview:browserView.view];
        browserView.view.alpha   = browserView.originAlpha;
        browserView.view.center  = browserView.originCenter;
        browserView.view.bounds  = browserView.originBounds;
        [browserView removeFromSuperview];
    }];
}

@end
