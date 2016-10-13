//
//  ViewController.m
//  XXScrollView
//
//  Created by IOS Developer on 16/10/11.
//  Copyright © 2016年 Shaun. All rights reserved.
//

#import "ViewController.h"
#import "XXScrollView.h"

@interface ViewController ()<XXScrollViewDelegate>

@end
#define K_SCREENWIDTH ([[UIScreen mainScreen] bounds].size.width)
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    XXScrollView * xx = [[XXScrollView alloc]initWithFrame:CGRectMake(0, 100, K_SCREENWIDTH, 200)];
    xx.urlImageArr = @[@"http://ww4.sinaimg.cn/mw690/7ee2cfb1gw1ecbcxixm3sj21kw11xe2b.jpg",
                       @"http://ww4.sinaimg.cn/mw690/6fefd2a1gw1epaemkkgn0j20nm0g4ae0.jpg",
                       @"http://ww1.sinaimg.cn/mw690/62f7cf9bgw1eozy7gsiuvj21kw12j4oa.jpg",
                       @"http://ww4.sinaimg.cn/mw690/5df89726gw1epjarhzqwkj24m032w1lb.jpg",
                       @"http://ww2.sinaimg.cn/mw690/65641e6bgw1f67ugh7volj22421epe83.jpg"];
    [xx addClickPicture:^(NSUInteger currentIndex) {
//        NSLog(@"ssssssss:%ld",currentIndex);
    }];
    [xx addDidScroll:^(NSUInteger currentIndex) {
//        NSLog(@"addDidScroll:%ld",currentIndex);
    }];
    xx.titleArr = @[@"曾梦想仗剑走天下",@"看一看世界的繁华",@"年少的心总有些轻狂",@"如今你四海为家",@"曾让你心疼的姑娘"];
//    xx.detailTitleArr = @[@"哈哈哈哈哈😄",@"哈哈哈哈😂哈哈哈",@"哈哈哈😌哈哈哈哈",@"哈哈哈☺️哈哈哈哈",@"哈哈哈哈哈😒"];
    xx.grayImageHidden = NO;
    xx.delegate = self;
//    xx.dotColor = [UIColor redColor];
//    xx.currentDotColor = [UIColor greenColor];
    [self.view addSubview:xx];
    
    /*   =-=-=-=-=-=-=-=-=-=-=-=-=    Local   本地加载     -=-=-=-=-=-=-=-=-=-=-=-=-      */
    XXScrollView * xxLocal = [[XXScrollView alloc]initWithFrame:CGRectMake(0, 320, K_SCREENWIDTH, 200)];
    xxLocal.localImageArr = @[@"BayerischerLynx_EN-US10608941251_1366x768",@"BlueJaySnow_EN-US9039497953_1366x768",@"HarbinOperaHouse_EN-US10126072780_1366x768",@"Zposing Red Squirrel"];
    xxLocal.titleArr = @[@"Do you know what's worth fighting for",@"When it's not worth dying for",@"Does it take your breath away",@"And you feel yourself suffocating"];
    xxLocal.autoScrollTime = 2;
    [self.view addSubview:xxLocal];
}
- (void)xxScrollView:(XXScrollView *)scrollView didScrollIndex:(NSInteger)index
{
//    NSLog(@"index:::::%ld",index);
}

- (void)xxScrollView:(XXScrollView *)scrollView didSelectItemAtIndex:(NSInteger)index
{
//    NSLog(@"index!!!!!!!:%ld",index);
}



@end
