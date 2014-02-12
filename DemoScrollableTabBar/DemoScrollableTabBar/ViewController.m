//
//  ViewController.m
//  DemoScrollableTabBar
//
//  Created by bananadev.pro on 7/21/13.
//  Copyright (c) 2013 demo. All rights reserved.
//

#import "ViewController.h"
#import "IDScrollableTabBar.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //create items
    IDItem *itemClock = [[IDItem alloc] initWithImage:[UIImage imageNamed:@"clock"] text:@"clock"];
    IDItem *itemCamera = [[IDItem alloc] initWithImage:[UIImage imageNamed:@"camera"] text:@"camera"];
    IDItem *itemMail = [[IDItem alloc] initWithImage:[UIImage imageNamed:@"mail"] text:@"e-mail"];
    IDItem *itemFave = [[IDItem alloc] initWithImage:[UIImage imageNamed:@"fave"] text:@"favourite"];
    IDItem *itemGames = [[IDItem alloc] initWithImage:[UIImage imageNamed:@"games"] text:@"games"];
    IDItem *itemSettings = [[IDItem alloc] initWithImage:[UIImage imageNamed:@"settings"] text:@"settings"];
    IDItem *itemMusic = [[IDItem alloc] initWithImage:[UIImage imageNamed:@"music"] text:@"music"];
    IDItem *itemZip = [[IDItem alloc] initWithImage:[UIImage imageNamed:@"zip"] text:@"zip"];
    //scrollable tab bar by default
    //require default folder
    IDScrollableTabBar *scrollableTabBar = [[IDScrollableTabBar alloc] initWithFrame:CGRectMake(0, 30, 320, 0) itemWidth:80 items:itemClock,itemCamera,itemMail,itemFave,itemGames,itemSettings,itemMusic,itemZip, nil];
    scrollableTabBar.delegate = self;
    scrollableTabBar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
    [scrollableTabBar setSelectedItem:0 animated:NO];
    [self.firstView addSubview:scrollableTabBar];
    
    //blue scrollable tab bar
    //require blueImages folder
    IDScrollableTabBar *scrollableTabBarBlue = [[IDScrollableTabBar alloc] initWithFrame:CGRectMake(0, 150, 320, 0) itemWidth:80 items:itemClock,itemCamera,itemMail,itemFave,itemGames,itemSettings,itemMusic,itemZip, nil];
    scrollableTabBarBlue.delegate = self;
    scrollableTabBarBlue.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
    [scrollableTabBarBlue setArchImage:[UIImage imageNamed:@"blueArch"] centerImage:[UIImage imageNamed:@"blueCenter"] backGroundImage:[UIImage imageNamed:@"blueBackground"]];
    [scrollableTabBarBlue setDividerImage:[UIImage imageNamed:@"blueDivider"]];
    [scrollableTabBarBlue setShadowImageRight:[UIImage imageNamed:@"blueShadowRight"]];
    [scrollableTabBarBlue setShadowImageLeft:[UIImage imageNamed:@"blueShadowLeft"]];
    [self.firstView addSubview:scrollableTabBarBlue];
    
    //gray scrollable tab bar
    //require grayImages folder
    IDScrollableTabBar *scrollableTabBarGray = [[IDScrollableTabBar alloc] initWithFrame:CGRectMake(0, 300, 320, 0) itemWidth:80 items:itemClock,itemCamera,itemMail,itemFave,itemGames,itemSettings,itemMusic,itemZip, nil];
    scrollableTabBarGray.delegate = self;
    scrollableTabBarGray.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
    [scrollableTabBarGray setArchImage:[UIImage imageNamed:@"grayArch"] centerImage:[UIImage imageNamed:@"grayCenter"] backGroundImage:[UIImage imageNamed:@"grayBackground"]];
    [scrollableTabBarGray setResizeCoeff:0.2f];
    //you can hide divider image and shadow images
    [scrollableTabBarGray setDividerImage:nil];
    [scrollableTabBarGray setShadowImageRight:nil];
    [scrollableTabBarGray setShadowImageLeft:nil];
    [self.firstView addSubview:scrollableTabBarGray];
    
    self.secondView.hidden = YES;
    
    //colored scrollable tab bar
    //require crazy folder
    IDScrollableTabBar *scrollableTabBarColored = [[IDScrollableTabBar alloc] initWithFrame:CGRectMake(0, 1, 320, 0) itemWidth:80 items:itemClock,itemCamera,itemMail,itemFave,itemGames,itemSettings,itemMusic,itemZip, nil];
    scrollableTabBarColored.delegate = self;
    scrollableTabBarColored.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
    [scrollableTabBarColored setArchImage:[UIImage imageNamed:@"crazyArch"] centerImage:[UIImage imageNamed:@"crazyCenter"] backGroundImage:[UIImage imageNamed:@"crazyBackground"]];
    [scrollableTabBarColored setDividerImage:nil];
    [scrollableTabBarColored setShadowImageRight:nil];
    [scrollableTabBarColored setShadowImageLeft:nil];
    [self.secondView addSubview:scrollableTabBarColored];
    
    //ancient scrollable tab bar =)
    IDItem *itemAncient0 = [[IDItem alloc] initWithImage:[UIImage imageNamed:@"ancientIcon0"] text:@"image 0"];
    IDItem *itemAncient1 = [[IDItem alloc] initWithImage:[UIImage imageNamed:@"ancientIcon1"] text:@"image 1"];
    IDItem *itemAncient2 = [[IDItem alloc] initWithImage:[UIImage imageNamed:@"ancientIcon2"] text:@"image 2"];
    IDItem *itemAncient3 = [[IDItem alloc] initWithImage:[UIImage imageNamed:@"ancientIcon3"] text:@"image 3"];
    IDItem *itemAncient4 = [[IDItem alloc] initWithImage:[UIImage imageNamed:@"ancientIcon4"] text:@"image 4"];
    IDItem *itemAncient5 = [[IDItem alloc] initWithImage:[UIImage imageNamed:@"ancientIcon5"] text:@"image 5"];
    IDItem *itemAncient6 = [[IDItem alloc] initWithImage:[UIImage imageNamed:@"ancientIcon6"] text:@"image 6"];
    IDScrollableTabBar *scrollableTabBarAncient = [[IDScrollableTabBar alloc] initWithFrame:CGRectMake(0, 220, 320, 0) itemWidth:120 items:itemAncient0,itemAncient1,itemAncient2,itemAncient3,itemAncient4,itemAncient5,itemAncient6, nil];
    scrollableTabBarAncient.delegate = self;
    scrollableTabBarAncient.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
    //ancient
    [scrollableTabBarAncient setArchImage:[UIImage imageNamed:@"ancientArch"] centerImage:[UIImage imageNamed:@"ancientCenter"] backGroundImage:[UIImage imageNamed:@"ancientBackground"]];
    [scrollableTabBarAncient setDividerImage:[UIImage imageNamed:@"ancientDivider"]];
    //don't have shadow
    [scrollableTabBarAncient setShadowImageRight:nil];
    [scrollableTabBarAncient setShadowImageLeft:nil];
    //you can modify item's label
    UIFont *font = [UIFont fontWithName:@"Katy Berry" size:25];
    for (IDScrollableTabBarItem *item in [scrollableTabBarAncient getItems]) {
        CGRect rect = item.label.frame;
        rect.origin.y -= 25.f;
        rect.size.height = 20.f;
        [item.label setFrame:rect];
        [item.label setFont:font];
        [item.label setTextColor:[UIColor darkGrayColor]];
    }
    [self.secondView addSubview:scrollableTabBarAncient];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)scrollTabBarAction : (NSNumber *)selectedNumber sender:(id)sender{
    NSLog(@"selectedNumber - %@", selectedNumber);
}
- (void)viewDidUnload {
    [self setFirstView:nil];
    [self setSecondView:nil];
    [self setSegmentConrol:nil];
    [super viewDidUnload];
}
- (IBAction)segmentChanged:(id)sender {
    if (self.segmentConrol.selectedSegmentIndex == 0) {
        self.secondView.hidden = YES;
    }else{
        self.secondView.hidden = NO;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}
@end
