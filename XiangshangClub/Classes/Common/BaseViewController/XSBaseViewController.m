//
//  XSBaseViewController.m
//  XiangshangClub
//
//  Created by SPIREJ on 16/1/4.
//  Copyright © 2016年 SPIREJ. All rights reserved.
//

#import "XSBaseViewController.h"

@interface XSBaseViewController ()

@end

@implementation XSBaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kVCViewBGColor;
    self.navigationItem.titleView = self.titleViewLB;
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.title = @"";
    self.navBarStyle = XSNavBarStyle_White;
}

/**
 *  设置导航栏的颜色，默认是红色
 */
- (void)setNavBarStylr:(XSNavBarStyle)navBarStyle
{
    _navBarStyle = navBarStyle;
    if (XSNavBarStyle_White == navBarStyle) {
        self.titleViewLB.textColor = Color_blackColor;
        self.navigationController.navigationBar.barTintColor = Color_whiteColor;
        self.navigationController.navigationBar.translucent = NO;
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        UINavigationBar *navigationBar = self.navigationController.navigationBar;
        [navigationBar setBackgroundImage:[UIImage new] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        [navigationBar setShadowImage:[UIImage new]];
    }else if (XSNavBarStyle_Red == navBarStyle){
        self.titleViewLB.textColor = Color_whiteColor;
        self.navigationController.navigationBar.barTintColor = kNavigationBarColor;
        self.navigationController.navigationBar.translucent = NO;
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        UINavigationBar *navigationBar = self.navigationController.navigationBar;
        [navigationBar setBackgroundImage:[UIImage imageNamed:@"account_headBg"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        [navigationBar setShadowImage:[UIImage new]];
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self finishPress];
}

- (void)baseBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - setter and getter
- (UILabel *)titleViewLB
{
    if (_titleViewLB == nil) {
        _titleViewLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth-140, 44)];
        _titleViewLB.backgroundColor = [UIColor clearColor];
        _titleViewLB.font = XSBlodFont(19);
        _titleViewLB.textAlignment = NSTextAlignmentCenter;
    }
    return _titleViewLB;
}
- (void)setNavTitle:(NSString *)navTitle
{
    _titleViewLB.text = navTitle;
}
- (void)setShowBack:(BOOL)showBack
{
    if (showBack) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CGRectMake(0, 0, 20, 44);
        [_backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(baseBack) forControlEvents:UIControlEventTouchUpInside];
        _backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:_backButton];
        backItem.style = UIBarButtonItemStylePlain;
        self.navigationItem.leftBarButtonItem = backItem;
    }else{
        self.navigationItem.hidesBackButton = YES;
    }
}
- (void)setShowLeftButton:(BOOL)showLeftButton
{
    if (showLeftButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 35, 35);
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        [button addTarget:self action:@selector(leftBarButtonItemTouchedUpInSide) forControlEvents:UIControlEventTouchUpInside];
    }
}
- (void)setShowRightButton:(BOOL)showRightButton
{
    if (showRightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.frame = CGRectMake(0, 0, 30, 30);
        _rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 15, 0, -15);
        [_rightButton setImage:[UIImage imageNamed:@"tabbar_recommend_normal"] forState:UIControlStateNormal];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightButton];
        [_rightButton addTarget:self action:@selector(rightBarButtonItemTouchedUpInSide) forControlEvents:UIControlEventTouchUpInside];
    }
}
#pragma mark - touch up in side
- (void)leftBarButtonItemTouchedUpInSide
{
    //根据自己需要实现
    DLog(@"leftBarButtonItemTouchedUpInSide未实现");
}
- (void)rightBarButtonItemTouchedUpInSide
{
    //根据自己需要实现
    DLog(@"rightBarButtonItemTouchedUpInSide未实现");
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
//键盘弹出时，展示完成
- (UIView *)showKeyBoardToolView
{
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, -36, kDeviceWidth, 36)];
    toolBar.backgroundColor = [UIColor lightGrayColor];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 35.4, kDeviceWidth, 0.6)];
    lineView.backgroundColor = XSLineColor;
    lineView.height = 0.6;
    [toolBar addSubview:lineView];
    
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(finishPress)];
    UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:flexibleSpaceLeft,done, nil]];
    return toolBar;
}
- (void)finishPress
{
    [self.view endEditing:YES];
}

@end
