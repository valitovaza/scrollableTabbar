//
//  IDScrollableTabBar.h
//  ScrollableTabBar
//
//  Created by bananadev.pro on 7/17/13.
//  Copyright (c) 2013 demo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDScrollableTabBarDelegate.h"
#import "IDScrollableTabBarItem.h"
@interface IDScrollableTabBar : UIView<UIGestureRecognizerDelegate>
@property (nonatomic, weak) NSObject<IDScrollableTabBarDelegate> *delegate;
@property (nonatomic, readonly) int selectedItem;

- (id)initWithFrame:(CGRect)frame itemWidth : (float) itemWidth items : (IDItem *)item, ...;
-(void)setArchImage : (UIImage *)image centerImage : (UIImage *)centerImage backGroundImage : (UIImage *)backGroundImage;
-(void)setDividerImage : (UIImage *)image;
-(void)setResizeCoeff : (float) coeff;

-(void)setShadowImageRight : (UIImage *)image;
-(void)setShadowImageLeft : (UIImage *)image;
-(void)setItemsFont : (UIFont *) font textColor : (UIColor *)color;
-(void)setSelectedItem:(int)selectedItem animated : (BOOL) animated;

-(NSArray *)getItems;
-(IDScrollableTabBarItem *)itemAtIndex : (int) index;
@end
