//
//  ShufflingView.h
//  ShufflingTest
//
//  Created by L on 17/6/6.
//  Copyright © 2017年 LJL. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ShufflingDelegate <NSObject>

@optional
//点击某个轮播图的指定的位置
- (void)didSelectWithIndex:(NSInteger)index;

@end
@interface ShufflingView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>
{
    NSArray *numArray;
}

@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) id<ShufflingDelegate> delegate;

- (void)reloadDataUIWithDataArray:(NSArray *)array;
@end

