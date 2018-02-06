//
//  TIInviteView.m
//  Toing_Test
//
//  Created by 刘山国 on 2016/11/2.
//  Copyright © 2016年 dufei. All rights reserved.
//

#import "TIInviteView.h"

#define kYellowBtnColor RGB(249,216,68)
#define kGrayBtnColor RGB(218,222,222)

@interface TIInviteView()<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIView   *contentView;
@property (weak, nonatomic) IBOutlet UIView     *leftColorView;
@property (weak, nonatomic) IBOutlet UIView     *rightColorView;
@property (weak, nonatomic) IBOutlet UIView     *leftLineView;
@property (weak, nonatomic) IBOutlet UIView     *rightLineView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton   *confirmBtn;
@property (weak, nonatomic) IBOutlet UIView     *resultView;
@property (weak, nonatomic) IBOutlet UILabel    *resultLabel;
@property (weak, nonatomic) IBOutlet UIImageView *resultImageView;

@property (nonatomic,copy) void(^doneBlock)(TIInviteView *view,NSInteger confirmIndex,NSString *text);
@property (nonatomic,assign) NSInteger selectIndex;
@property (nonatomic,copy) NSMutableArray<NSString *> *texts;


@end

@implementation TIInviteView


- (instancetype)initWithNickName:(NSString *)nickName doneBlock:(void(^)(TIInviteView *view,NSInteger confirmIndex,NSString *text))block
{
    
    CGFloat w = SCREEN_WIDTH*0.772946859903382;
    self = [super initWithFrame:CGRectMake(0, 0, w, (140.0/320.0)*w)];
    if (self) {
        self.doneBlock = block;
        self.contentView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];//(owner:self ，firstObject必要)
        self.contentView.frame = self.bounds;
        [self addSubview:self.contentView];
        
        [self setCircleRadius:10];
        [self.leftColorView setCircleRadius:1];
        [self.rightColorView setCircleRadius:1];
        [self.textField setCircleRadius:5];
        [self.confirmBtn setCircleRadius:5];
        self.texts[0] = [NSString stringWithFormat:@"%@的圈子",nickName];
        [self.textField setText:self.texts[0]];
        [self.textField becomeFirstResponder];
    }
    return self;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
//    self.text = textField.text;
    self.texts[textField.tag] = textField.text;
}

- (IBAction)textFieldDidChange:(UITextField *)sender {
    if (sender.tag==1 && sender.text.length==4) [self.confirmBtn setBackgroundColor:kYellowBtnColor];
}




- (void)setBounds:(CGRect)bounds{
    [super setBounds:bounds];
    self.contentView.bounds = bounds;
}

- (void)setResult:(BOOL)result{
    [self.resultView setHidden:NO];
    NSString *info;
    NSString *s = self.selectIndex?@"加入":@"创建";
    NSString *r = result?@"成功":@"失败";
    [self.resultImageView setHidden:!result];
    if (result) {
        info = [NSString stringWithFormat:@"%@%@“%@”",r,s,self.textField.text];
    } else {
        info = [NSString stringWithFormat:@"%@圈子%@！",s,r];
    }
    [self.resultLabel setText:info];
  
}

- (void)setResult:(BOOL)result Msg:(NSString *)message{
    [self.resultView setHidden:NO];
    [self.resultImageView setHidden:!result];
    [self.resultLabel setText:message];
}

- (IBAction)selectTap:(UITapGestureRecognizer *)sender {
    NSInteger tag = sender.view.tag;
    self.selectIndex = tag;
    [self.leftColorView setHidden:tag];
    [self.rightColorView setHidden:!tag];
    [self.leftLineView setHidden:!tag];
    [self.rightLineView setHidden:tag];
    [self.confirmBtn title:tag?@"加入":@"创建"];
    [self.confirmBtn setBackgroundColor:tag?kGrayBtnColor:kYellowBtnColor];
    [self.textField setPlaceholder:tag?@"输入4位邀请码":@"圈子名称"];
    [self.textField setText:tag?@"":self.texts[tag]];
//    DLog(@"text==%@",self.textField.text);
    [self.textField setTag:tag];
}

- (IBAction)confirmBtnClick:(UIButton *)sender {
    [self.textField resignFirstResponder];
    if (self.doneBlock) self.doneBlock(self,self.selectIndex,self.textField.text);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [touches enumerateObjectsUsingBlock:^(UITouch * _Nonnull obj, BOOL * _Nonnull stop) {
        if (obj.view.tag !=1 && self.textField.isEditing) [self.textField resignFirstResponder];
    }];

}


- (NSMutableArray<NSString *> *)texts{
    if (!_texts) {
        _texts = [[NSMutableArray alloc]init];
        [_texts addObject:@""];
        [_texts addObject:@""];
    }
    return _texts;
}

@end
