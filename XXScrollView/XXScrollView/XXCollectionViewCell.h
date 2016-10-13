//
//  XXCollectionViewCell.h
//  XXScrollView
//
//  Created by IOS Developer on 16/10/11.
//  Copyright © 2016年 Shaun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XXCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) UIImageView *imageView;
@property (copy, nonatomic) NSString * title;
@property (copy, nonatomic) NSString * detailTitle;

@property (nonatomic, assign) CGFloat titleHeight;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *titleBackgroundColor;

@property (nonatomic ) BOOL already;
@property (nonatomic ) BOOL grayHidden;

@end



#define K_BACKGROUNDCOLOR  [UIColor colorWithRed:(239/255.0) green:(239/255.0) blue:(244/255.0) alpha:1]

@interface UIView (XX)

- (CGSize  )size;
- (CGPoint )origin;
- (CGFloat )x;
- (CGFloat )y;
- (CGFloat )w;
- (CGFloat )h;
- (CGFloat )centerX;
- (CGFloat )centerY;
- (CGFloat )maxY;
- (CGFloat )maxX;
@end
