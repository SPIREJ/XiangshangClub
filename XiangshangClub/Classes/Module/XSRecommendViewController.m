//
//  XSRecommendViewController.m
//  XiangshangClub
//
//  Created by SPIREJ on 16/1/4.
//  Copyright © 2016年 SPIREJ. All rights reserved.
//

#import "XSRecommendViewController.h"
#import "XSTextViewController.h"

@interface XSRecommendViewController ()

@end

@implementation XSRecommendViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navBarStyle = XSNavBarStyle_Red;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navTitle = @"推荐";
    
    [self setUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUI {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 150, 50)];
    btn.center = self.view.center;
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"点击到下一级菜单" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnClick {
    DLog(@"hello");
    XSTextViewController *textVC = [[XSTextViewController alloc] init];
    [self.navigationController pushViewController:textVC animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
