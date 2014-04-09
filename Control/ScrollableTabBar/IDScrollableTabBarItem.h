//
//  IDScrollableTabBarItem.h
//  ScrollableTabBar
//
//  Created by bananadev.pro on 7/17/13.
//  Copyright (c) 2013 demo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IDScrollableTabBarItem : UIView
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UILabel *label;
@property (nonatomic, readwrite) float archWidth;
@property (nonatomic, readwrite) float halfTabBarWidth;
@property (nonatomic, retain) UIImageView *imgViewDivider;
- (id)initWithFrame:(CGRect)frame image : (UIImage *)image text : (NSString*)text dividerImage : (UIImage *) dividerImage halfTabBarWidth : (float) halfTabBarWidth additionResizeCoeff : (float) additionResizeCoeff archWidth : (float) archWidth;
-(void)setResizeCoeff : (float) coeff;
-(void)correctPositions;
@end
@interface IDItem : NSObject
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) NSString *text;
- (id)initWithImage : (UIImage *)image text : (NSString*)text;

@end