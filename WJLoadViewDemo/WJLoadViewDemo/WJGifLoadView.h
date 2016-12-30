//
//  WJGifLoadView
//  CLMJRefresh
//
//  Created by wangjian on 15/12/18.
//  Copyright © 2015年 wangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,WJLoadState){
    WJLoadStateLoading = 1,//加载中
    WJLoadStateFinish,//加载完成
    WJLoadStateFailed,//加载失败
    WJLoadStateNoData//加载完，无数据
};

typedef void(^RetryBlock)();

@interface WJGifLoadView : UIView
{
    RetryBlock myRetryBlock;
}
/**加载状态*/
@property (assign,nonatomic) WJLoadState state;
@property (copy,nonatomic) RetryBlock retryBlcok;
/**状态标签*/
@property (strong, nonatomic) UILabel * stateLabel;
/**重试按钮*/
@property (strong, nonatomic) UIButton * btnRetry;
/**状态图片*/
@property (weak, nonatomic) UIImageView *gifView;

- (void)setRetryBlcok:(RetryBlock)retryBlcok;

/**
 *  设置某状态的图片（gif）
 *
 *  @param image 图片
 *  @param stateString 状态文字
 *  @param state 状态
 */
- (void)setLoadViewImage:(UIImage *)image
             stateString:(NSString *)stateString
                forState:(WJLoadState)state;

/**
 设置某状态图片（图片轮播）
 @param images      动态图数组
 @param stateString 状态文字
 @param state       状态
 */
- (void)setLoadViewImages:(NSArray *)images
             stateString:(NSString *)stateString
                forState:(WJLoadState)state;

@end
