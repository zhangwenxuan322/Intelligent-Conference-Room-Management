
//
//  DoReserveVC.m
//  meetingroom_reserve_iOS
//
//  Created by 张文轩 on 2019/3/23.
//  Copyright © 2019 张文轩. All rights reserved.
//

#import "DoReserveVC.h"
#import "YCPickerView.h"
#import "CheckReserveVC.h"
#import "ChooseRoomVC.h"
#import "SVProgressHUD.h"
#import "MultiBaseView.h"
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
@interface DoReserveVC ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property(nonatomic,strong) UITextField *nameText;
@property(nonatomic,strong) UILabel *meetingTypeLabel;
@property(nonatomic,strong) YCPickerView *meetingTypePickerView;
@property(nonatomic,strong) UILabel *timeLabel;
@property(nonatomic,strong) YCPickerView *timePickerView;
@property(nonatomic,strong) UILabel *membersLabel;
@property(nonatomic,strong) YCPickerView *membersPickerView;
@property(nonatomic,strong) UILabel *hardWareLabel;
@property(nonatomic,strong) UITextField *remarkTextField;

@end

@implementation DoReserveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI {
    self.navigationItem.title = @"预定";
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _datas = [NSMutableArray arrayWithCapacity:0];
    NSString *host = @"发起人";
    NSString *meetingType = @"会议类型";
//    NSString *location = @"地点";
    NSString *time = @"时间";
    NSString *members = @"开会人员";
    NSString *hardWare = @"硬件设备";
    NSString *remarks = @"备注";
    NSArray *arr = [NSArray arrayWithObjects:host,meetingType,time,members,hardWare,remarks, nil];
    [self.datas addObjectsFromArray:arr];
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.backgroundColor = [UIColor clearColor];
    //下一步按钮
    UIButton *reserveBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [reserveBtn.layer setMasksToBounds:YES];
    [reserveBtn.layer setCornerRadius:5.0];
    [reserveBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [reserveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [reserveBtn setBackgroundColor:[UIColor colorWithRed:97.0/255.0 green:134.0/255.0 blue:220.0/255.0 alpha:1.0]];
    reserveBtn.frame = CGRectMake(SCREEN_WIDTH*0.05, SCREEN_HEIGHT*0.85, SCREEN_WIDTH*0.9, SCREEN_WIDTH*0.13);
    [reserveBtn addTarget:self action:@selector(reserve) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reserveBtn];
    self.view.backgroundColor = [UIColor colorWithRed:228.0/255.0 green:229/255.0 blue:234/255.0 alpha:1.0];
    _meetingTypePickerView = [[YCPickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    _meetingTypePickerView.arrPickerData = @[@"大型国际会议",@"研讨会",@"品牌发布会",@"企业年会",@"答谢会"];
    [_meetingTypePickerView.pickerView selectRow:0 inComponent:0 animated:YES]; //pickerview默认选中行
    [self.view addSubview:_meetingTypePickerView];
    _timePickerView = [[YCPickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    _timePickerView.arrPickerData = @[@"9:00-10:00",@"10:00-11:00",@"11:00-12:00",@"13:00-14:00",@"14:00-15:00",@"15:00-16:00",@"16:00-17:00",@"17:00-18:00",@"18:00-19:00",@"19:00-20:00",@"20:00-21:00"];
    [_timePickerView.pickerView selectRow:0 inComponent:0 animated:YES]; //pickerview默认选中行
    [self.view addSubview:_timePickerView];
    _membersPickerView = [[YCPickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    _membersPickerView.arrPickerData = @[@"项目组A",@"项目组B",@"项目组C"];
    [_membersPickerView.pickerView selectRow:0 inComponent:0 animated:YES]; //pickerview默认选中行
    [self.view addSubview:_membersPickerView];
}

- (void)reserve {
    if (([self.nameText.text isEqualToString:@""])||([self.meetingTypeLabel.text isEqualToString:@""])||([self.timeLabel.text isEqualToString:@""])||([self.membersLabel.text isEqualToString:@""])) {
        [SVProgressHUD showErrorWithStatus:@"请填写完整信息"];
        [SVProgressHUD dismissWithDelay:1.0];
    }else{
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        ChooseRoomVC *chooseRoomVC = [sb instantiateViewControllerWithIdentifier:@"chooseRoom"];
        chooseRoomVC.host = self.nameText.text;
        chooseRoomVC.meetingType = self.meetingTypeLabel.text;
        chooseRoomVC.time = self.timeLabel.text;
        chooseRoomVC.members = self.membersLabel.text;
        chooseRoomVC.hardWares = self.hardWareLabel.text;
        chooseRoomVC.remarks = self.remarkTextField.text;
        [self.navigationController pushViewController:chooseRoomVC animated:YES];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    cell.textLabel.text = [self.datas objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == 0) {//发起人
        cell.accessoryType = UITableViewCellAccessoryNone;
        self.nameText = [[UITextField alloc]initWithFrame:CGRectMake(cell.frame.size.width*0.5, cell.frame.size.height*0.05, cell.frame.size.width*0.6, cell.frame.size.height*0.9)];
        self.nameText.backgroundColor = [UIColor clearColor];
        self.nameText.delegate = self;
        self.nameText.textAlignment = NSTextAlignmentRight;
        self.nameText.returnKeyType = UIReturnKeyDone;//Done按钮
        self.nameText.text = @"张文轩";
        [cell addSubview:self.nameText];
    }
    if (indexPath.row == 1) {//会议类型
        self.meetingTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(cell.frame.size.width*0.6, cell.frame.size.height*0.05, cell.frame.size.width*0.5, cell.frame.size.height*0.9)];
        self.meetingTypeLabel.backgroundColor = [UIColor clearColor];
        self.meetingTypeLabel.textAlignment = NSTextAlignmentRight;
        [cell addSubview:self.meetingTypeLabel];
    }
    if (indexPath.row == 2) {//时间
        self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(cell.frame.size.width*0.6, cell.frame.size.height*0.05, cell.frame.size.width*0.5, cell.frame.size.height*0.9)];
        self.timeLabel.backgroundColor = [UIColor clearColor];
        self.timeLabel.textAlignment = NSTextAlignmentRight;
        [cell addSubview:self.timeLabel];
    }
    if (indexPath.row == 3) {//开会人员
        self.membersLabel = [[UILabel alloc]initWithFrame:CGRectMake(cell.frame.size.width*0.6, cell.frame.size.height*0.05, cell.frame.size.width*0.5, cell.frame.size.height*0.9)];
        self.membersLabel.backgroundColor = [UIColor clearColor];
        self.membersLabel.textAlignment = NSTextAlignmentRight;
        [cell addSubview:self.membersLabel];
    }
    if (indexPath.row == 4) {//硬件设备
        self.hardWareLabel = [[UILabel alloc]initWithFrame:CGRectMake(cell.frame.size.width*0.3, cell.frame.size.height*0.05, cell.frame.size.width*0.8, cell.frame.size.height*0.9)];
        self.hardWareLabel.backgroundColor = [UIColor clearColor];
        self.hardWareLabel.textAlignment = NSTextAlignmentRight;
        self.hardWareLabel.adjustsFontSizeToFitWidth = YES;
        [cell addSubview:self.hardWareLabel];
    }
    if (indexPath.row == 5) {//备注
        cell.accessoryType = UITableViewCellAccessoryNone;
        self.remarkTextField = [[UITextField alloc]initWithFrame:CGRectMake(cell.frame.size.width*0.3, cell.frame.size.height*0.05, cell.frame.size.width*0.8, cell.frame.size.height*0.9)];
        self.remarkTextField.backgroundColor = [UIColor clearColor];
        self.remarkTextField.font = [UIFont systemFontOfSize:20.0];
        self.remarkTextField.textAlignment = NSTextAlignmentRight;
        self.remarkTextField.returnKeyType = UIReturnKeyDone;
        self.remarkTextField.delegate = self;
        [cell addSubview:self.remarkTextField];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {//发起人
        [self.nameText becomeFirstResponder];
    }
    if (indexPath.row == 1) {//会议类型
        [self keyboardResign];
        [_meetingTypePickerView popPickerView];
        __block DoReserveVC * blockSelf = self;
        _meetingTypePickerView.selectBlock = ^(NSString *str) {
            blockSelf.meetingTypeLabel.text = str;
        };
    }
    if (indexPath.row == 2) {//时间
        [self keyboardResign];
        [_timePickerView popPickerView];
        __block DoReserveVC * blockSelf = self;
        _timePickerView.selectBlock = ^(NSString *str) {
            blockSelf.timeLabel.text = str;
        };
    }
    if (indexPath.row == 3) {//开会人员
        [self keyboardResign];
        [_membersPickerView popPickerView];
        __block DoReserveVC * blockSelf = self;
        _membersPickerView.selectBlock = ^(NSString *str) {
            blockSelf.membersLabel.text = str;
        };
    }
    if (indexPath.row == 4) {
        [self keyboardResign];
        NSArray *arr = @[@"投影仪",@"空调",@"摄像头",@"白板",@"加湿器"];
        [MultiBaseView showMultiSheetAlertWithTitle:@"硬件设备" conditions:arr resultBlock:^(NSArray *selectArr) {
            NSMutableString *allWares = [[NSMutableString alloc]init];
            for (NSString *str in selectArr) {
                [allWares appendString:str];
                if ([selectArr indexOfObject:str] == selectArr.count-1) {
                }else{
                    [allWares appendString:@"、"];
                }
            }
            self.hardWareLabel.text = allWares;
        } cancleBlock:^{
        }];
    }
    if (indexPath.row == 5) {//备注
        [self.remarkTextField becomeFirstResponder];
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (![self.nameText isExclusiveTouch]) {
        [self.nameText resignFirstResponder];
    }
    if (![self.remarkTextField isExclusiveTouch]) {
        [self.remarkTextField resignFirstResponder];
    }
    return YES;
}

//键盘弹回
- (void) keyboardResign {
    if ([self.nameText isFirstResponder]) {
        [self.nameText resignFirstResponder];
    }
    if ([self.remarkTextField isFirstResponder]) {
        [self.remarkTextField resignFirstResponder];
    }
}
@end
