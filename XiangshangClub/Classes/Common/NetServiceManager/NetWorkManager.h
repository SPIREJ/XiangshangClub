//
//  NetWorkManager.h
//  XiangshangClub
//
//  Created by SPIREJ on 16/1/11.
//  Copyright © 2016年 SPIREJ. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "XSHTTPClient.h"

#define kNetWorkErrorDomain   @"xiangshangError"

@interface NetWorkManager : XSHTTPClient
+ (instancetype)shareInstance;
/**
 *  get request
 */
- (void)xsGetPath:(NSString *)path params:(id)params delegate:(id)delegate waitingAlert:(NSString *)aleart success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

/**
 *  post request
 */
- (void)xsPostPath:(NSString *)path params:(id)params delegate:(id)delegate waitingAlert:(NSString *)alert success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
@end
