//
//  TISendMessageView.h
//  Toing_Test
//
//  Created by 刘山国 on 2016/11/2.
//  Copyright © 2016年 dufei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TISendMessageView : UIView

- (instancetype)initWithDoneBlock:(void(^)(TISendMessageView *view,NSInteger selectIndex))block;

@end
