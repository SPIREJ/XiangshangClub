//
//  XSHTTPClient.h
//  XiangshangClub
//
//  Created by SPIREJ on 16/1/11.
//  Copyright © 2016年 SPIREJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface XSHTTPClient : NSObject

@property(nonatomic, strong)AFHTTPSessionManager *manager;
- (void)cancelTasksWithUrl:(NSString *)url;

@end
