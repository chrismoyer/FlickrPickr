//
//  RecentPictureStore.m
//  FlickrPickr
//
//  Created by Chris Moyer on 7/28/11.
//  Copyright 2011 MoeCode. All rights reserved.
//

#import "RecentPictureStore.h"

@implementation RecentPictureStore


- (id)init
{
    self = [super init];
    if (self) {
        //
    }
    
    return self;
}

#define MAX_PHOTOS 15

+ (void)addPhoto:(NSDictionary *)photo
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *photos = [defaults mutableArrayValueForKey:@"recent_photos"];
    if (!photos) {
        photos = [[[NSMutableArray alloc] init] autorelease];
    }    
    
    for (NSDictionary *p in photos) {
        if ([[p objectForKey:@"id"] isEqualToString:[photo objectForKey:@"id"]]) {
            [photos removeObject:p];
        }                        
    }
    
    [photos insertObject:photo atIndex:0];
    
    if ([photos count] > MAX_PHOTOS) {
        [photos removeLastObject];
    }
    
    NSLog(@"%@", photos);
    
    [defaults setValue:photos forKey:@"recent_photos"];
    [defaults synchronize];
}

+ (void)removePhotoAtIndex:(NSInteger)index
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *photos = [defaults mutableArrayValueForKey:@"recent_photos"];
    
    [photos removeObjectAtIndex:index];
    [defaults setValue:photos forKey:@"recent_photos"];
    [defaults synchronize];   
}

+ (NSArray *)photoList
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *photos = [defaults mutableArrayValueForKey:@"recent_photos"];

    
    return photos;
}


@end
