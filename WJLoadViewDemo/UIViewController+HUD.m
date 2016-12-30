//
//  UIViewController+HUD.m
//  LTProject
//
//  Created by wangjian on 2016/9/28.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "UIViewController+HUD.h"
#import <objc/message.h>
#import "UIImage+Gif.h"

static const void *kLoadHud = @"k_loadHud";
@interface UIViewController ()

@end
@implementation UIViewController (HUD)
- (WJGifLoadView *)loadHudView{

    WJGifLoadView *gifLoading = objc_getAssociatedObject(self, &kLoadHud);
    if (!gifLoading) {
        gifLoading = [[WJGifLoadView alloc]initWithFrame:self.view.bounds];
        gifLoading.backgroundColor = [UIColor clearColor];
        [self.view addSubview:gifLoading];
        objc_setAssociatedObject(self, &kLoadHud, gifLoading, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return gifLoading;
}
- (void)setLoadHudView:(WJGifLoadView *)loadHudView{

    self.loadHudView = [self loadHudView];
    
}
# pragma mark - 显示 -
/**
 *  显示加载动画
 *
 *  @param loadString 状态内容
 */
- (void)showLoading:(NSString *)loadString{

    [self.loadHudView setHidden:NO];
    [self.view bringSubviewToFront:self.loadHudView];
    [self.loadHudView setLoadViewImage:nil
                           stateString:loadString
                              forState:WJLoadStateLoading];
    self.loadHudView.state = WJLoadStateLoading;
}
/**显示加载动画*/
- (void)showLoading{
    [self.loadHudView setHidden:NO];
    [self.view bringSubviewToFront:self.loadHudView];
    self.loadHudView.state = WJLoadStateLoading;
}
/**显示加载失败*/
- (void)showError{
    [self.loadHudView setHidden:NO];
    self.loadHudView.state = WJLoadStateFailed;
}
/**显示无数据页面*/
- (void)showNoData{
    [self.loadHudView setHidden:NO];
    self.loadHudView.state = WJLoadStateNoData;

}
#pragma mark - 消失 Tips hide
- (void)hideLoadingHud {
    if (self.loadHudView) {
        [self.loadHudView setHidden:YES];
    }
}

@end
