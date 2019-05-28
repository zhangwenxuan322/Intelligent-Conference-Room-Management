//
//  CalendarVC.m
//  meetingroom_reserve_iOS
//
//  Created by 张文轩 on 2019/3/26.
//  Copyright © 2019 张文轩. All rights reserved.
//

#import "CalendarVC.h"
#import "FSCalendar.h"
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
@interface CalendarVC ()<FSCalendarDataSource, FSCalendarDelegate>
@property (weak, nonatomic) FSCalendar *calendar;
@property (strong, nonatomic) UILabel *time;
@property (strong, nonatomic) UILabel *schedules;
@end

@implementation CalendarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI{
    self.time = [[UILabel alloc]initWithFrame:CGRectMake(10, SCREEN_HEIGHT*0.5+64, SCREEN_WIDTH*0.5, SCREEN_HEIGHT*0.1)];
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy"];
    NSInteger currentYear=[[formatter stringFromDate:now] integerValue];
    [formatter setDateFormat:@"MM"];
    NSInteger currentMonth=[[formatter stringFromDate:now]integerValue];
    [formatter setDateFormat:@"dd"];
    NSInteger currentDay=[[formatter stringFromDate:now] integerValue];
    self.time.text = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)currentYear,(long)currentMonth,(long)currentDay];
    self.time.textAlignment = NSTextAlignmentLeft;
    self.time.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:self.time];
    self.schedules = [[UILabel alloc]initWithFrame:CGRectMake(10, SCREEN_HEIGHT*0.61+64, SCREEN_WIDTH-20, SCREEN_HEIGHT*0.3)];
    self.schedules.text = @"实B-205      9:00-10:00";
    self.schedules.textAlignment = NSTextAlignmentLeft;
    self.schedules.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.schedules];
}

- (void)loadView{
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.view = view;
    
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT*0.5)];
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:calendar];
    self.calendar = calendar;
}

//选中某一天进行相关操作
- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy"];
    NSInteger currentYear=[[formatter stringFromDate:date] integerValue];
    [formatter setDateFormat:@"MM"];
    NSInteger currentMonth=[[formatter stringFromDate:date]integerValue];
    [formatter setDateFormat:@"dd"];
    NSInteger currentDay=[[formatter stringFromDate:date] integerValue];
    NSString *clickDate =[NSString stringWithFormat:@"%ld-%ld-%ld",(long)currentYear,(long)currentMonth,(long)currentDay];
    self.time.text = clickDate;
    if ([clickDate isEqualToString:@"2019-3-27"]) {
        self.schedules.text = @"实B-207      14:00-15:00";
    }
}


@end
