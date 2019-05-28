//
//  CardsVC.m
//  meetingroom_reserve_iOS
//
//  Created by 张文轩 on 2019/1/17.
//  Copyright © 2019 张文轩. All rights reserved.
//

#import "CardsVC.h"
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
@interface CardsVC ()

@end

@implementation CardsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void) initUI{
    self.navigationItem.title = @"电子卡包";
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add)];
    self.navigationItem.rightBarButtonItem = addBtn;
    UIImageView *cards = [[UIImageView alloc]initWithFrame:CGRectMake(0, 70, SCREEN_WIDTH, SCREEN_HEIGHT-70)];
    cards.image = [UIImage imageNamed:@"电子签名"];
    [self.view addSubview:cards];
}

- (void) add{
    
}

@end
