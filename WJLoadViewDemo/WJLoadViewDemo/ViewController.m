//
//  ViewController.m
//  WJLoadViewDemo
//
//  Created by wangjian on 2016/12/30.
//  Copyright © 2016年 qhfax. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+HUD.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

}
- (IBAction)buttonAction:(UIButton *)sender {
    
    
    long index = sender.tag;
    if (index == 0) {
        [self showLoading:@"努力加载中..."];
        [self.view sendSubviewToBack:self.loadHudView];

    }
    else if (index == 1) {
        [self hideLoadingHud];
    }
    else if (index == 2) {
        [self showError];
    }
    else if (index == 3) {
        [self showNoData];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
