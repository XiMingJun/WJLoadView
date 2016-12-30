//
//  UIViewController+HUD.h
//  LTProject
//
//  Created by wangjian on 2016/9/28.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJGifLoadView.h"

@interface UIViewController (HUD)

@property (nonatomic,strong)WJGifLoadView *loadHudView;

/**
 *  显示加载页面
 *
 *  @param loadString 加载文字
 */
- (void)showLoading:(NSString *)loadString;
/**显示加载页面*/
- (void)showLoading;
/**显示加载失败*/
- (void)showError;
/**显示无数据页面*/
- (void)showNoData;

/**隐藏提示*/
- (void)hideLoadingHud;

@end
