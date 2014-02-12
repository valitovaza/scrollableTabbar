//
//  ViewController.h
//  DemoScrollableTabBar
//
//  Created by bananadev.pro on 7/21/13.
//  Copyright (c) 2013 demo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDScrollableTabBarDelegate.h"
@interface ViewController : UIViewController<IDScrollableTabBarDelegate>
@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UIView *secondView;
- (IBAction)segmentChanged:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentConrol;

@end
