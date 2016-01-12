//
//  XSUserModel.m
//  XiangshangClub
//
//  Created by SPIREJ on 16/1/6.
//  Copyright © 2016年 SPIREJ. All rights reserved.
//

#import "XSUserModel.h"

#define ObjectFromDictionary(_dic,_key)  [NSString stringWithFormat:@"%@",[_dic objectForKey:_key]]
@implementation XSUserModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _token = ObjectFromDictionary(dic, @"token");
        _realName = ObjectFromDictionary(dic, @"realName");
        _mobile = ObjectFromDictionary(dic, @"mobile");
        _idCard = ObjectFromDictionary(dic, @"idCard");
        _email = ObjectFromDictionary(dic, @"email");
        _hasPayPassword = ObjectFromDictionary(dic, @"hasPayPassword").boolValue;
        _isRealAuth = ObjectFromDictionary(dic, @"isRealAuth").boolValue;
        _isLogin = YES;
        _isSetGesturePassword = NO;
        _isSetTouchId = NO;
        _passW = @"";
        _gesturePassword = @"";
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_token forKey:@"token"];
    [aCoder encodeObject:_realName forKey:@"realName"];
    [aCoder encodeObject:_mobile forKey:@"mobile"];
    [aCoder encodeObject:_idCard forKey:@"idCard"];
    [aCoder encodeObject:_email forKey:@"email"];
    [aCoder encodeBool:_hasPayPassword forKey:@"hasPayPassword"];
    [aCoder encodeBool:_isRealAuth forKey:@"isRealAuth"];
    [aCoder encodeBool:_isLogin forKey:@"isLogin"];
    [aCoder encodeObject:_passW forKey:@"passW"];
    [aCoder encodeBool:_isSetGesturePassword forKey:@"isSetGesturePassword"];
    [aCoder encodeBool:_isSetTouchId forKey:@"isSetTouchId"];
    [aCoder encodeObject:_gesturePassword forKey:@"gesturePassword"];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        //
        self.token = [aDecoder decodeObjectForKey:@"token"];
        self.realName = [aDecoder decodeObjectForKey:@"realName"];
        self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
        self.idCard = [aDecoder decodeObjectForKey:@"idCard"];
        self.email = [aDecoder decodeObjectForKey:@"email"];
        self.hasPayPassword = [aDecoder decodeBoolForKey:@"hasPayPassword"];
        self.isRealAuth = [aDecoder decodeBoolForKey:@"isRealAuth"];
        self.isLogin = [aDecoder decodeBoolForKey:@"isLogin"];
        self.passW = [aDecoder decodeObjectForKey:@"passW"];
        self.isSetGesturePassword = [aDecoder decodeBoolForKey:@"isSetGesturePassword"];
        self.isSetTouchId = [aDecoder decodeBoolForKey:@"isSetTouchId"];
        self.gesturePassword = [aDecoder decodeObjectForKey:@"gesturePassword"];
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@",self.mj_keyValues];
}

@end
