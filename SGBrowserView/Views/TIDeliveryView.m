//
//  TIDeliveryView.m
//  Toing_Test
//
//  Created by 刘山国 on 2018/1/26.
//  Copyright © 2018年 dufei. All rights reserved.
//

#import "TIDeliveryView.h"
#import "SGBrowserView.h"

@interface TIDeliveryView()

@property (strong, nonatomic) IBOutlet UIView *contentView;

@end

@implementation TIDeliveryView

- (instancetype)init
{
    // 300, 440
    CGFloat w = SCREEN_WIDTH * 0.8;
    CGFloat h = w*(440.0/300.0);
    if (iPhone5s) h += 30;
    if (iPhone6) h += 10;
    if (iPhoneX) h += 15;
    CGRect frame = CGRectMake(0, 0, w, h);
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];//(owner:self ，firstObject必要)
        self.contentView.frame = self.bounds;
        [self.contentView setCircleRadius:8];
        [self addSubview:self.contentView];
        
    }
    return self;
}
- (IBAction)closeBtnClick:(id)sender {
    [SGBrowserView hide];
}
- (IBAction)cyBtnClick:(id)sender {
    [[UIPasteboard generalPasteboard] setString:self.deliveryNumberLabel.text];
//    SGHud(@"运单号复制成功！");
    NSLog(@"运单号复制成功！");
}

@end
