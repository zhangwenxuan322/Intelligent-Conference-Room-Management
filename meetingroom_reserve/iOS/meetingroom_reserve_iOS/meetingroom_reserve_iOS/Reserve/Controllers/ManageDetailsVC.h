//
//  ManageDetailsVC.h
//  meetingroom_reserve_iOS
//
//  Created by 张文轩 on 2019/3/26.
//  Copyright © 2019 张文轩. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ManageDetailsVC : UIViewController
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;
@end

NS_ASSUME_NONNULL_END