//
//  ShufflingView.m
//  ShufflingTest
//
//  Created by L on 17/6/6.
//  Copyright © 2017年 LJL. All rights reserved.
//

#import "ShufflingView.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScrollViewH 200
#define kScrollView_Y 64
@implementation ShufflingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        num = 0;
    }
    return self;
}

#pragma mark - SetupUI
- (void)setupUI{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 5, kScreenWidth-20, kScrollViewH-10) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell1"];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(kScreenWidth -20, kScrollViewH-10);
    layout.minimumLineSpacing = 0;
    _collectionView.pagingEnabled = YES;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    [self addSubview:_collectionView];
    
    self.pageControl = [[UIPageControl alloc]init];
    self.pageControl.frame = CGRectMake(0, kScrollViewH - 30, kScreenWidth, 30);
    [self addSubview:self.pageControl];
   NSTimer *timer  = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(timerMethed) userInfo:nil repeats:YES];
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:timer forMode:NSRunLoopCommonModes];
    
}


#pragma mark - collection Delegate
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
    cell.backgroundColor = numArray[indexPath.row%numArray.count];
    return  cell;
}



- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return numArray.count *10000;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate didSelectWithIndex:indexPath.row%numArray.count];
    
}
#pragma mark - ScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat offset_x = scrollView.contentOffset.x/(kScreenWidth - 20);
    
    if (offset_x>numArray.count) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        
    }else if(offset_x <0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:numArray.count  inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offset_x = scrollView.contentOffset.x/(kScreenWidth - 20);
    if (offset_x>numArray.count-1) {
        _pageControl.currentPage = (NSInteger)offset_x%numArray.count;
        
    }else{
        _pageControl.currentPage = offset_x;
        
    }
    
}
#pragma mark ReloadData
- (void)reloadDataUIWithDataArray:(NSArray *)array
{
    numArray = array;
    _pageControl.numberOfPages = array.count;

    [self.collectionView reloadData];
}

#pragma mark timerMethed
- (void)timerMethed
{
    num++;

    if (num > numArray.count-1) {
        num = 0;
        _pageControl.currentPage = num;
            self.collectionView.contentOffset = CGPointMake((kScreenWidth - 20) *num, 0);

    }else{
        _pageControl.currentPage = num;
            self.collectionView.contentOffset = CGPointMake((kScreenWidth - 20) *num, 0);
    }
}
@end
