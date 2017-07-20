//
//  XXScrollView.m
//  XXScrollView
//
//  Created by IOS Developer on 16/10/11.
//  Copyright © 2016年 Shaun. All rights reserved.
//

#import "XXScrollView.h"


#import "UIImageView+WebCache.h"

@interface XXScrollView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView * mainView;
@property (nonatomic, weak) UICollectionViewFlowLayout * flowLayout;

@property (nonatomic, strong) NSArray * imageArray;
@property (nonatomic, assign) NSInteger totalCount;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, weak) UIControl *pageControl;

@end

static NSString * const XXCellID = @"XXScrollViewCell";


@implementation XXScrollView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initialization];
        [self setupView];
    }
    return self;
}

- (void)awakeFromNib
{
    [self initialization];
    [self setupView];
    [super awakeFromNib];
}

- (void)initialization
{
    _autoScroll = YES;
    _grayImageHidden = YES;
    _hideSinglePage = YES;
    _showPageControl = YES;
    _loop = YES;
    _autoScrollTime = 3.0;
    _titleHeight = 30;
    _pageControlBottom = 30;
    _dotColor = [UIColor lightGrayColor];
    _currentDotColor = [UIColor whiteColor];
    _titleColor = K_BACKGROUNDCOLOR; 
    _titleBackgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.7];
    self.backgroundColor = K_BACKGROUNDCOLOR;
}
- (void)setupView
{
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout = flowLayout;
    
    UICollectionView * mainView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];
    mainView.backgroundColor = [UIColor clearColor];
    mainView.pagingEnabled = YES;
    mainView.showsVerticalScrollIndicator = NO;
    mainView.showsHorizontalScrollIndicator = NO;
    [mainView registerClass:[XXCollectionViewCell class] forCellWithReuseIdentifier:XXCellID];
    mainView.delegate = self;
    mainView.dataSource = self;
    [self addSubview:mainView];
    _mainView = mainView;
}

- (void)setupPageControl
{
    if (_pageControl) [_pageControl removeFromSuperview]; // 重新加载数据时调整
    
    if ((self.imageArray.count <= 1) && self.hideSinglePage) {
        return;
    }
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = self.imageArray.count;
    pageControl.currentPageIndicatorTintColor = self.currentDotColor;
    pageControl.pageIndicatorTintColor = self.dotColor;
    pageControl.userInteractionEnabled = NO;
    pageControl.defersCurrentPageDisplay = NO;
    [self addSubview:pageControl];
    _pageControl = pageControl;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _flowLayout.itemSize = self.frame.size;
    
    _mainView.frame = self.bounds;
    
    CGFloat x = self.w * 0.5;
    CGFloat y = self.h - self.pageControlBottom;
    self.pageControl.frame = CGRectMake(x, y, 0, 0);
    self.pageControl.hidden = !_showPageControl;
    
    
    _totalCount = self.loop ?  self.imageArray.count * 100 : self.imageArray.count;
}

