//
//  XXScrollView.h
//  XXScrollView
//
//  Created by IOS Developer on 16/10/11.
//  Copyright © 2016年 Shaun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXCollectionViewCell.h"
#pragma Delegate

@class XXScrollView;

@protocol XXScrollViewDelegate <NSObject>

@optional

/**     ----     Picture Click  Delegate  ----     */
- (void)xxScrollView:(XXScrollView *)scrollView didSelectItemAtIndex:(NSInteger)index;

/**     ----     Picture Scroll Delegate  ----     */
- (void)xxScrollView:(XXScrollView *)scrollView didScrollIndex:(NSInteger)index;

@end

#pragma Block

typedef void(^DidClickPictureBlock)(NSUInteger currentIndex);
typedef void(^DidScrollViewBlock)(NSUInteger currentIndex);

@interface XXScrollView : UIView

@property (nonatomic, weak) id<XXScrollViewDelegate>delegate;
@property (nonatomic, copy) DidClickPictureBlock didClickPicture;
@property (nonatomic, copy) DidScrollViewBlock didScrollView;

- (void)addDidScroll:(DidScrollViewBlock )didScrollView;
- (void)addClickPicture:(DidClickPictureBlock )didClickPicture;


/**  >>>>>  DataSource  API  <<<<<  */

/**     ----     Local picture  array  ----     */
@property (nonatomic, strong) NSArray * localImageArr;

/**     ----     Network picture  array  ----     */
@property (nonatomic, strong) NSArray * urlImageArr;

/**     ----     Picture  title  ----     */
@property (nonatomic, strong) NSArray * titleArr;

/**     ----     Picture  detailTitle  ----     */
@property (nonatomic, strong) NSArray * detailTitleArr;


/**  >>>>>  Rolling Control  <<<<<  */

/**     ----     Automatic rolling time, default  3s   ----     */
@property (nonatomic, assign) CGFloat autoScrollTime;

/**     ----     infiniteLoop, default  YES   ----      */
@property (nonatomic,getter = isLoop ) BOOL loop;

/**     ----     Automatic rolling,default YES     ----     */
@property (nonatomic) BOOL autoScroll;


/**  >>>>>   The custom @property  <<<<<  */

/**     ----         ----     */

@property (nonatomic, strong) UIImage *placeholderImage;

@property (nonatomic ) BOOL hideSinglePage;               // default YES
@property (nonatomic ) BOOL showPageControl;              // default YES
@property (nonatomic ) BOOL grayImageHidden;              // default YES

@property (nonatomic, strong) UIColor *currentDotColor;
@property (nonatomic, strong) UIColor *dotColor;


@property (nonatomic, assign) CGFloat pageControlBottom; // default 30.0
@property (nonatomic, assign) CGFloat titleHeight;       // default 30.0

@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *titleBackgroundColor;

@end
