//
//  ViewController.m
//  SGBrowserView
//
//  Created by 刘山国 on 2018/2/6.
//  Copyright © 2018年 山国. All rights reserved.
//

#import "ViewController.h"
#import "SGBrowserView.h"
#import "TIInviteView.h"
#import "TISendMessageView.h"
#import "TIDeliveryView.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,copy  ) NSArray *titles;
@property (nonatomic,strong) UIView                 *selectShareView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titles = @[@"弹出缩放View1", @"弹出缩放View2", @"弹出移动View1", @"弹出移动View2"];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kDefaultCellID];
}

#pragma mark -
#pragma mark - TableView Delegates DataSources
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kDefaultCellID];
    cell.textLabel.text = self.titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            TIInviteView *inviteView = [[TIInviteView alloc] initWithNickName:@"nickName" doneBlock:nil];
            [SGBrowserView showZoomView:inviteView];
        }
            break;
        case 1: {
            TIDeliveryView *deliveryView = [[TIDeliveryView alloc] init];
            [SGBrowserView showZoomView:deliveryView yDistance:20];
            [SGBrowserView setCanAutoHide:NO]; // 点X时TIDeliveryView 内部响应，手动触发hide
        }
            break;
        case 2: {
            TISendMessageView *messageView = [[TISendMessageView alloc] initWithDoneBlock:nil];
            CGPoint showCenter = CGPointMake(SCREEN_WIDTH/2,SCREEN_HEIGHT-messageView.mheight/2);
            [SGBrowserView showMoveView:messageView moveToCenter:showCenter];
        }
            break;
        case 3:
            [SGBrowserView showMoveView:self.selectShareView];
            break;
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


#pragma mark -
#pragma mark - Actions

- (void)selecteShareBtnClick:(UIButton *)btn {
    NSLog(@"分享%ld",(long)btn.tag);
}

#pragma mark -
#pragma mark - Getters

- (UIView *)selectShareView{
    if (!_selectShareView) {
        CGFloat width = 220*XScale;
        CGFloat height = 105 *YScale+100*YScale;
        CGFloat x = (SCREEN_WIDTH-width)/2;
        _selectShareView = [[UIView alloc]initWithFrame:CGRectMake(x, SCREEN_HEIGHT, width, height)];
        //        [_selectShareView setBackgroundColor:[UIColor clearColor]];
        
        CGFloat btnHW = 65*XScale;
        CGFloat edge = 15*XScale;
        UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, btnHW, btnHW)];
        [btn1 setTag:1];
        [btn1 image:[UIImage imageNamed:@"biography_works"]];
        [btn1 setBackgroundColor:[UIColor whiteColor]];
        [btn1 setCircleRadius:btnHW/2];
        [btn1 setContentEdgeInsets:UIEdgeInsetsMake(edge, edge, edge, edge)];
        [btn1 addTarget:self Listener:@selector(selecteShareBtnClick:)];
        [_selectShareView addSubview:btn1];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(btn1.minX, btn1.maxY+8*YScale, btnHW, 21)];
        [label1 setText:@"共享作品"];
        [label1 setFont:[UIFont systemFontOfSize:15*YScale]];
        [label1 setTextColor:[UIColor whiteColor]];
        [_selectShareView addSubview:label1];
        
        UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(_selectShareView.mwidth-btnHW, 0, btnHW, btnHW)];
        [btn2 setTag:2];
        [btn2 image:[UIImage imageNamed:@"circle_photos"]];
        [btn2 setBackgroundColor:[UIColor whiteColor]];
        [btn2 setCircleRadius:btnHW/2];
        [btn2 setContentEdgeInsets:UIEdgeInsetsMake(edge, edge, edge, edge)];
        [btn2 addTarget:self Listener:@selector(selecteShareBtnClick:)];
        [_selectShareView addSubview:btn2];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(btn2.minX, btn2.maxY+8*YScale, btnHW, 21)];
        [label2 setText:@"共享照片"];
        [label2 setFont:[UIFont systemFontOfSize:15*YScale]];
        [label2 setTextColor:[UIColor whiteColor]];
        [_selectShareView addSubview:label2];
        
        
    }
    return _selectShareView;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
