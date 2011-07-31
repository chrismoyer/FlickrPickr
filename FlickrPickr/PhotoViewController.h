//
//  PhotoViewController.h
//  FlickrPickr
//
//  Created by Chris Moyer on 7/25/11.
//  Copyright 2011 MoeCode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController  <UIScrollViewDelegate>
{
    NSDictionary *photo;
    UIImageView *imageView;
    UIScrollView *scrollView;
    UIImage *image;
}

@property (retain) NSDictionary *photo;
@property (retain) UIImageView *imageView;
@property (retain) UIScrollView *scrollView;
@property (retain) UIImage *image;
@end
