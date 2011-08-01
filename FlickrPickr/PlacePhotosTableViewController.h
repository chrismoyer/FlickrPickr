//
//  PlacePhotosTableViewController.h
//  FlickrPickr
//
//  Created by Chris Moyer on 7/25/11.
//  Copyright 2011 MoeCode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoTableViewController.h"

@interface PlacePhotosTableViewController : PhotoTableViewController
{
    NSMutableDictionary *photosBySection;
    NSMutableArray *photoSections;
}

@end
