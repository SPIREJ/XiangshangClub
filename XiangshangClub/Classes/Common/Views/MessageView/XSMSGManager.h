//
//  XSMSGManager.h
//  XiangshangClub
//
//  Created by SPIREJ on 16/1/12.
//  Copyright © 2016年 SPIREJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XSMSGManager : NSObject

/**
 *  在window上面显示一个提示语
 */
+(void)showTextInWindow:(NSString *)text;


/**
*  在当前的view上显示一个提示语
*/
+(void)showText:(NSString *)text inView:(UIView *)view;

@end
