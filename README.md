### IDScrollableTabBar ###

![alt tag](https://raw.github.com/valitovaza/scrollableTabbar/master/IDScrollableTabBar.png)

[![Scrollable TabBar](https://raw.github.com/valitovaza/scrollableTabbar/master/video.png)](http://www.youtube.com/watch?v=wBNHplkTSLQ)

<a href = 'http://blog.bananadev.pro/2013/08/10/scrollabletabbar/' target = '_blank'>check out - http://blog.bananadev.pro/2013/08/10/scrollabletabbar/</a>


===========================================================================
DESCRIPTION:

Scrollable tab bar that highlights selected item like under magnifying glass. You can customize it as you wish!


===========================================================================

The sample demonstrates how to use IDScrollableTabBar. Project includes some customized scrollable tab bars. Add to a project IDScrollableTabBar {.h/.m}, IDScrollableTabBarItem {.h/ .m},  IDScrollableTabBarDelegate.h and all images from default folder to start using IDScrollableTabBar.
You can use images from other folders - grayImages, blueImages, crazy, ancient to customize IDScrollableTabBar or make images yourself. You should create IDItem to add items to IDScrollableTabBar: 

IDItem *item = [[IDItem alloc] initWithImage:[UIImage imageNamed:@"yourImage"] text:@"yourText"];

Then you need to create IDScrollableTabBar : 

IDScrollableTabBar *scrollableTabBar = [[IDScrollableTabBar alloc] initWithFrame:CGRectMake(0, 30, 320, 0) itemWidth:80 items:item0,item1,item2,item3,item4,item5, nil];

itemWidth - width of item, you can change this value and see how this affect the result;

To select item use -(void)setSelectedItem:(int)selectedItem animated : (BOOL) animated;

Item's image grow up in the middle of IDScrollableTabBar like under magnifying glass. You can change resize factor : 

-(void)setResizeCoeff : (float) coeff;

You can change font and color of items : 

-(void)setItemsFont : (UIFont *) font textColor : (UIColor *)color;

Use this methods to work with items : 

-(NSArray *)getItems;
-(IDScrollableTabBarItem *)itemAtIndex : (int) index;

To customize control with images use this methods : 

-(void)setArchImage : (UIImage *)image centerImage : (UIImage *)centerImage backGroundImage : (UIImage *)backGroundImage;

Also you can set shadowImages:
-(void)setShadowImageRight : (UIImage *)image;
-(void)setShadowImageLeft : (UIImage *)image;

and dividerImage : 

-(void)setDividerImage : (UIImage *)image;

===========================================================================
BUILD REQUIREMENTS:

ARC, iOS 4.1+

===========================================================================