#pragma mark Collection Delegate & datasource
- (NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.totalCount;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XXCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:XXCellID forIndexPath:indexPath];
    
    NSUInteger itemIndex = indexPath.item % self.imageArray.count;
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    cell.imageView.clipsToBounds = YES;
    
    NSString * imagePath = self.imageArray[itemIndex];
    
    if ([imagePath isKindOfClass:[NSString class]]) {
        
        if ([imagePath hasPrefix:@"http"]) {
            
            NSURL * url  = [NSURL URLWithString:imagePath];
            [cell.imageView sd_setImageWithURL:url placeholderImage:self.placeholderImage];
        }
        else
        {
            cell.imageView.image = [UIImage imageNamed:imagePath];
        }
    }
    else if ([imagePath isKindOfClass:[UIImage class]])
    {
        cell.imageView.image = (UIImage *)imagePath;
    }
    
    if (_titleArr.count && itemIndex < _titleArr.count) {
        cell.title = _titleArr[itemIndex];
        cell.detailTitle = _detailTitleArr[itemIndex];
    }
    
    if (!cell.already) {
        cell.titleHeight = self.titleHeight;
        cell.titleFont = self.titleFont;
        cell.titleColor = self.titleColor;
        cell.titleBackgroundColor = self.titleBackgroundColor;
        cell.grayHidden = self.grayImageHidden;
        cell.already = YES;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(xxScrollView:didSelectItemAtIndex:)]) {
        [self.delegate xxScrollView:self didSelectItemAtIndex:indexPath.item % self.imageArray.count];
    }
    if (self.didClickPicture) {
        self.didClickPicture(indexPath.item % self.imageArray.count);
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int itemIndex = (scrollView.contentOffset.x + self.mainView.w * 0.5) / self.mainView.w;
    if (!self.imageArray.count) return;
    
    int indexOnPageControl = itemIndex % self.imageArray.count;
    
    UIPageControl *pageControl = (UIPageControl *)_pageControl;
    pageControl.currentPage = indexOnPageControl;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    int itemIndex = (scrollView.contentOffset.x + self.mainView.w * 0.5) / self.mainView.w;
    if (!self.imageArray.count) return;
    
    int indexOnPageControl = itemIndex % self.imageArray.count;
    
    if ([self.delegate respondsToSelector:@selector(xxScrollView:didScrollIndex:)]) {
        [self.delegate xxScrollView:self didScrollIndex:indexOnPageControl];
    }
    if (self.didScrollView) {
        self.didScrollView(indexOnPageControl);
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.autoScroll) {
        [_timer invalidate];
        _timer = nil;
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.autoScroll) {
        [self setupTimer];
    }
}
- (void)setupTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTime target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)automaticScroll
{
    if (self.imageArray.count == 1) {
        [_timer invalidate];
        _timer = nil;
        return;
    }
    
    if (0 == _totalCount) return;
    
    int currentIndex = _mainView.contentOffset.x / _flowLayout.itemSize.width;
    int targetIndex = currentIndex + 1;
    
    if (targetIndex == _totalCount) {
        if (self.isLoop) {
            targetIndex = _totalCount * 0.5;
             [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        }else{
            return;
        }
        return;
    }
    [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

#pragma mark Set Action Customer

- (void)setAutoScrollTime:(CGFloat)autoScrollTime
{
    if (autoScrollTime > 0) {
        _autoScrollTime = autoScrollTime;
        
        [self setAutoScroll:self.autoScroll];
    }
}

- (void)setAutoScroll:(BOOL)autoScroll
{
    _autoScroll = autoScroll;
    [_timer invalidate];
    _timer = nil;
    
    if (_autoScroll) {
        [self setupTimer];
    }
}

- (void)setPlaceholderImage:(UIImage *)placeholderImage
{
    _placeholderImage = placeholderImage;
}

- (void)setUrlImageArr:(NSArray *)urlImageArr
{
    _imageArray = [urlImageArr copy];
    
    _totalCount = self.imageArray.count;
    
    if (_imageArray.count != 1) {
        self.mainView.scrollEnabled = YES;
        [self setAutoScroll:self.autoScroll];
    } else {
        self.mainView.scrollEnabled = NO;
    }
    
    [self setupPageControl];
    [self.mainView reloadData];
}

- (void)setLocalImageArr:(NSArray *)localImageArr
{
    _imageArray = [localImageArr copy];
    
    _totalCount = self.imageArray.count;
    
    if (_imageArray.count != 1) {
        self.mainView.scrollEnabled = YES;
        [self setAutoScroll:self.autoScroll];
    } else {
        self.mainView.scrollEnabled = NO;
    }
    
    [self setupPageControl];
    [self.mainView reloadData];
}

- (void)addClickPicture:(DidClickPictureBlock)didClickPicture
{
    _didClickPicture = didClickPicture;
}

- (void)addDidScroll:(DidScrollViewBlock)didScrollView
{
    _didScrollView = didScrollView;
}
- (void)setTitleHeight:(CGFloat)titleHeight
{
    _titleHeight = titleHeight;
}
- (void)setDotColor:(UIColor *)dotColor
{
    _dotColor = dotColor;
    
    UIPageControl *pageControl = (UIPageControl *)_pageControl;
    pageControl.pageIndicatorTintColor = dotColor;
}

- (void)setShowPageControl:(BOOL)showPageControl
{
    _showPageControl = showPageControl;
    
    _pageControl.hidden = !showPageControl;
}

- (void)setCurrentDotColor:(UIColor *)currentDotColor
{
    _currentDotColor = currentDotColor;
    
    UIPageControl *pageControl = (UIPageControl *)_pageControl;
    pageControl.currentPageIndicatorTintColor = currentDotColor;
}

- (void)dealloc {
    _mainView.delegate = nil;
    _mainView.dataSource = nil;
}
@end
