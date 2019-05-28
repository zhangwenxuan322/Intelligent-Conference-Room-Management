//
//  CheckReserveVC.m
//  meetingroom_reserve_iOS
//
//  Created by 张文轩 on 2019/3/23.
//  Copyright © 2019 张文轩. All rights reserved.
//

#import "CheckReserveVC.h"
#import "SVProgressHUD.h"
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
@interface CheckReserveVC ()<UITableViewDelegate, UITableViewDataSource>
@end

@implementation CheckReserveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI {
    self.navigationItem.title = @"确认";
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _datas = [NSMutableArray arrayWithCapacity:0];
    _details = [NSMutableArray arrayWithCapacity:0];
    NSString *host = @"发起人";
    NSString *type = @"会议类型";
    NSString *useTime = @"时间";
    NSString *members = @"开会人员";
    NSString *hardware = @"硬件设备";
    NSString *remarks = @"备注";
    NSArray *arr = [NSArray arrayWithObjects:host,type,useTime,members,hardware,remarks, nil];
    NSArray *detailArr = [NSArray arrayWithObjects:self.host,self.meetingType,self.time,self.members,self.hardWares,self.remarks, nil];
    [self.details addObjectsFromArray:detailArr];
    [self.datas addObjectsFromArray:arr];
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor colorWithRed:228.0/255.0 green:229/255.0 blue:234/255.0 alpha:1.0];
    //预定
    UIButton *reserveBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [reserveBtn.layer setMasksToBounds:YES];
    [reserveBtn.layer setCornerRadius:5.0];
    [reserveBtn setTitle:@"预定" forState:UIControlStateNormal];
    [reserveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [reserveBtn setBackgroundColor:[UIColor colorWithRed:97.0/255.0 green:134.0/255.0 blue:220.0/255.0 alpha:1.0]];
    reserveBtn.frame = CGRectMake(SCREEN_WIDTH*0.05, SCREEN_HEIGHT*0.85, SCREEN_WIDTH*0.9, SCREEN_WIDTH*0.13);
    [reserveBtn addTarget:self action:@selector(reserve) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reserveBtn];
}

- (void)reserve {
    [SVProgressHUD showSuccessWithStatus:@"预订成功"];
    [SVProgressHUD dismissWithDelay:1.5];
    [NSThread sleepForTimeInterval:1.5];
    [self.navigationController popToRootViewControllerAnimated:YES];
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
    cell.accessoryType = UITableViewCellAccessoryNone;
    if (indexPath.section == 0) {
        cell.textLabel.text = self.room;
        cell.detailTextLabel.text = @"空闲";
        cell.detailTextLabel.textColor = [UIColor colorWithRed:83.0/255.0 green:193.0/255.0 blue:44.0/255.0 alpha:1.0];
    }else{
        cell.textLabel.text = [self.datas objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [self.details objectAtIndex:indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
