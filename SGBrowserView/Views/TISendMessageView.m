//
//  TISendMessageView.m
//  Toing_Test
//
//  Created by 刘山国 on 2016/11/2.
//  Copyright © 2016年 dufei. All rights reserved.
//

#import "TISendMessageView.h"

@interface TISendMessageView()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (nonatomic,copy) void(^doneBlock)(TISendMessageView *view,NSInteger selectedIndex);

@end

@implementation TISendMessageView


- (instancetype)initWithDoneBlock:(void(^)(TISendMessageView *view,NSInteger selectedIndex))block
{
    CGRect frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_WIDTH*(200.0/414.0));
    self = [super initWithFrame:frame];
    if (self) {
        self.doneBlock = block;
        self.contentView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];//(owner:self ，firstObject必要)
        self.contentView.frame = self.bounds;
        [self addSubview:self.contentView];
    }
    return self;
}

- (IBAction)selectTap:(UITapGestureRecognizer *)sender {
    if (self.doneBlock) self.doneBlock(self,sender.view.tag);
}
- (IBAction)cancelBtnClick:(UIButton *)sender {
     if (self.doneBlock) self.doneBlock(self,0);
}

@end
