//
//  MianVC.m
//  网易框架
//
//  Created by 张海峰 on 2017/4/18.
//  Copyright © 2017年 张海峰. All rights reserved.
//

#import "MianVC.h"
#import "TopLineVC.h"
#import "HotVC.h"
#import "ScienceVC.h"
#import "ScoletyVC.h"
#import "ReaderVC.h"
#import "VideoVC.h"
@interface MianVC ()

@end

@implementation MianVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"网易";
   
    //3.添加所有子控制器
    [self setupAllChildViewController];
}
-(void)setupAllChildViewController
{
    //头条
    TopLineVC *topLineVC = [[TopLineVC alloc]init];
    topLineVC.title = @"头条";
    topLineVC.view.backgroundColor = [UIColor orangeColor];
    [self addChildViewController:topLineVC];
    //热点
    HotVC *hotVC = [[HotVC alloc]init];
    hotVC.title = @"热点";
    hotVC.view.backgroundColor = [UIColor redColor];
    [self addChildViewController:hotVC];
    //视频
    VideoVC *videoVC = [[VideoVC alloc]init];
    videoVC.title = @"视频";
    videoVC.view.backgroundColor = [UIColor grayColor];
    [self addChildViewController:videoVC];
    //社会
    ScoletyVC *scoletyVC = [[ScoletyVC alloc]init];
    scoletyVC.title = @"社会";
    scoletyVC.view.backgroundColor = [UIColor greenColor];
    [self addChildViewController:scoletyVC];
    //订阅
    ReaderVC *readerVC = [[ReaderVC alloc]init];
    readerVC.title = @"订阅";
    readerVC.view.backgroundColor = [UIColor cyanColor];
    [self addChildViewController:readerVC];
    //科技
    ScienceVC *scienceVC = [[ScienceVC alloc]init];
    scienceVC.title = @"科技";
    scienceVC.view.backgroundColor = [UIColor yellowColor];
    [self addChildViewController:scienceVC];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
