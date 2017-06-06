//
//  ViewController.m
//  ShufflingTest
//
//  Created by L on 17/6/6.
//  Copyright © 2017年 LJL. All rights reserved.
//

#import "ViewController.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScrollViewH 200
#define kScrollView_Y 64
@interface ViewController ()<ShufflingDelegate>
{
    NSArray *numArray;
}
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}
#pragma mark - SetupUI
- (void)setupUI{
    //初始化ScrollView
    numArray = @[[UIColor orangeColor],[UIColor blueColor],[UIColor redColor],[UIColor purpleColor],[UIColor grayColor]];

    ShufflingView *view = [[ShufflingView alloc]initWithFrame:CGRectMake(0, kScrollView_Y, kScreenWidth, kScrollViewH)];
    view.delegate = self;
    [view reloadDataUIWithDataArray:numArray];
    [self.view addSubview:view];
}
#pragma mark - ShufflingDelegate
- (void)didSelectWithIndex:(NSInteger)index
{
    NSLog(@"%ld",index);
}

@end
