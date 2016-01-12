//
//  XSUtility.h
//  XiangshangClub
//
//  Created by SPIREJ on 16/1/6.
//  Copyright © 2016年 SPIREJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XSUserModel.h"
#import "XSLoadingView.h"

@interface XSUtility : NSObject

//md5 加密
+ (NSString *)md5HexDigest:(NSString *)input;

//检查string的合法性
+ (BOOL)stringValid:(NSString *)str;
+ (BOOL)emailAdressValid:(NSString *)mail;
+ (BOOL)phoneNumberValid:(NSString *)phone;

//检查是否有网络
+ (BOOL)isNetWorkReachility;

//验证码倒计时，默认60秒
+ (void)codeCountDown:(UIButton *)button;
/**
 *  验证码倒计时
 *
 *  @param button      需要倒计时的button
 *  @param time        倒计时时间
 *  @param finishBlock <#finishBlock description#>
 */
+ (void)codeCountDown:(UIButton *)button time:(int)time finish:(void(^)())finishBlock;

//获取当前内存中的用户信息
+ (XSUserModel *)memoryUserInfo;
//获取当前磁盘的用户信息
+ (XSUserModel *)currentArchiveUserInfo;
//保存本地的用户信息
+ (void)archiveUserInfo:(XSUserModel *)model;

/**
 *  提示
 */
+ (void)showAlertViewWith:(NSString *)title message:(NSString *)alertMsg target:(id)target tag:(int)tag cancelBtn:(NSString *)cancelBtn otherBtn:(NSString *)otherBtn;

//显示网络等待窗
+ (void)showWaitingAlertWithContent:(NSString *)content inView:(UIView *)view;

//取消当前view的网络等待窗
+ (void)hideCurrentWaitingAlertInView:(UIView *)view;

//检查' . ' 的个数
+ (NSInteger)checkDotFormText:(NSString *)textStr;
//判断一串字符是否全为数字
+ (BOOL)isPureNumberCharacters:(NSString *)string;
//是否为纯中文字符串
+ (BOOL)isAllChineseInString:(NSString *)str;
//隐藏手机号中间4位数字为" * "
+ (NSString *)phoneNumberReplace:(NSString *)phoneNumber;

//清除当前剪贴板中的内容
+ (void)clearnPasteboard;

//获取当前的app版本号
+ (NSString *)currentAppVersion;
//获取IDFA
+ (NSString *)obtainDeviceIDFA;
//获取IDFV
+ (NSString *)obtainDeviceIDFV;
//设备类型
+ (NSString *)obtainDeviceType;
@end
