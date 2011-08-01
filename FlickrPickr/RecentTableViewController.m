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

- (void)loadPhotos
{
    self.photos = [RecentPictureStore photoList];
}

- (void)setup
{
    UITabBarItem *item = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMostRecent                                                         tag:1];
    self.tabBarItem = item;
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self loadPhotos];

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
    [self loadPhotos];
    [super viewWillAppear:animated];
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [RecentPictureStore removePhotoAtIndex:indexPath.row];
        [self loadPhotos];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

@end
