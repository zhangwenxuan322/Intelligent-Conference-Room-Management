//
//  MeetingVC.m
//  meetingroom_reserve_iOS
//
//  Created by 张文轩 on 2018/12/8.
//  Copyright © 2018 张文轩. All rights reserved.
//

#import "MeetingVC.h"
#import "MyCell.h"
#import "CalendarVC.h"
#import "MeetingRecodVC.h"
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
@interface MeetingVC ()<UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating>

@end

@implementation MeetingVC

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray *)datas {
    if (_datas == nil) {
        _datas = [NSMutableArray arrayWithCapacity:0];
        NSArray *arr = [[NSArray alloc]initWithObjects:@"日历",@"会议日程",@"通知", nil];
        [self.datas addObjectsFromArray:arr];
    }
    return _datas;
}

- (NSMutableArray *)results {
    if (_results == nil) {
        _results = [NSMutableArray arrayWithCapacity:0];
    }
    return _results;
}

- (void)viewWillAppear:(BOOL)animated{
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
    } else {
    }
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTabbarItem];
}

- (void) initTabbarItem{
    UISearchController *searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    // 设置结果更新代理
    searchController.searchResultsUpdater = self;
    // 因为在当前控制器展示结果, 所以不需要这个透明视图
    searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController = searchController;
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
    } else {
    }
    self.view.backgroundColor = [UIColor colorWithRed:228.0/255.0 green:229/255.0 blue:234/255.0 alpha:1.0];
    self.tableView.tableHeaderView = searchController.searchBar;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"会议";
    UITabBarItem *item0 = [self.tabBarController.tabBar.items objectAtIndex:0];
    UITabBarItem *item1 = [self.tabBarController.tabBar.items objectAtIndex:1];
    UITabBarItem *item2 = [self.tabBarController.tabBar.items objectAtIndex:2];
    [item0 setTitle:@"会议"];
    [item0 setImage:[UIImage imageNamed:@"会议未选中"]];
    [item0 setSelectedImage:[UIImage imageNamed:@"会议选中"]];
    [item1 setTitle:@"预定"];
    [item1 setImage:[UIImage imageNamed:@"预定未选中"]];
    [item1 setSelectedImage:[UIImage imageNamed:@"预定选中"]];
    [item2 setTitle:@"我的"];
    [item2 setImage:[UIImage imageNamed:@"我的未选中"]];
    [item2 setSelectedImage:[UIImage imageNamed:@"我的选中"]];
//    [self showAlert:@"您的会议已结束，是否进行会议记录"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 这里通过searchController的active属性来区分展示数据源是哪个
    if (self.searchController.active) {
        return self.results.count ;
    }
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (cell == nil) {
        cell = [[MyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
    }
    // 这里通过searchController的active属性来区分展示数据源是哪个
    if (self.searchController.active ) {
        cell.title.text = [self.results objectAtIndex:indexPath.row];
    } else {
        cell.title.text = [self.datas objectAtIndex:indexPath.row];
        if (indexPath.row == 0) {
            cell.image.image = [UIImage imageNamed:@"日历"];
        }
        if (indexPath.row == 1) {
            cell.image.image = [UIImage imageNamed:@"会议"];
        }
        if (indexPath.row == 2) {
            cell.details.text = @"1、xxxxxxx\n2、xxxxxxx\n3、xxxxxxx";
            cell.details.numberOfLines = 0;
            cell.image.image = [UIImage imageNamed:@"通知"];
        }
//        cell.details.text = @"asdafd";
//        cell.image.image = [UIImage imageNamed:@"会议选中"];
        cell.contentView.backgroundColor = [UIColor colorWithRed:228.0/255.0 green:229/255.0 blue:234/255.0 alpha:1.0];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if (self.searchController.active) {
//        NSLog(@"选择了搜索结果中的%@", [self.results objectAtIndex:indexPath.row]);
//    } else {
//        NSLog(@"选择了列表中的%@", [self.datas objectAtIndex:indexPath.row]);
//    }
    if (indexPath.row == 0) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        CalendarVC *calendarVC = [sb instantiateViewControllerWithIdentifier:@"calendar"];
        if (@available(iOS 11.0, *)) {
            self.navigationController.navigationBar.prefersLargeTitles = NO;
        } else {
        }
        self.tabBarController.tabBar.hidden = YES;
        [self.navigationController pushViewController:calendarVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row >= 0 && indexPath.row <= 2) {
        return SCREEN_HEIGHT*0.15;
    }else{
        return 0;
    }
}



#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *inputStr = searchController.searchBar.text ;
    if (self.results.count > 0) {
        [self.results removeAllObjects];
    }
    for (NSString *str in self.datas) {
        if ([str.lowercaseString rangeOfString:inputStr.lowercaseString].location != NSNotFound) {
            [self.results addObject:str];
        }
    }
    [self.tableView reloadData];
}

- (void)showAlert:(NSString *)title {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                   message:title
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                                                              MeetingRecodVC *meetingRecordVC = [sb instantiateViewControllerWithIdentifier:@"meetingRecord"];
                                                              if (@available(iOS 11.0, *)) {
                                                                  self.navigationController.navigationBar.prefersLargeTitles = NO;
                                                              } else {
                                                              }
                                                              self.tabBarController.tabBar.hidden = YES;
                                                              [self.navigationController pushViewController:meetingRecordVC animated:YES];
                                                          }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                         }];
    
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
