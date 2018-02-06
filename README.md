# SGBrowserView

安装
==============

### CocoaPods

1. 在 Podfile 中添加  `pod 'SGBrowserView'`。
2. 执行 `pod install` 或 `pod update`。
3. 导入 `#import <SGBrowserView.h>`。


示例展示 Demo
==============

<img src="READMEIMAGES/弹出缩放View1.gif" width="200">
<img src="READMEIMAGES/弹出缩放View2.gif" width="200">
<img src="READMEIMAGES/弹出移动View1.gif" width="200">
<img src="READMEIMAGES/弹出移动View2.gif" width="200">

使用 Usage
==============

```

TIInviteView *inviteView = [[TIInviteView alloc] initWithNickName:@"nickName" doneBlock:nil];
[SGBrowserView showZoomView:inviteView];
            
```


API
==============

任意自定义的View自己做好约束，都可以使用此组件快速动画弹出。
用户自己初始化View的初始frame, 弹出隐藏后，自动恢复到View的初始Frame

```


/**
 *  动画弹出View 只有缩放！！在targetCenter缩放，showZoomView
 *
 *  param view 被弹出的view,设置其被弹出之前的frame,隐藏时自动还原的初始的frame
 *  param yDistance 不带targetCenter参数的方法可用这个调整主屏中心点（window.center.x,window.center.y*0.8+yDistance）
 *  param targetCenter 不带此参数的方法，默认中心点为 主屏中心点偏上 window.center.x,window.center.y*0.8， 使用此参数可以自定义缩放中心点
 *  @return SGBrowserView
 */
+ (instancetype)showZoomView:(UIView *)view targetCenter:(CGPoint)targetCenter;
+ (instancetype)showZoomView:(UIView *)view yDistance:(CGFloat)yDistance;
+ (instancetype)showZoomView:(UIView *)view;


/**
 *  动画弹出View，只有移动位置！！showMoveView
 *
 *  param view view
 *  param yDistance 不带moveToCenter参数的方法可用这个调整主屏中心点（window.center.x,window.center.y*0.8+yDistance）
 *  param targetCenter 不带此参数的方法，默认移动到主屏中心点偏上 window.center.x,window.center.y*0.8， 使用此参数可以自定义移动到的目标中心点
 *  @return SGBrowserView
 */
+ (instancetype)showMoveView:(UIView *)view moveToCenter:(CGPoint)targetCenter;
+ (instancetype)showMoveView:(UIView *)view yDistance:(CGFloat)yDistance;
+ (instancetype)showMoveView:(UIView *)view;



/**
 *  动画弹出View，自定义运动轨迹和大小变化
 */
+ (instancetype)showView:(UIView *)view fromFrame:(CGRect)fromFrame toFrame:(CGRect)toFrame;
+ (instancetype)showView:(UIView *)view fromCenter:(CGPoint)fromCenter toCenter:(CGPoint)toCenter fromBounds:(CGRect)fromBounds toBounds:(CGRect)toBounds;

/**
 *  手动隐藏方法
 */
+ (void)hide;

/**
 time s后隐藏
 */
+ (void)hideAfterDelay:(CGFloat)time;


/**
 设置点击背景 不自动隐藏

 @param canAutoHide canAutoHide
 */
- (void)setCanAutoHide:(BOOL)canAutoHide;
+ (void)setCanAutoHide:(BOOL)canAutoHide;


            
```