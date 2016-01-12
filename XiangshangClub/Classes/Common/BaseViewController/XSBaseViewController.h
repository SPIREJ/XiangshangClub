//
//  XSBaseViewController.h
//  XiangshangClub
//
//  Created by SPIREJ on 16/1/4.
//  Copyright © 2016年 SPIREJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XSNavBarStyle)
{
    XSNavBarStyle_White,
    XSNavBarStyle_Red
};

@interface XSBaseViewController : UIViewController

@property(nonatomic, assign)BOOL showBack; /**是否显示返回按钮，默认 NO*/
@property(nonatomic, assign)BOOL showRedBack; /**是否显示返回按钮，红色的返回按钮*/
@property(nonatomic, assign)BOOL showLeftButton, showRightButton; /**是否显示导航栏左边右边的按钮*/
@property(nonatomic, strong)UIButton *backButton;
@property(nonatomic, strong)UIButton *rightButton;

@property(nonatomic, strong)UILabel *titleViewLB; /** navigationItem.titleView */
@property(nonatomic, copy)NSString *navTitle; /** navigationItem.title */
@property(nonatomic, strong)UIColor *navTitleColor; /** navigationItem.title color */
@property(nonatomic, strong)UIViewController *popToViewController;
@property(nonatomic,assign)XSNavBarStyle navBarStyle; //**设置navigationController.navigationBar的颜色，默认白色*/
/**
 *  返回按钮的点击事件
 */
- (void)baseBack;
/**
 *  键盘弹出时，展示完成
 */
- (UIView *)showKeyBoardToolView;
/**
 *  view完成编辑
 */
- (void)finishPress;
@end
