//
//  XSUtility.m
//  XiangshangClub
//
//  Created by SPIREJ on 16/1/6.
//  Copyright © 2016年 SPIREJ. All rights reserved.
//

#import "XSUtility.h"
#import <CommonCrypto/CommonCrypto.h>
#import "AppDelegate.h"
#import <EventKit/EventKit.h>
#import <LocalAuthentication/LocalAuthentication.h>
#import <AdSupport/AdSupport.h>
#import "MRProgressOverlayView.h"

@implementation XSUtility
//md5 加密
+ (NSString *)md5HexDigest:(NSString*)input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (unsigned int)strlen(cStr), digest ); // This is the md5 call
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}
//检查string的合法性
+ (BOOL)stringValid:(NSString *)str
{
    if (![str isKindOfClass:[NSString class]]) {
        return NO;
    }
    if ([[str lowercaseString] isEqualToString:@"(null)"]) {
        return NO;
    }
    if ([[str lowercaseString] isEqualToString:@"<null>"]) {
        return NO;
    }
    if ([[str lowercaseString] isEqualToString:@"null"]) {
        return NO;
    }
    if (str != nil && [str length] > 0 && ![@"" isEqualToString:str]) {
        return YES;
    }
    else{
        return NO;
    }
}
+ (BOOL)emailAdressValid:(NSString *)mail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:mail];
}
+ (BOOL)phoneNumberValid:(NSString *)phone
{
    if (![XSUtility stringValid:phone]) {
        return NO;
    }else if ([phone hasPrefix:@"1"] && [phone length] == 11){
        return YES;
    }else{
        return NO;
    }
}

//检查是否有网络
+ (BOOL)isNetWorkReachility{
    Reachability *reachability = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    NetworkStatus status = [reachability currentReachabilityStatus];
    if (status == NotReachable) {
        return NO;
    }else{
        return YES;
    }
}

//验证码倒计时，默认60秒
+ (void)codeCountDown:(UIButton *)button{
    
}
/**
 *  验证码倒计时
 *
 *  @param button      需要倒计时的button
 *  @param time        倒计时时间
 *  @param finishBlock <#finishBlock description#>
 */
+ (void)codeCountDown:(UIButton *)button time:(int)time finish:(void(^)())finishBlock{
    __block int timeOut = time;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);//每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [button setTitle:@"重新获取" forState:UIControlStateNormal];
                button.userInteractionEnabled = YES;
                finishBlock();
            });
        }else{
            NSString *strTime = [NSString stringWithFormat:@"%ds",timeOut];
            dispatch_async(dispatch_get_main_queue(), ^{
                [button setBackgroundImage:nil forState:UIControlStateNormal];
                [button setTitle:[NSString stringWithFormat:@"%@后重新获取",strTime] forState:UIControlStateNormal];
                button.userInteractionEnabled = NO;
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}

//获取当前内存中的用户信息
+ (XSUserModel *)memoryUserInfo{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate.currentUserModel;
}
//获取当前磁盘的用户信息
+ (XSUserModel *)currentArchiveUserInfo
{
    //如果内存中有XSUserModel，直接读取，否则，去磁盘读取
    if ([XSUtility memoryUserInfo] != nil) {
        DLog(@"读取内存中的用户信息");
        return [XSUtility memoryUserInfo];
    }
    DLog(@"用户信息读档");
    return [XSUtility unArchiverWuthFileName:kUserInfoFileName dataName:kUserInfoDataKey];
}
//保存本地的用户信息
+ (void)archiveUserInfo:(XSUserModel *)model{
    DLog(@"用户信息归档");
    return [XSUtility archiverModel:model fileName:kUserInfoFileName dataName:kUserInfoDataKey];
}

/**
 *  提示
 */
+ (void)showAlertViewWith:(NSString *)title message:(NSString *)alertMsg target:(id)target tag:(int)tag cancelBtn:(NSString *)cancelBtn otherBtn:(NSString *)otherBtn{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:alertMsg delegate:target cancelButtonTitle:cancelBtn otherButtonTitles:otherBtn, nil];
    alertView.tag = tag;
    alertView.delegate = target;
    [alertView show];
}
+ (void)showWaitingAlertWithContent:(NSString *)content inView:(UIView *)view{
    if (view == nil) {
        return;
    }
    NSArray *subViews = [view subviews];
    BOOL isShowingAlert = NO;
    for (UIView *view in subViews) {
        if ([view isKindOfClass:[MRProgressOverlayView class]]) {
            isShowingAlert = YES;
            break;
        }
    }
    if (!isShowingAlert) {
        MRProgressOverlayView *progressOverView = [[MRProgressOverlayView alloc] init];
        progressOverView.mode = MRProgressOverlayViewModeCustom;
        progressOverView.modeView = [[XSLoadingView alloc] init];
        XSLoadingView *loadingView = (XSLoadingView *)progressOverView.modeView;
        [loadingView startLoading];
        if ([XSUtility stringValid:content] && content) {
            loadingView.loading.text = content;
        }
        [view addSubview:progressOverView];
        [progressOverView show:YES];
    }
}
+ (void)hideCurrentWaitingAlertInView:(UIView *)view{
    NSArray *subViews = [view subviews];
    for (UIView *view in subViews) {
        if ([view isKindOfClass:[MRProgressOverlayView class]]) {
            [self performBlock:^{
                //暂停XSLoadingView中的定时器
                MRProgressOverlayView *progress = (MRProgressOverlayView *)view;
                if ([progress.modeView isKindOfClass:[XSLoadingView class]]) {
                    XSLoadingView *load = (XSLoadingView *)progress.modeView;
                    [load stopLoading];
                }
                [(MRProgressOverlayView *)view dismiss:NO];
            } afterDelay:0.1];
            break;
        }
    }
}


+ (void)performBlock:(void(^)())block afterDelay:(NSTimeInterval)delay{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC   ));
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}

