//
//  WJGifLoadView
//  CLMJRefresh
//
//  Created by wangjian on 15/12/18.
//  Copyright © 2015年 wangjian. All rights reserved.
//


#import "WJGifLoadView.h"
#import "UIView+MJExtension.h"
#import "UIImage+GIF.h"
//RGB转UIColor（不带alpha值）
#define UIColorFromRGB(rgbValue) [UIColor  colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0  green:((float)((rgbValue & 0xFF00) >> 8))/255.0  blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface WJGifLoadView()
/** 所有状态对应的动画图片 */
@property (strong, nonatomic) NSMutableDictionary *stateImages;
/**所有状态对应的文字内容*/
@property (strong,nonatomic) NSMutableDictionary *stateStrings;
@end

@implementation WJGifLoadView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
        [self makeView];
    }
    return self;
}
/**公共参数初始化配置*/
- (void)commonInit{
    //默认各状态显示文案
//    [self setLoadViewImage:[UIImage sd_animatedGIFNamed:@"jump"] stateString:@"努力加载中..." forState:WJLoadStateLoading];
    [self setLoadViewImages:@[[UIImage imageNamed:@"jump1"],[UIImage imageNamed:@"jump2"],[UIImage imageNamed:@"jump3"],[UIImage imageNamed:@"jump4"]] stateString:@"努力加载中..." forState:WJLoadStateLoading];
    [self setLoadViewImage:[UIImage imageNamed:@"img_xiaoqian_cry"] stateString:@"网络不太给力" forState:WJLoadStateFailed];
    [self setLoadViewImage:[UIImage imageNamed:@"icon_no_record"] stateString:@"暂无记录" forState:WJLoadStateNoData];

}
- (void)makeView{
    // 设置普通状态的动画图片
    self.gifView = [self gifView];
    UIImage *tempImage =  [UIImage imageNamed:@"img_xiaoqian_cry"];
    self.gifView.frame = CGRectMake(0,0, tempImage.size.width,tempImage.size.height);
    self.gifView.backgroundColor = [UIColor clearColor];
    self.gifView.contentMode = UIViewContentModeScaleAspectFit;
//    self.gifView.center = self.center;
    CGPoint gifViewCenter = self.gifView.center;
    gifViewCenter.y = self.center.y - 64;
    gifViewCenter.x = self.center.x;
    
    self.gifView.center = gifViewCenter;
    
    self.stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.gifView.frame.origin.x, CGRectGetMaxY(self.gifView.frame) + 10, self.gifView.frame.size.width, 20)];
    self.stateLabel.textAlignment = NSTextAlignmentCenter;
    self.stateLabel.font = [UIFont systemFontOfSize:17.0f];
    self.stateLabel.textColor = UIColorFromRGB(0x666666);
    self.stateLabel.text = self.stateStrings[@(WJLoadStateLoading)];
    [self addSubview:self.stateLabel];
    
    /* 根据图片设置控件的高度 */
    UIImage *image = [UIImage imageNamed:@"jump"];
    if (image.size.height > self.mj_h) {
        self.mj_h = image.size.height;
    }
    [self setState:WJLoadStateLoading];
}
#pragma mark - 懒加载
- (UIImageView *)gifView
{
    if (!_gifView) {
        UIImageView *gifView = [[UIImageView alloc] init];
        [self addSubview:_gifView = gifView];
    }
    return _gifView;
}

- (NSMutableDictionary *)stateImages
{
    if (!_stateImages) {
        self.stateImages = [NSMutableDictionary dictionary];
    }
    return _stateImages;
}
- (NSMutableDictionary *)stateStrings{

    if (!_stateStrings) {
        self.stateStrings = [NSMutableDictionary dictionary];
    }
    return _stateStrings;
}
#pragma mark - 公共方法
- (void)setLoadViewImage:(UIImage *)image stateString:(NSString *)stateString forState:(WJLoadState)state
{
    if (image) {
        self.stateImages[@(state)] = image;
    }
    self.stateStrings[@(state)] = stateString;
    /* 根据图片设置控件的高度 */
    if (image.size.height > self.mj_h) {
        self.mj_h = image.size.height;
    }
}
- (void)setLoadViewImages:(NSArray *)images stateString:(NSString *)stateString forState:(WJLoadState)state{

    if (images.count <= 0) {
        NSLog(@"图片数组为空");
    }
    self.stateImages[@(state)] = images;
    self.stateStrings[@(state)] = stateString;
    
    UIImage *image = images[0];
    /* 根据图片设置控件的高度 */
    if (image.size.height > self.mj_h) {
        self.mj_h = image.size.height;
    }
}
#pragma mark - 实现父类的方法

