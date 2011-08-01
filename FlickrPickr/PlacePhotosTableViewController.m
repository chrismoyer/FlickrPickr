//
//  PlacePhotosTableViewController.m
//  FlickrPickr
//
//  Created by Chris Moyer on 7/25/11.
//  Copyright 2011 MoeCode. All rights reserved.
//

#import "PlacePhotosTableViewController.h"
#import "FlickrFetcher.h"
#import "PhotoViewController.h"

@implementation PlacePhotosTableViewController

- (void)dealloc
{
    [photoSections release];
    [photosBySection release];
    [super dealloc];    
}

- (void)setPhotos:(NSArray *)newPhotos
{
    NSLog(@"%@", newPhotos);
    
    [photosBySection release];
    [photoSections release];
    
    photosBySection = [[NSMutableDictionary alloc] init];
    photoSections = [[NSMutableArray alloc] init];
    
    for (NSDictionary *photo in newPhotos) {
        NSNumber *dateupload = [photo objectForKey:@"dateupload"];
        double now = [[NSDate date] timeIntervalSince1970];
        double pictureTime = [dateupload doubleValue];
        double age = now - pictureTime;
        
        int ageInHours = floor(age/60/60);
        
        NSString *sectionName;
        
        if (ageInHours == 0) {
            sectionName = @"Now";
        } else {
            sectionName = [NSString stringWithFormat:@"%i hours ago", ageInHours];
        }
        
        NSLog(@"Picture is %i hours old", ageInHours);
        
        NSMutableArray *section = [photosBySection objectForKey:sectionName];
        if (!section) {
            section = [[NSMutableArray alloc] init];
            [section addObject:photo];            
            [photoSections addObject:sectionName]; 
            [photosBySection setObject:section forKey:sectionName];
            [section release];
        } else {
            [section addObject:photo];
        }        
    }
    
    NSLog(@"Sections: %@", photoSections);
    NSLog(@"Photos By Section: %@", photosBySection);
    
    [super setPhotos:newPhotos];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [photoSections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *s = [photosBySection objectForKey:[photoSections objectAtIndex:section]];
    return [s count];
}

- (NSDictionary *)photoForIndexPath:(NSIndexPath *)indexPath
{
    NSArray *s = [photosBySection objectForKey:[photoSections objectAtIndex:indexPath.section]];
    NSDictionary *p = [s objectAtIndex:indexPath.row];
    return p;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [photoSections objectAtIndex:section];
}

@end
