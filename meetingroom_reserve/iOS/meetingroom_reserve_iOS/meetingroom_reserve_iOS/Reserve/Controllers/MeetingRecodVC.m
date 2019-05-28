//
//  MeetingRecodVC.m
//  meetingroom_reserve_iOS
//
//  Created by 张文轩 on 2019/3/26.
//  Copyright © 2019 张文轩. All rights reserved.
//

#import "MeetingRecodVC.h"
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
@interface MeetingRecodVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong) UITextField *titleText;
@property (nonatomic, strong) UITextField *memberText;
@property (nonatomic, strong) UITextField *summaryText;
@end

@implementation MeetingRecodVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void) initUI{
    self.navigationItem.title = @"会议记录";
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _datas = [NSMutableArray arrayWithCapacity:0];
    NSString *title = @"标题";
    NSString *members = @"开会人员";
    NSString *summary = @"会议摘要";
    NSArray *arr = [NSArray arrayWithObjects:title,members,summary, nil];
    [self.datas addObjectsFromArray:arr];
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor colorWithRed:228.0/255.0 green:229/255.0 blue:234/255.0 alpha:1.0];
    //下一步按钮
    UIButton *reserveBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [reserveBtn.layer setMasksToBounds:YES];
    [reserveBtn.layer setCornerRadius:5.0];
    [reserveBtn setTitle:@"提交" forState:UIControlStateNormal];
    [reserveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [reserveBtn setBackgroundColor:[UIColor colorWithRed:97.0/255.0 green:134.0/255.0 blue:220.0/255.0 alpha:1.0]];
    reserveBtn.frame = CGRectMake(SCREEN_WIDTH*0.05, SCREEN_HEIGHT*0.85, SCREEN_WIDTH*0.9, SCREEN_WIDTH*0.13);
    [reserveBtn addTarget:self action:@selector(reserve) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reserveBtn];
}

- (void) reserve{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellID"];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.textLabel.text = [self.datas objectAtIndex:indexPath.row];
    if (indexPath.row == 0) {
        self.titleText = [[UITextField alloc]initWithFrame:CGRectMake(cell.frame.size.width*0.5, cell.frame.size.height*0.05, cell.frame.size.width*0.6, cell.frame.size.height*0.9)];
        self.titleText.backgroundColor = [UIColor clearColor];
        self.titleText.delegate = self;
        self.titleText.textAlignment = NSTextAlignmentRight;
        self.titleText.returnKeyType = UIReturnKeyDone;//Done按钮
        [cell addSubview:self.titleText];
    }
    if (indexPath.row == 1) {
        self.memberText = [[UITextField alloc]initWithFrame:CGRectMake(cell.frame.size.width*0.5, cell.frame.size.height*0.05, cell.frame.size.width*0.6, cell.frame.size.height*0.9)];
        self.memberText.backgroundColor = [UIColor clearColor];
        self.memberText.delegate = self;
        self.memberText.textAlignment = NSTextAlignmentRight;
        self.memberText.returnKeyType = UIReturnKeyDone;//Done按钮
        [cell addSubview:self.memberText];
    }
    if (indexPath.row == 2) {
        self.summaryText = [[UITextField alloc]initWithFrame:CGRectMake(cell.frame.size.width*0.5, cell.frame.size.height*0.05, cell.frame.size.width*0.6, cell.frame.size.height*0.9)];
        self.summaryText.backgroundColor = [UIColor clearColor];
        self.summaryText.delegate = self;
        self.summaryText.textAlignment = NSTextAlignmentRight;
        self.summaryText.returnKeyType = UIReturnKeyDone;//Done按钮
        [cell addSubview:self.summaryText];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [self.titleText becomeFirstResponder];
    }
    if (indexPath.row == 1) {
        [self.memberText becomeFirstResponder];
    }
    if (indexPath.row == 2) {
        [self.summaryText becomeFirstResponder];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
@end
