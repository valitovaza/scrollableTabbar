//
//  IDScrollableTabBarDelegate.h
//  ScrollableTabBar
//
//  Created by bananadev.pro on 7/17/13.
//  Copyright (c) 2013 demo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IDScrollableTabBarDelegate <NSObject>
-(void)scrollTabBarAction : (NSNumber *)selectedNumber sender : (id) sender;
@end
