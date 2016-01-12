//
//  XSHTTPClient.m
//  XiangshangClub
//
//  Created by SPIREJ on 16/1/11.
//  Copyright © 2016年 SPIREJ. All rights reserved.
//

#import "XSHTTPClient.h"

@implementation XSHTTPClient

- (instancetype)init{
    self = [super init];
    if (self) {
        self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
        self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
        self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        [self.manager.requestSerializer setValue:@"1111" forHTTPHeaderField:@"device_id"];
        [self.manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [self.manager.requestSerializer setValue:@"127327137ashdhga273dyg261teasvd" forHTTPHeaderField:@"access_token"];
    }
    return self;
}

/**
 *  取消网络请求
 */
- (void)cancelTasksWithUrl:(NSString *)url
{
    for (NSURLSessionTask *task in self.manager.tasks) {
        NSString *taskUrl = task.currentRequest.URL.absoluteString;
        if ([taskUrl rangeOfString:url].location != NSNotFound) {
            [task cancel];
        }
    }
}
@end
