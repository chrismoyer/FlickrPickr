//
//  FlickrPickrAppDelegate.h
//  FlickrPickr
//
//  Created by Chris Moyer on 7/25/11.
//  Copyright 2011 MoeCode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlickrPickrAppDelegate : NSObject <UIApplicationDelegate>
{
    UITabBarController *tabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end
