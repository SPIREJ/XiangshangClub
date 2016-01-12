//
//  XSUserModel.h
//  XiangshangClub
//
//  Created by SPIREJ on 16/1/6.
//  Copyright © 2016年 SPIREJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>

@interface XSUserModel : NSObject<NSCoding>

@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *realName;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *idCard;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *passW;
@property (nonatomic, strong) NSString *gesturePassword;
@property (nonatomic, assign) BOOL hasPayPassword;
@property (nonatomic, assign) BOOL isRealAuth;
@property (nonatomic, assign) BOOL isLogin;
@property (nonatomic, assign) BOOL isSetGesturePassword;
@property (nonatomic, assign) BOOL isSetTouchId;


- (instancetype)initWithDic:(NSDictionary *)dic;


@end
