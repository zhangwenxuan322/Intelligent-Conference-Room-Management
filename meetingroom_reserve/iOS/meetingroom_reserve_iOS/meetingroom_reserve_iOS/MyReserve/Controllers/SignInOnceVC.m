//
//  SignInOnceVC.m
//  meetingroom_reserve_iOS
//
//  Created by 张文轩 on 2019/3/26.
//  Copyright © 2019 张文轩. All rights reserved.
//

#import "SignInOnceVC.h"
#import "SVProgressHUD.h"
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
@interface SignInOnceVC ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation SignInOnceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI{
    self.navigationItem.title = @"一键签到";
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    _datas = [NSMutableArray arrayWithCapacity:0];
    NSString *history1 = @"2019-3-22 10:00 星期五";
    NSString *history2 = @"2019-3-25 14:00 星期一";
    NSString *history3 = @"2019-3-26 9:00  星期二";
    NSArray *arr = [NSArray arrayWithObjects:history1,history2,history3, nil];
    [self.datas addObjectsFromArray:arr];
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor colorWithRed:228.0/255.0 green:229/255.0 blue:234/255.0 alpha:1.0];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else{
        return self.datas.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellID"];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = @"一键签到";
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    if (indexPath.section == 1) {
        cell.textLabel.text = [self.datas objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryNone;
        if (indexPath.row == 2) {
            cell.detailTextLabel.text = @"缺勤";
            cell.detailTextLabel.textColor = [UIColor redColor];
        }
        if (indexPath.row == 1) {
            cell.detailTextLabel.text = @"已签到";
            cell.detailTextLabel.textColor = [UIColor colorWithRed:83.0/255.0 green:193.0/255.0 blue:44.0/255.0 alpha:1.0];
        }
        if (indexPath.row == 0) {
            cell.detailTextLabel.text = @"已签到";
            cell.detailTextLabel.textColor = [UIColor colorWithRed:83.0/255.0 green:193.0/255.0 blue:44.0/255.0 alpha:1.0];
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        [SVProgressHUD showSuccessWithStatus:@"签到成功!"];
        [self.navigationController popToRootViewControllerAnimated:YES];
        [SVProgressHUD dismissWithDelay:1.5];
    }
}
@end
