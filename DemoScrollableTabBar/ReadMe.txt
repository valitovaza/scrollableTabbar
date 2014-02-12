### DemoScrollableTabBar ###

===========================================================================
DESCRIPTION:

This sample demonstrates how to use IDScrollableTabBar. Project includes some customized scrollable tab bars. Add to a project IDScrollableTabBar {.h/.m}, IDScrollableTabBarItem {.h/ .m},  IDScrollableTabBarDelegate.h and all images from default folder to start using IDScrollableTabBar.
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

About images :

                   |--------------------|
                   |   1)               |
 __________________|___  _______  ______|_____________________
|                  |                    |                     |
|       0)         |                    |                     |
|                  |                    |                     |
|__________________|____________________|_____________________|


0 - backgroundImage
1 - centerImage

CenterImage highlights selected item. Selected item is located in the middle of control. Height of centerImage must be greater or equal background's height.


                   |--------------------|
                   | 2)_______________  |
 __________________|__|  _______  ____|_|_____________________
|                  |  |               | |                     |
|                  |  |               | |                     |
|                  |  |               | |                     |
|__________________|__|_______________|_|_____________________|


2 - archImage

ArchImage's size must be equal centerImage's size.

                   |--------------------|
                   |   _______________  |
 __________________|__|  _______  ____|_|_____________________
|    |             |  |               | |               |     |
| 3) |             |  |               | |               | 4)  |
|    |             |  |               | |               |     |
|____|_____________|__|_______________|_|_______________|_____|

3 - shadowLeftImage
4 - shadowRightImage

                   |--------------------|
                   |   _______________  |
 __________________|__|  _______  ____|_|_____________________
|     |  |         |  |               | |                     |
|     |5)|         |  |               | |                     |
|     |  |         |  |               | |                     |
|_____|__|_________|__|_______________|_|_____________________|

5 - dividerImage

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