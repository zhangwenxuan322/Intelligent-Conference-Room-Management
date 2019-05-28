//
//  ManageDetailsVC.m
//  meetingroom_reserve_iOS
//
//  Created by 张文轩 on 2019/3/26.
//  Copyright © 2019 张文轩. All rights reserved.
//

#import "ManageDetailsVC.h"

@interface ManageDetailsVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ManageDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI{
    self.navigationItem.title = @"设备管理";
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _datas = [NSMutableArray arrayWithCapacity:0];
    NSString *temperature = @"温度";
    NSString *moisture = @"湿度";
    NSString *light = @"灯光";
    NSString *projector = @"投影仪";
    NSArray *arr = [NSArray arrayWithObjects:temperature,moisture,light,projector, nil];
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
        cell.detailTextLabel.text = @"30℃↑";
    }
    if (indexPath.row == 1) {
        cell.detailTextLabel.text = @"60%";
    }
    if (indexPath.row == 2 || indexPath.row == 3) {
        UISwitch *switchButton = [[UISwitch alloc]init];
        NSNumber *isOn;
        isOn = [[NSUserDefaults standardUserDefaults] objectForKey:@"G2"];
        BOOL boolValue = [isOn boolValue];
        switchButton.on = boolValue;
        switchButton.tag = indexPath.row;
        [switchButton addTarget:self action:@selector(clickSwitch:) forControlEvents:UIControlEventValueChanged];
        cell.accessoryView = switchButton;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.detailTextLabel.textColor = [UIColor grayColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void) clickSwitch:(UIButton*)sender{
    
}
@end
