//
//  RecentPictureStore.h
//  FlickrPickr
//
//  Created by Chris Moyer on 7/28/11.
//  Copyright 2011 MoeCode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecentPictureStore : NSObject

+ (void)addPhoto:(NSDictionary *)photo;
+ (NSArray *)photoList;

@end
