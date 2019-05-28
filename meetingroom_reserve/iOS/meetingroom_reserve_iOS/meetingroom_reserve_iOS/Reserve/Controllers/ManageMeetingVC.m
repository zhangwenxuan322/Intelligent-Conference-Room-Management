
//
//  ManageMeetingVC.m
//  meetingroom_reserve_iOS
//
//  Created by 张文轩 on 2019/3/26.
//  Copyright © 2019 张文轩. All rights reserved.
//

#import "ManageMeetingVC.h"
#import "ManageDetailsVC.h"
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
@interface ManageMeetingVC ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ManageMeetingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI{
    self.navigationItem.title = @"会议室管理";
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _datas = [NSMutableArray arrayWithCapacity:0];
    NSString *room1 = @"实B-205";
    NSString *room2 = @"实B-206";
    NSString *room3 = @"实B-207";
    NSString *room4 = @"实B-208";
    NSArray *arr = [NSArray arrayWithObjects:room1,room2,room3,room4, nil];
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
    cell.accessoryType = UITableViewCellAccessoryNone;
    if (indexPath.row == 0) {
        cell.detailTextLabel.text = @"无人";
    }
    if (indexPath.row == 1) {
        cell.detailTextLabel.text = @"会议进行中";
    }
    if (indexPath.row == 2) {
        cell.detailTextLabel.text = @"会议进行中";
    }
    if (indexPath.row == 3) {
        cell.detailTextLabel.text = @"无人";
    }
    cell.detailTextLabel.textColor = [UIColor grayColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ManageDetailsVC *manageDetailsVC = [sb instantiateViewControllerWithIdentifier:@"manageDetails"];
    [self.navigationController pushViewController:manageDetailsVC animated:YES];
}


@end
