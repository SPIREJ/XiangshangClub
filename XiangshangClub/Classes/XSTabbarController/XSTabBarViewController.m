//
//  XSTabBarViewController.m
//  XiangshangClub
//
//  Created by SPIREJ on 16/1/4.
//  Copyright © 2016年 SPIREJ. All rights reserved.
//

#import "XSTabBarViewController.h"
#import "XSRecommendViewController.h"
#import "XSBorrowingViewController.h"
#import "XSInvestViewController.h"
#import "XSAccountViewController.h"

@interface XSTabBarViewController ()<UITabBarDelegate,UITabBarControllerDelegate>
@property(nonatomic,strong)NSMutableArray *viewControllers;
@end

@implementation XSTabBarViewController
@synthesize viewControllers;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.viewControllers = [NSMutableArray arrayWithCapacity:4];
    [self setUpControllers];
    //tabbar backgroundColor
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    
    NSArray *array = @[@{@"title":@"推荐",@"normalImageName":@"tabbar_recommend_normal",@"selectImageName":@"tabbar_recommend_select"},
                       @{@"title":@"借款",@"normalImageName":@"tabbar_borrow_normal",@"selectImageName":@"tabbar_borrow_select"},
                       @{@"title":@"投资",@"normalImageName":@"tabbar_invest_normal",@"selectImageName":@"tabbar_invest_select"},
                       @{@"title":@"账户",@"normalImageName":@"tabbar_account_normal",@"selectImageName":@"tabbar_account_select"}];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dic = (NSDictionary *)obj;
        UIViewController *vc = self.viewControllers[idx];
        NSString *title = [dic objectForKey:@"title"];
        NSString *normalImageName = [dic objectForKey:@"normalImageName"];
        NSString *selectImageName = [dic objectForKey:@"selectImageName"];
        
        [self addController:vc title:title normolImageName:normalImageName selectImageName:selectImageName];
    }];
    [self setUpTabbarItemTextAttributes];
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpControllers
{
    XSRecommendViewController * recommendVC = [[XSRecommendViewController alloc] init];
    MLNavigationController *recommendNav = [[MLNavigationController alloc] initWithRootViewController:recommendVC];
    
    XSBorrowingViewController * borrowingVC = [[XSBorrowingViewController alloc] init];
    MLNavigationController *borrowingNav = [[MLNavigationController alloc] initWithRootViewController:borrowingVC];
    
    XSInvestViewController *investVC = [[XSInvestViewController alloc] init];
    MLNavigationController *investNav = [[MLNavigationController alloc] initWithRootViewController:investVC];
    XSAccountViewController * accountVC = [[XSAccountViewController alloc] init];
    MLNavigationController *accountNav = [[MLNavigationController alloc] initWithRootViewController:accountVC];
    
    [self.viewControllers addObject:recommendNav];
    [self.viewControllers addObject:borrowingNav];
    [self.viewControllers addObject:investNav];
    [self.viewControllers addObject:accountNav];
}
/**
 *  添加子控制器，初始化tabbarItem
 */
- (void)addController:(UIViewController *)viewController title:(NSString *)title normolImageName:(NSString *)normalImageName selectImageName:(NSString *)selectImageName
{
    viewController.tabBarItem.title = title;
    
    UIImage *normalImage = [UIImage imageNamed:normalImageName];
    normalImage = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.image = normalImage;
    
    UIImage *selectedImage = [UIImage imageNamed:selectImageName];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = selectedImage;
    
    [self addChildViewController:viewController];
}

- (void)setUpTabbarItemTextAttributes
{
    //普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    //选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = kNavigationBarColor;
    
    UITabBarItem *tabbarItem = [UITabBarItem appearance];
    [tabbarItem setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabbarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

#pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)viewController;
        UIViewController *vc = [nav.viewControllers objectAtIndex:0];
        DLog(@"current viewcontroller is %@", vc);
    }
    return YES;
}

@end
