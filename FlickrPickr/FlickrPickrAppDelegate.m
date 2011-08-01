//
//  FlickrPickrAppDelegate.m
//  FlickrPickr
//
//  Created by Chris Moyer on 7/25/11.
//  Copyright 2011 MoeCode. All rights reserved.
//

#import "FlickrPickrAppDelegate.h"
#import "PlacesTableViewController.h"
#import "RecentTableViewController.h"

@interface FlickrPickrAppDelegate()

@property (readonly) BOOL iPad;

@end


@implementation FlickrPickrAppDelegate

@synthesize window = _window;

- (BOOL)iPad
{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UINavigationController *nav1 = [[UINavigationController alloc] init];
    PlacesTableViewController *ptvc = [[PlacesTableViewController alloc] init];
    ptvc.title = @"Places";
    [nav1 pushViewController:ptvc animated:NO];

    UINavigationController *nav2 = [[UINavigationController alloc] init];
    RecentTableViewController *rtvc = [[RecentTableViewController alloc] init];
    rtvc.title = @"Recent";
    [nav2 pushViewController:rtvc animated:NO];
    
    UITabBarController *tbc = [[UITabBarController alloc] init];
    tbc.viewControllers = [NSArray arrayWithObjects:nav1, nav2, nil];
    tabBarController = tbc;
    
//    if (self.iPad) {
//        UISplitViewController *svc = [[UISplitViewController alloc] init];
//        UINavigationController *rightNav = [[UINavigationController alloc] init];
//        rightNav.navigationBar.barStyle = UIBarStyleBlackOpaque;
//        
//        
//    }
    
    [nav1 release];
    [nav2 release];
    [ptvc release];
    [rtvc release];
    
    [self.window addSubview:tbc.view];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [tabBarController release];
    [_window release];
    [super dealloc];
}

@end
