//
//  CheckReserveVC.h
//  meetingroom_reserve_iOS
//
//  Created by 张文轩 on 2019/3/23.
//  Copyright © 2019 张文轩. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CheckReserveVC : UIViewController
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) NSMutableArray *details;
@property (nonatomic, strong) NSString *room;
@property (nonatomic, strong) NSString *host;
@property (nonatomic, strong) NSString *meetingType;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *members;
@property (nonatomic, strong) NSString *hardWares;
@property (nonatomic, strong) NSString *remarks;
@end

NS_ASSUME_NONNULL_END
