//
//  NetWorkManager.m
//  XiangshangClub
//
//  Created by SPIREJ on 16/1/11.
//  Copyright © 2016年 SPIREJ. All rights reserved.
//

#import "NetWorkManager.h"

@implementation NetWorkManager

+ (instancetype)shareInstance{
    static NetWorkManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    //请求头
    [instance addHttpHeader];
    return instance;
}

/**
 *  添加请求头
 */
- (void)addHttpHeader{
    XSUserModel *model = [XSUtility currentArchiveUserInfo];
    [self.manager.requestSerializer setValue:[XSUtility obtainDeviceType] forHTTPHeaderField:@"device_id"];
    [self.manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [self.manager.requestSerializer setValue:model.token forHTTPHeaderField:@"access_token"];
    [self.manager.requestSerializer setValue:@"IOS" forHTTPHeaderField:@"app_type"];
    [self.manager.requestSerializer setValue:[XSUtility currentAppVersion] forHTTPHeaderField:@"app_version"];
    [self.manager.requestSerializer setValue:[XSUtility obtainDeviceIDFA] forHTTPHeaderField:@"idfa"];
    [self.manager.requestSerializer setValue:[XSUtility obtainDeviceType] forHTTPHeaderField:@"device_type"];
}

- (void)xsGetPath:(NSString *)path params:(id)params delegate:(id)delegate waitingAlert:(NSString *)aleart success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    DLog(@"URL:%@%@",self.manager.baseURL, path);
    if (params) {
        DLog(@"请求的参数：%@",params);
    }
    //网络加载窗
    [self showWaitingContent:aleart inView:delegate];
    
    [self.manager GET:path parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //隐藏网络加载窗
        [self hideWaitingInView:delegate];
        [self catchNetResWithResInfo:responseObject path:path delegate:delegate success:success error:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //隐藏网络加载窗
        [self hideWaitingInView:delegate];
        //网络请求错误处理
        NSDictionary *userInfo = error.userInfo;
        if ([userInfo isKindOfClass:[NSDictionary class]]) {
            NSString *description = [userInfo objectForKey:@"NSLocalizedDescription"];
            if ([XSUtility stringValid:description]) {
                [XSMSGManager showTextInWindow:description];
            }
        }else{
            [XSMSGManager showTextInWindow:@"请求失败，请稍后重试"];
        }
        failure(error);
    }];
}

- (void)xsPostPath:(NSString *)path params:(id)params delegate:(id)delegate waitingAlert:(NSString *)alert success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    DLog(@"请求的Url:%@%@",self.manager.baseURL,path);
    if (params) {
        DLog(@"==============请求的参数=============%@",params);
    }
    //网络加载窗
    [self showWaitingContent:alert inView:delegate];
    [self.manager POST:path parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self hideWaitingInView:delegate];
        [self catchNetResWithResInfo:responseObject path:path delegate:delegate success:success error:failure];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self hideWaitingInView:delegate];
        //网络请求错误处理
        NSDictionary *userInfo = error.userInfo;
        if ([userInfo isKindOfClass:[NSDictionary class]]) {
            NSString *description = [userInfo objectForKey:@"NSLocalizedDescription"];
            if ([XSUtility stringValid:description]) {
                [XSMSGManager showTextInWindow:description];
            }
        }else{
            [XSMSGManager showTextInWindow:@"请求失败，请稍后重试"];
        }
        failure(error);
    }];
}


/**
 *  网络请求成功后统一的处理方法
 */
- (void)catchNetResWithResInfo:(id)info path:(NSString *)path delegate:(id)delegate success:(void(^)(id resBody))success error:(void(^)(NSError *error))failure
{
    /*
     200 成功
     400 请求处理失败
     401 未通过认证
     500 服务器内部异常
     503 服务器不可用
     */
    NSDictionary *dic = (NSDictionary *)info;
    DLog(@"网络请求返回来的数据*****************\n%@\n********************",info);
    NSNumber *resCode = [dic objectForKey:@"code"];
    switch (resCode.integerValue) {
        case 200:
        {
            id data = [dic objectForKey:@"data"];
            success(data);
        }
            break;
        case 401:
        {
            //修改本地用户信息
            XSUserModel *model = [XSUtility currentArchiveUserInfo];
            model.isLogin = NO;
            [XSUtility archiveUserInfo:model];
            NSString *msg = [dic objectForKey:@"message"];
            [XSMSGManager showTextInWindow:msg];
        }
            break;
            
        default://请求处理失败
        {
            NSNumber *code = [dic objectForKey:@"code"];
            NSString *msg = [dic objectForKey:@"message"];
            NSError *error = [NSError errorWithDomain:kNetWorkErrorDomain code:code.integerValue userInfo:[NSDictionary dictionaryWithObject:msg forKey:@"message"]];
            UIView *view = nil;
            if ([delegate isKindOfClass:[UIView class]]) {
                view = delegate;
            }else if ([delegate isKindOfClass:[UIViewController class]]){
                view = ((UIViewController *)delegate).view;
            }
            failure(error);
        }
            break;
    }
}

- (void)showWaitingContent:(NSString *)alert inView:(id)delegate
{
    if (![alert isEqualToString:@"noAlert"]) {
        if ([delegate isKindOfClass:[UIView class]]) {
            [XSUtility showWaitingAlertWithContent:alert inView:delegate];
        }else if ([delegate isKindOfClass:[UIViewController class]]){
            UIViewController *vc = (UIViewController *)delegate;
            [XSUtility showWaitingAlertWithContent:alert inView:vc.view];
        }
    }
}
- (void)hideWaitingInView:(id)delegate{
    if ([delegate isKindOfClass:[UIView class]]) {
        [XSUtility hideCurrentWaitingAlertInView:delegate];
    }else if ([delegate isKindOfClass:[UIViewController class]]){
        UIViewController *vc = (UIViewController *)delegate;
        [XSUtility hideCurrentWaitingAlertInView:vc.view];
    }
}

@end
