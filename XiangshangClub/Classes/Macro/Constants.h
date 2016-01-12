//
//  Constants.h
//  XiangshangClub
//
//  Created by SPIREJ on 16/1/4.
//  Copyright © 2016年 SPIREJ. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#define kUserInfoFileName  @"xsclub.db"
#define kUserInfoDataKey  @"userInfo"

#define kDeviceWidth           [UIScreen mainScreen].bounds.size.width
#define KDeviceHeight          [UIScreen mainScreen].bounds.size.height
#define KNaviewtionBarHeight   (CurrentIOS7?64:44)
#define KTabBarHeight 49

#define CurrentIOS8_3          [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.3
#define CurrentIOS8            [[[UIDevice currentDevice] systemVersion] floatValue] >= 8
#define CurrentIOS7            [[[UIDevice currentDevice] systemVersion] floatValue] >= 7
#define CurrentIOS6            [[[UIDevice currentDevice] systemVersion] floatValue] >= 6
#define CurrentOnlyIOS6        [[[UIDevice currentDevice] systemVersion] floatValue] <7

#define CurrentIPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640,960), [[UIScreen mainScreen] currentMode].size) : NO)

#define CurrentIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define CurrentIPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750,1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define CurrentIPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,2208), [[UIScreen mainScreen] currentMode].size) : NO)

//RGB颜色
#define ColorWithRGB(_R,_G,_B,_A)      [UIColor colorWithRed:_R/255.0 green:_G/255.0 blue:_B/255.0 alpha:_A];
//16进制颜色转换成UIColor
#define ColorWithHex(hex,alph)            [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:(alph)]
//导航栏的背景色
#define kNavigationBarColor     ColorWithRGB(238,94,94,1)
//view的背景色
#define kVCViewBGColor          ColorWithRGB(238,238,238,1)

//常用颜色
#define Color_clearColor         [UIColor clearColor]
#define Color_whiteColor         [UIColor whiteColor]
#define Color_blackColor         [UIColor blackColor]

#define XSLineColor                ColorWithHex(0xf1f1f1,1);
#define XSLineHeight               0.5

//字体
#define XSFont(_size)         [UIFont systemFontOfSize:_size]
#define XSBlodFont(_size)   [UIFont boldSystemFontOfSize:_size]

/**
 *  日志输出
 */
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"[文件名:%s]\n" "[方法名:%s]\n" "[行号:%d] \n Log:--->" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define Dlog(fmt,...)
#endif



#endif /* Constants_h */
