//
//  XSMSGManager.m
//  XiangshangClub
//
//  Created by SPIREJ on 16/1/12.
//  Copyright © 2016年 SPIREJ. All rights reserved.
//

#import "XSMSGManager.h"

#define kMSGLABEL_TAG  328893483284

@implementation XSMSGManager

+ (void)showTextInWindow:(NSString *)text{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [XSMSGManager showText:text inView:keyWindow];
}

+ (void)showText:(NSString *)text inView:(UIView *)view{
    if (![text isKindOfClass:[NSString class]] || ([text isKindOfClass:[NSString class]] && text.length == 0)) {
        return;
    }
    UIView *tempView = [view viewWithTag:kMSGLABEL_TAG];
    if (tempView) {
        //当前的View有提示的View，删除
        [tempView removeFromSuperview];
    }
    UIView *bgView = [XSMSGManager msgBGView];
    UILabel *msgLB = [XSMSGManager msgLB];
    msgLB.text = text;
    [msgLB sizeToFit];
    [bgView addSubview:msgLB];
    bgView.bounds = CGRectMake(0, 0, msgLB.width+30, msgLB.height+30);
    if (bgView.width >= kDeviceWidth-60) {
        bgView.width = kDeviceWidth-60;
        msgLB.width = bgView.width-30;
        [msgLB sizeToFit];
        bgView.bounds = CGRectMake(0, 0, msgLB.width+30, msgLB.height+30);
    }
    msgLB.center = CGPointMake(bgView.width/2.0, bgView.height/2.0);
    [view addSubview:bgView];
    bgView.center = CGPointMake(view.width/2.0, view.height/2.0);
    //2秒后隐藏
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [bgView removeFromSuperview];
    });
}

//获取背景View
+ (UIView *)msgBGView{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectZero];
    bgView.tag = kMSGLABEL_TAG;
    bgView.backgroundColor = ColorWithRGB(0, 0, 0, 0.7);
    bgView.layer.cornerRadius = 5;
    bgView.layer.masksToBounds = YES;
    return bgView;
}
//获取显示msg的label
+ (UILabel *)msgLB{
    UILabel *msgLB = [[UILabel alloc] initWithFrame:CGRectZero];
    msgLB.tag = kMSGLABEL_TAG;
    msgLB.backgroundColor = Color_clearColor;
    msgLB.textAlignment = NSTextAlignmentCenter;
    msgLB.numberOfLines = 0;
    msgLB.textColor = Color_whiteColor;
    msgLB.font = XSFont(14);
    return msgLB;
}

@end