//检查' . ' 的个数
+ (NSInteger)checkDotFormText:(NSString *)textStr{
    NSArray *docArr = [textStr componentsSeparatedByString:@"."];
    return docArr.count-1;
}
//判断一串字符是否全为数字
+ (BOOL)isPureNumberCharacters:(NSString *)string{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if (string.length > 0) {
        return NO;
    }
    return YES;
}
//是否为纯中文字符串
+ (BOOL)isAllChineseInString:(NSString *)str{
    for (int i = 0; i < str.length; i++) {
        unichar ch = [str characterAtIndex:i];
        if (!(0x4e00 <= ch && ch <= 0x9fff)) {
            return NO;
        }
    }
    return YES;
}
//隐藏手机号中间4位数字为" * "
+ (NSString *)phoneNumberReplace:(NSString *)phoneNumber{
    NSRange range = NSMakeRange(3, phoneNumber.length-7);
    phoneNumber = [phoneNumber stringByReplacingCharactersInRange:range withString:@"****"];
    return phoneNumber;
}

//清除当前剪贴板中的内容
+ (void)clearnPasteboard{
    UIPasteboard *pp = [UIPasteboard generalPasteboard];
    if ([XSUtility stringValid:pp.string]) {
        pp.string = @"";
    }
}

//获取当前的app版本号
+ (NSString *)currentAppVersion{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}
//获取IDFA
+ (NSString *)obtainDeviceIDFA{
    NSString *adId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    if (adId == nil) {
        adId = @"";
    }
    return adId;
}
//获取IDFA
+ (NSString *)obtainDeviceIDFV{
    NSString *idfv = [[[UIDevice currentDevice] identifierForVendor]UUIDString];
    if (idfv) {
        return idfv;
    }else{
        return @"";
    }
}
//设备类型
+ (NSString *)obtainDeviceType{
    if (CurrentIPhone4) return @"iphone4";
    if (CurrentIPhone5) return @"iphone5";
    if (CurrentIPhone6) return @"iphone6";
    if (CurrentIPhone6Plus) return @"iphone6plus";
    
    //其他
    return @"iphone4";
}

#pragma mark - archiver
//归档类数据
+ (void)archiverModel:(NSObject *)model fileName:(NSString *)fileName dataName:(NSString *)dataName{
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *dataFilePath = [cachePath stringByAppendingPathComponent:fileName];
    
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archive = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archive encodeObject:model forKey:dataName];
    [archive finishEncoding];
    [data writeToFile:dataFilePath atomically:YES];
}
//解归档类数据
+ (id)unArchiverWuthFileName:(NSString *)fileName dataName:(NSString *)dataName
{
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:fileName];
    NSData *data = [[NSMutableData alloc] initWithContentsOfFile:filePath];
    NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    id model = [unArchiver decodeObjectForKey:dataName];
    [unArchiver finishDecoding];
    if (model == nil) {
        DLog(@"读档信息为空");
    }
    return model;
}

@end
