//
//  ViewController.m
//  网易框架
//
//  Created by 张海峰 on 2017/4/18.
//  Copyright © 2017年 张海峰. All rights reserved.
//

#import "ViewController.h"
//设备物理尺寸
#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UIScrollViewDelegate>
@property(nonatomic,weak)UIScrollView *titleScrollView;
@property(nonatomic,weak)UIScrollView *contentScrollView;
@property(nonatomic,weak)UIButton *radioBtn;
@property(nonatomic,strong)NSMutableArray *titleBtns;
@property(nonatomic,assign)BOOL isInitalize;
@end

@implementation ViewController
-(NSMutableArray *)titleBtns
{
    if (_titleBtns == nil) {
        _titleBtns = [[NSMutableArray alloc]init];
    }
    return _titleBtns;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_isInitalize == NO) {
        //4.设置所有的标题
         [self setupAllTitle];
        _isInitalize = YES;
    }
    
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"网易新闻";
    //这一行代码主要确定是否隐藏导航栏
    // self.navigationController.navigationBarHidden = YES;
    //1.添加标题滚动视图
    [self setupTitleScrollView];
     //2.添加内容滚动视图
    [self setupContentScrollView];
    //IOS 7 以后导航控制器中scrollView顶部会添加64的额外滚动区域
    self.automaticallyAdjustsScrollViewInsets = NO;
    //处理标题的点击
}
-(void)setupAllTitle
{
    //添加所有标题按钮
    NSInteger count = self.childViewControllers.count;
    CGFloat btnW = 100;
    CGFloat btnH = self.titleScrollView.bounds.size.height;
    CGFloat btnX = 0;
   
    for (NSInteger i=0; i<count; i++) {
        UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIViewController *VC = self.childViewControllers[i];
        [titleBtn setTitle:VC.title forState:UIControlStateNormal];
        btnX = i *btnW;
        titleBtn.tag = i;
        [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        titleBtn.frame = CGRectMake(btnX, 0, btnW, btnH);
        [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleBtns addObject:titleBtn];
        if (i==0) {
            [self titleBtnClick:titleBtn];
        }
        [_titleScrollView addSubview:titleBtn];
    }
    _titleScrollView.contentSize = CGSizeMake(btnW*count, 0);
    _titleScrollView.showsHorizontalScrollIndicator = NO;
    _contentScrollView.contentSize = CGSizeMake(screen_width*count, 0);
    _contentScrollView.showsHorizontalScrollIndicator = NO;
}
//选中标题
-(void)selButton:(UIButton *)btn
{
    _radioBtn.transform = CGAffineTransformMakeScale(1, 1);
    [_radioBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn.transform = CGAffineTransformMakeScale(1.3, 1.3);
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //获取标题
    NSInteger  leftI = scrollView.contentOffset.x/screen_width;
    NSInteger  rightI = leftI+1;
    //选中标题
    if (rightI<_titleBtns.count) {
        UIButton *titleBtn = _titleBtns[leftI];
        [self selButton:titleBtn];
        [self setupOneViewController:rightI];
        [self setupTitleCenter:titleBtn];
    }
    //字体缩放 1.缩放比例 2.缩放那两个按钮
    //获取左边的按钮
    UIButton *leftBtn  = self.titleBtns[leftI];
    //获取右边的按钮
    UIButton *rightBtn;
    if (rightI<self.titleBtns.count) {
    rightBtn  = self.titleBtns[rightI];
    }
    CGFloat scaleR = scrollView.contentOffset.x/screen_width;
    scaleR -= leftI;
    CGFloat scaleL = 1- scaleR;
    //缩放按钮
    leftBtn.transform = CGAffineTransformMakeScale(scaleL *0.3 + 1, scaleL*0.3 + 1);
    rightBtn.transform = CGAffineTransformMakeScale(scaleR*0.3 + 1, scaleR*0.3 + 1);
    //颜色渐变
    UIColor *rightColor  = [UIColor colorWithRed:scaleR green:0 blue:0 alpha:1];
     UIColor *leftColor  = [UIColor colorWithRed:scaleL green:0 blue:0 alpha:1];
    [rightBtn setTitleColor:rightColor forState:UIControlStateNormal];
    [leftBtn setTitleColor:leftColor forState:UIControlStateNormal];
}
//标题居中
-(void)setupTitleCenter:(UIButton *)btn{
    CGPoint offsetPoint = _titleScrollView.contentOffset;
    offsetPoint.x =  btn.center.x -  screen_width / 2 ;
    //左边超出处理
    if (offsetPoint.x<0) offsetPoint.x = 0;
    CGFloat maxX = _titleScrollView.contentSize.width -screen_width;
    //右边超出处理
    if (offsetPoint.x>maxX) offsetPoint.x = maxX;
    [_titleScrollView setContentOffset:offsetPoint animated:YES];
     _radioBtn = btn;
}
-(void)setupOneViewController:(NSInteger )i
{
    UIViewController *VC = self.childViewControllers[i];
    if (VC.view.superview) {
        return;
    }
    CGFloat x = i *screen_width;
    VC.view.frame  = CGRectMake(x, 0, screen_width, _contentScrollView.bounds.size.height);
    [self.contentScrollView addSubview:VC.view];
}
-(void)titleBtnClick:(UIButton *)btn
{
    [self selButton:btn];
    [self setupOneViewController:btn.tag];
    [self setupTitleCenter:btn];
    CGFloat x = btn.tag *screen_width;
    self.contentScrollView.contentOffset = CGPointMake(x, 0);
     _radioBtn = btn;
}

-(void)setupTitleScrollView
{
    UIScrollView *titleScrollView = [[UIScrollView alloc]init];
    ;
    //判断是否有导航栏
    CGFloat y = self.navigationController.navigationBarHidden? 20:64;
    titleScrollView.frame = CGRectMake(0, y, screen_width,44);
    [self.view addSubview:titleScrollView];
    _titleScrollView = titleScrollView;
}
-(void)setupContentScrollView
{
    UIScrollView *contentScrollView = [[UIScrollView alloc]init];
    ;
    //判断是否有导航栏
    CGFloat y = CGRectGetMaxY(_titleScrollView.frame);
    contentScrollView.frame = CGRectMake(0, y, screen_width, screen_height-y);
    [self.view addSubview:contentScrollView];
    _contentScrollView=contentScrollView;
    _contentScrollView.delegate=self;
    //分页
    _contentScrollView.pagingEnabled = YES;
    //弹簧
    _contentScrollView.bounces = NO;
    //设置代理。目的：监听内容滚动视图 什么时候滚动完成
}
@end
