//
//  XSLoadingView.m
//  XiangshangClub
//
//  Created by SPIREJ on 16/1/11.
//  Copyright © 2016年 SPIREJ. All rights reserved.
//

#import "XSLoadingView.h"

NSString *const XSLoadingViewLoadingText = @"正在加载..."; //Default
NSString *const XSLoadingViewSubmitText = @"请稍候...";

@implementation XSLoadingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, 150, 100);
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.backgroundColor = ColorWithHex(0x000000, 0.7);
        
        self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.indicatorView.center = CGPointMake(self.width/2, 20+self.indicatorView.height/2);
        [self addSubview:self.indicatorView];
        self.indicatorView.hidden = NO;
        
        self.loadingView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading_pro"]];
        self.loadingView.center = CGPointMake(self.center.x, self.centerY-15);
        [self addSubview:self.loadingView];
        
        self.loading = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 140, 20)];
        self.loading.backgroundColor = Color_clearColor;
        self.loading.textColor = Color_whiteColor;
        self.loading.font = XSFont(14);
        self.loading.textAlignment = NSTextAlignmentCenter;
        self.loading.text = XSLoadingViewLoadingText;
        self.loading.center = CGPointMake(self.width/2, self.indicatorView.maxY+15);
        [self addSubview:self.loading];
        self.height = self.loading.maxY + 20;
    }
    return self;
}
- (void)stopLoading{
    [self.indicatorView stopAnimating];
}
- (void)startLoading{
    [self.indicatorView startAnimating];
}
@end
