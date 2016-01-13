//
//  XSTextViewController.m
//  XiangshangClub
//
//  Created by SPIREJ on 16/1/13.
//  Copyright © 2016年 SPIREJ. All rights reserved.
//

#import "XSTextViewController.h"

@interface XSTextViewController ()

@end

@implementation XSTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navTitle = @"二级 测试控制器";
    self.navBarStyle = XSNavBarStyle_Red;
    
    self.showBack = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
