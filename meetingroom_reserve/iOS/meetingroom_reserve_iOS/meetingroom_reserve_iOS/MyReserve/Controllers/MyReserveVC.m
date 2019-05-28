//
//  MyReserveVC.m
//  meetingroom_reserve_iOS
//
//  Created by 张文轩 on 2019/3/26.
//  Copyright © 2019 张文轩. All rights reserved.
//

#import "MyReserveVC.h"
#import "MeetingDetailVC.h"
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
@interface MyReserveVC ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation MyReserveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void) initUI{
    self.navigationItem.title = @"我的会议";
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    _datas = [NSMutableArray arrayWithCapacity:0];
    NSString *meeting1 = @"实B-206";
    NSString *meeting2 = @"实B-207";
//    NSString *meeting3 = @"实B-205";
    NSArray *arr = [NSArray arrayWithObjects:meeting2,meeting1, nil];
    [self.datas addObjectsFromArray:arr];
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor colorWithRed:228.0/255.0 green:229/255.0 blue:234/255.0 alpha:1.0];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellID"];
    }
    cell.textLabel.text = [self.datas objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellEditingStyleNone;
    if (indexPath.row == 0) {
        cell.detailTextLabel.text = @"14:00-15:00";
    }
    if (indexPath.row == 1) {
        cell.detailTextLabel.text = @"10:00-11:00";
    }
//    if (indexPath.row == 2) {
//        cell.detailTextLabel.text = @"9:00-10:00";
//    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    MeetingDetailVC *meetDetailVC = [sb instantiateViewControllerWithIdentifier:@"meetingDetail"];
    [self.navigationController pushViewController:meetDetailVC animated:YES];
}

@end
