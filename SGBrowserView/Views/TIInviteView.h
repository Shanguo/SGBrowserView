//
//  TIInviteView.h
//  Toing_Test
//
//  Created by 刘山国 on 2016/11/2.
//  Copyright © 2016年 dufei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TIInviteView : UIView

- (instancetype)initWithNickName:(NSString *)nickName doneBlock:(void(^)(TIInviteView *view,NSInteger confirmIndex,NSString *text))block;

- (void)setResult:(BOOL)result;
- (void)setResult:(BOOL)result Msg:(NSString *)message;

@end
