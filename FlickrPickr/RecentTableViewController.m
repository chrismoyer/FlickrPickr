//
//  RecentTableViewController.m
//  FlickrPickr
//
//  Created by Chris Moyer on 7/25/11.
//  Copyright 2011 MoeCode. All rights reserved.
//

#import "RecentTableViewController.h"
#import "FlickrFetcher.h"
#import "RecentPictureStore.h"

@implementation RecentTableViewController

- (void)setup
{
    UITabBarItem *item = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMostRecent                                                         tag:1];
    self.tabBarItem = item;
    
    self.photos = [RecentPictureStore photoList];
    [item release];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        [self setup];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
    self.photos = [RecentPictureStore photoList];
    [super viewWillAppear:animated];
}


@end