- (void)placeSubviews
{
    
    self.gifView.frame = self.bounds;
    if (self.stateLabel.hidden) {
        self.gifView.contentMode = UIViewContentModeCenter;
    } else {
        self.gifView.contentMode = UIViewContentModeRight;
        self.gifView.mj_w = self.mj_w * 0.5 - 90;
    }
}

- (void)setState:(WJLoadState)state
{
    [self.gifView stopAnimating];
    if (state == WJLoadStateLoading || state == WJLoadStateNoData) {
        
        if ([self.stateImages[@(state)] isKindOfClass:[NSArray class]]) {
            NSArray *images = self.stateImages[@(state)];
            self.gifView.animationImages = images; //获取Gif图片列表
            self.gifView.animationDuration = 0.35;     //执行一次完整动画所需的时长
            self.gifView.animationRepeatCount = NSNotFound;  //动画重复次数
            [self.gifView startAnimating];
        }
        else{
            [self.gifView setImage:self.stateImages[@(state)]];
        }
        self.stateLabel.text = self.stateStrings[@(state)];
        UIImage *tempImage =  [UIImage imageNamed:@"img_xiaoqian_cry"];

        self.gifView.frame = CGRectMake(0,0, tempImage.size.width,tempImage.size.height);
        CGPoint gifViewCenter = self.gifView.center;
        gifViewCenter.y = self.center.y - 64;
        gifViewCenter.x = self.center.x;
        self.gifView.center = gifViewCenter;
        self.stateLabel.frame = CGRectMake((self.frame.size.width - 120)/2, CGRectGetMaxY(self.gifView.frame) + 10, 120, 20);
        self.btnRetry.hidden = YES;
        if (state == WJLoadStateLoading) {
            self.stateLabel.textColor = UIColorFromRGB(0x666666);
        }
        else if (state == WJLoadStateNoData) {
        
            self.stateLabel.textColor = UIColorFromRGB(0xcccccc);
        }
        
    }
    else if (state == WJLoadStateFinish){
        self.stateLabel.textColor = UIColorFromRGB(0x666666);
        [self hide:self After:2];
    }
    else if(state == WJLoadStateFailed){
        UIImage *image =  [UIImage imageNamed:@"img_xiaoqian_cry"];
        self.gifView.image = self.stateImages[@(WJLoadStateFailed)];
        self.gifView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        self.stateLabel.textColor = UIColorFromRGB(0x666666);
        CGPoint gifViewCenter = self.gifView.center;
        gifViewCenter.y = self.center.y - 64;
        gifViewCenter.x = self.center.x;
        self.gifView.center = gifViewCenter;
        self.stateLabel.frame = CGRectMake((self.frame.size.width - 120)/2, CGRectGetMinY(self.gifView.frame)  - 30,120, 20);
        self.stateLabel.text = self.stateStrings[@(WJLoadStateFailed)];
        if (!self.btnRetry) {
            self.btnRetry = [UIButton buttonWithType:UIButtonTypeCustom];
            self.btnRetry.frame = CGRectMake((self.frame.size.width - 120)/2, CGRectGetMaxY(self.gifView.frame) + 10, 120, 35);
            [self.btnRetry setTitle:@"重新刷新" forState:UIControlStateNormal];
            [self.btnRetry setTitleColor:UIColorFromRGB(0xF98B1B) forState:UIControlStateNormal];
            self.btnRetry.titleLabel.font = [UIFont systemFontOfSize:15.0f];
            self.btnRetry.backgroundColor = [UIColor whiteColor];
            self.btnRetry.layer.cornerRadius = 2.0f;
            self.btnRetry.clipsToBounds = YES;
            [self.btnRetry addTarget:self action:@selector(btnRetry:) forControlEvents:UIControlEventTouchUpInside];
            self.btnRetry.layer.borderWidth = .5f;
            self.btnRetry.layer.borderColor = UIColorFromRGB(0xF98B1B).CGColor;
            [self addSubview:self.btnRetry];
        }
        else{
            self.btnRetry.frame = CGRectMake((self.frame.size.width - 120)/2, CGRectGetMaxY(self.gifView.frame) + 10, 120, 35);
            self.btnRetry.hidden = NO;
        }
    }
}
- (void)btnRetry:(UIButton *)sender{
    
    [self setState:WJLoadStateLoading];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (myRetryBlock) {
            myRetryBlock();
        }
    });

    
}

- (void)setRetryBlcok:(RetryBlock)retryBlcok{
    myRetryBlock = retryBlcok;
}

- (void)hide{
    [self removeFromSuperview];
}
- (void)hide:(UIView *)view After:(NSTimeInterval)duration{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [view removeFromSuperview];

    });
}
//- (void)setLoadViewImage:(UIImage *)image forState:(WJLoadState)state{
//    self.state = state;
//    self.gifView.image = image;
//}
@end
