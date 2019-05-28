//
//  ChooseRoomVC.m
//  meetingroom_reserve_iOS
//
//  Created by 张文轩 on 2019/3/25.
//  Copyright © 2019 张文轩. All rights reserved.
//

#import "ChooseRoomVC.h"
#import "CheckReserveVC.h"
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
@interface ChooseRoomVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *details;
@end

@implementation ChooseRoomVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void) initUI{
    self.navigationItem.title = @"我们为您推荐以下会议室";
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _datas = [NSMutableArray arrayWithCapacity:0];
    _details = [NSMutableArray arrayWithCapacity:0];
    NSString *room1 = @"实B-205";
    NSString *room2 = @"实B-206";
    NSString *room3 = @"实B-207";
//    NSString *room4 = @"实B-208";
    NSArray *arr = [NSArray arrayWithObjects:room1,room2,room3, nil];
    [self.datas addObjectsFromArray:arr];
    NSString *endAndStart1 = @"上场8：00结束，下场11：00开始";
    NSString *endAndStart2 = @"上场暂无，下场10：00开始";
    NSString *endAndStart3 = @"上场8：00结束，下场暂无";
//    NSString *endAndStart4 = @"上场8：00结束，下场14：00开始";
    NSArray *detailArr = [NSArray arrayWithObjects:endAndStart1,endAndStart2,endAndStart3, nil];
    [self.details addObjectsFromArray:detailArr];
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
    cell.detailTextLabel.text = [self.details objectAtIndex:indexPath.row];
    cell.detailTextLabel.textColor = [UIColor grayColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self sendMsg:self.datas[indexPath.row]];
}

- (void)sendMsg:(NSString*)room{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    CheckReserveVC *checkReserveVC = [sb instantiateViewControllerWithIdentifier:@"checkReserve"];
    checkReserveVC.room = room;
    checkReserveVC.host = self.host;
    checkReserveVC.meetingType = self.meetingType;
    checkReserveVC.time = self.time;
    checkReserveVC.members = self.members;
    checkReserveVC.hardWares = self.hardWares;
    checkReserveVC.remarks = self.remarks;
    [self.navigationController pushViewController:checkReserveVC animated:YES];
}
@end
