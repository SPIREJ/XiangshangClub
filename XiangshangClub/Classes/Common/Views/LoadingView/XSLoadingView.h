//
//  XSLoadingView.h
//  XiangshangClub
//
//  Created by SPIREJ on 16/1/11.
//  Copyright © 2016年 SPIREJ. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const XSLoadingViewLoadingText;
extern NSString *const XSLoadingViewSubmitText;

@interface XSLoadingView : UIView

@property(nonatomic, strong) UIActivityIndicatorView *indicatorView;
@property(nonatomic, strong) UIImageView *loadingView;
@property(nonatomic, strong) UILabel *loading;

- (void)stopLoading;
- (void)startLoading;
@end
