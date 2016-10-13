//
//  XXCollectionViewCell.m
//  XXScrollView
//
//  Created by IOS Developer on 16/10/11.
//  Copyright © 2016年 Shaun. All rights reserved.
//

#import "XXCollectionViewCell.h"

@interface XXCollectionViewCell()
{
    UILabel * _titleLabel;
    UILabel * _detailLabel;
    UIImageView * grayImage;
    UIView * _BGView;
}

#define GRAYPICTURE @"gradient-gray"

@end
@implementation XXCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setImageView];
        [self setBackground];
        [self setTitle];
    }
    return self;
}
- (void)setBackground
{
    _BGView = [UIView new];
    [self addSubview:_BGView];
}
- (void)setImageView
{
    UIImageView * imageView = [[UIImageView alloc]init];
    _imageView = imageView;
    [self addSubview:imageView];
    
    grayImage = [UIImageView new];
    
    grayImage.image = [UIImage imageNamed:GRAYPICTURE];
    [self addSubview:grayImage];
}
- (void)setTitle
{
    UILabel * titleLabel = [[UILabel alloc]init];
    titleLabel.numberOfLines = 0;
    _titleLabel = titleLabel;
    
    UILabel * detailLabel = [[UILabel alloc]init];
    _detailLabel = detailLabel;
    _detailLabel.font = [UIFont systemFontOfSize:20];
    detailLabel.numberOfLines = 0;
    
    [self addSubview:titleLabel];
    [self addSubview:detailLabel];
}
- (void)setTitle:(NSString *)title
{
    if ([self isNull:title]) {
        _titleLabel.hidden = YES;
    }else{
        _titleLabel.text = [NSString stringWithFormat:@"%@",title];
    }
}
- (void)setDetailTitle:(NSString *)detailTitle
{
    if ([self isNull:detailTitle]) {
        _detailLabel.hidden = YES;
    }else{
        _detailLabel.text = [NSString stringWithFormat:@"%@",detailTitle];
    }
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    _titleLabel.textColor = titleColor;
}
- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    _titleLabel.font = titleFont;
}
- (void)setTitleBackgroundColor:(UIColor *)titleBackgroundColor
{
    _titleBackgroundColor = titleBackgroundColor;
    _BGView.backgroundColor = titleBackgroundColor;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    _imageView.frame = self.bounds;
    grayImage.frame  = self.bounds;
    
    CGFloat margin = 20;
    CGFloat w = self.w - margin*2;
    CGFloat h = _titleHeight;
    CGFloat x = margin;
    CGFloat y = self.h - h;
    _titleLabel.frame = CGRectMake(x, y, w, h);
    
    CGFloat detailTextH = (self.h - h)/2;
    _detailLabel.frame = CGRectMake(margin, detailTextH , w, detailTextH);
    _BGView.frame = CGRectMake(0, y, self.w, h);
    
    grayImage.hidden = _grayHidden;
}


/**
 *  @return YES 就是为空
 */

- (BOOL) isNull:(id )object {
    if ([object isEqual:[NSNull null]]) {
        return YES;
    }
    else if ([object isKindOfClass:[NSNull class]]){
        return YES;
    }
    else if (object == nil){
        return YES;
    }
    else {
        if ([object isKindOfClass:[NSString class]]) {
            if ([object isEqualToString:@""] || [object isEqualToString:@"(null)"]||[object isEqualToString:@"<null>"]) {
                return YES;
            }else if([object isKindOfClass:[NSArray class]]) {
                if ([object count] == 0) {
                    return YES;
                }
            }else if ([object isKindOfClass:[NSDictionary class]]){
                if ([object count] == 0) {
                    return YES;
                }
            }
            return NO;
        }
        return NO;
    }
    return NO;
}
@end


@implementation UIView (XX)

- (CGSize  )size
{
    return  self.frame.size;
}
- (CGPoint )origin
{
    return self.frame.origin;
}
- (CGFloat )x
{
    return self.origin.x;
}
- (CGFloat )y
{
    return self.origin.y;
}
- (CGFloat )w
{
    return self.size.width;
}
- (CGFloat )h
{
    return self.size.height;
}
- (CGFloat )centerX
{
    return self.center.x;
}
- (CGFloat )centerY
{
    return self.center.y;
}
- (CGFloat )maxY
{
    return CGRectGetMaxY(self.frame);
}
- (CGFloat )maxX
{
    return CGRectGetMaxX(self.frame);
}
@end
