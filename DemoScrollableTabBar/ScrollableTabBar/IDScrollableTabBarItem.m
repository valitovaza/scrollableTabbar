//
//  IDScrollableTabBarItem.m
//  ScrollableTabBar
//
//  Created by bananadev.pro on 7/17/13.
//  Copyright (c) 2013 demo. All rights reserved.
//

#import "IDScrollableTabBarItem.h"

#define LABEL_HEIGHT 16.f

@interface IDScrollableTabBarItem (){
    CGRect _initialImageRect;
    UIImageView *_imgViewDivider;
    float _halfTabBarWidth;
    float _additionResizeCoeff;
    float _archWidth;
    UIImage *_mainImage;
}
@end
@implementation IDScrollableTabBarItem

-(void)dealloc{
    _imgViewDivider = nil;
    [self setLabel:nil];
    [self setImageView:nil];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)setResizeCoeff : (float) coeff{
    _additionResizeCoeff = coeff;
    //resize image
    CGSize imageSize = _mainImage.size;
    [self.imageView setImage:_mainImage];
    CGRect rect = CGRectMake(0, 0, imageSize.width / (1 + _additionResizeCoeff), imageSize.height / (1 + _additionResizeCoeff));
    rect.origin.x = self.frame.size.width / 2.f - rect.size.width / 2.f;
    rect.origin.y = (self.frame.size.height - LABEL_HEIGHT) / 2.f - rect.size.height / 2.f + 5.f;
    [self.imageView setFrame:rect];
    _initialImageRect = rect;
}
- (id)initWithFrame:(CGRect)frame image : (UIImage *)image text : (NSString*)text dividerImage : (UIImage *) dividerImage halfTabBarWidth : (float) halfTabBarWidth additionResizeCoeff : (float) additionResizeCoeff archWidth : (float) archWidth{
    self = [self initWithFrame:frame];
    if (self) {
        // Initialization code
        _halfTabBarWidth = halfTabBarWidth;
        _additionResizeCoeff = additionResizeCoeff;
        _archWidth = archWidth;
        
        self.backgroundColor = [UIColor clearColor];
        self.imageView = [[UIImageView alloc] initWithImage:image];
        CGSize imageSize = image.size;
        //resize image
        _mainImage = image;
        CGRect rect = CGRectMake(0, 0, imageSize.width / (1 + additionResizeCoeff), imageSize.height / (1 + additionResizeCoeff));
        rect.origin.x = frame.size.width / 2.f - rect.size.width / 2.f;
        rect.origin.y = (frame.size.height - LABEL_HEIGHT) / 2.f - rect.size.height / 2.f + 5.f;
        [self.imageView setFrame:rect];
        _initialImageRect = rect;
        [self addSubview:self.imageView];
        //divider
        _imgViewDivider = [[UIImageView alloc] initWithImage:dividerImage];
        _imgViewDivider.userInteractionEnabled = NO;
        rect = _imgViewDivider.frame;
        rect.origin.y = self.frame.origin.y;
        rect.origin.x = self.frame.origin.x - rect.size.width / 2.f;
        [_imgViewDivider setFrame:rect];
        //label
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height - LABEL_HEIGHT, frame.size.width, LABEL_HEIGHT)];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.backgroundColor = [UIColor clearColor];
        self.label.textColor = [UIColor whiteColor];
        self.label.font = [UIFont boldSystemFontOfSize:8.0];
        self.label.numberOfLines = 0;
        self.label.text = text;
        [self addSubview:self.label];
    }
    [self setFrame:frame];
    return self;
}
-(void)correctPositions{
    CGRect rect = self.label.frame;
    rect.origin.y = self.frame.size.height - LABEL_HEIGHT;
    [self.label setFrame:rect];
    
    CGSize imageSize = _mainImage.size;
    rect = CGRectMake(0, 0, imageSize.width / (1 + _additionResizeCoeff), imageSize.height / (1 + _additionResizeCoeff));
    rect.origin.x = self.frame.size.width / 2.f - rect.size.width / 2.f;
    rect.origin.y = (self.frame.size.height - LABEL_HEIGHT) / 2.f - rect.size.height / 2.f + 5.f;
    _initialImageRect = rect;
}
-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    //move divider
    CGRect rect = _imgViewDivider.frame;
    rect.origin.x = self.frame.origin.x - rect.size.width / 2.f;
    [_imgViewDivider setFrame:rect];
    //resize image
    float halfWidth = frame.size.width / 2;
    float halfScrennWidth = _halfTabBarWidth;
    float center = frame.origin.x + halfWidth;
    float diff = ABS(halfScrennWidth - center);
    rect = self.imageView.frame;
    if (diff < halfWidth) {
        float resizeFactorCoeff = 1 - ABS(diff / halfWidth);
        float resizeFactor = 1 + _additionResizeCoeff * resizeFactorCoeff;
        rect.size.width = _initialImageRect.size.width * resizeFactor;
        rect.size.height = _initialImageRect.size.height * resizeFactor;
        float diffX = (_initialImageRect.size.width * resizeFactor - _initialImageRect.size.width) / 2;
        float diffY = (_initialImageRect.size.height * resizeFactor - _initialImageRect.size.height);
        rect.origin.x = _initialImageRect.origin.x - diffX;
        rect.origin.y = _initialImageRect.origin.y - diffY;
    }else{
        rect = _initialImageRect;
    }
    [self.imageView setFrame:rect];
}

@end
@implementation IDItem

- (id)initWithImage : (UIImage *)image text : (NSString*)text{
    self = [super init];
    if (self) {
        // Initialization code
        _image = image;
        _text = text;
    }
    return self;
}

@end