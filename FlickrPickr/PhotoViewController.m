//
//  PhotoViewController.m
//  FlickrPickr
//
//  Created by Chris Moyer on 7/25/11.
//  Copyright 2011 MoeCode. All rights reserved.
//

#import "PhotoViewController.h"
#import "FlickrFetcher.h"

@implementation PhotoViewController

@synthesize photo, imageView, image, scrollView;

- (void)dealloc
{
    [photo release];
    [imageView release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    // Get the image
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSData *imageData = [FlickrFetcher imageDataForPhotoWithFlickrInfo:photo format:FlickrFetcherPhotoFormatLarge];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    NSLog(@"Loaded data with size: %i", [imageData length]);
    UIImage *i = [UIImage imageWithData:imageData];
    
    self.image = i;
    
    UIImageView *iv = [[UIImageView alloc] initWithImage:i];
    self.imageView = iv;
    [iv release];
    
    UIScrollView *sv = [[UIScrollView alloc] init];
    //scrollView.contentMode = UIViewContentModeScaleToFill;
	sv.contentSize = i.size;
	[sv addSubview:self.imageView];
    
	sv.bounces = NO;
	sv.minimumZoomScale = 0.1;
	sv.maximumZoomScale = 6.0;
	sv.delegate = self; 

    self.scrollView = sv;
    
    self.view = sv;
    [sv release];
   
}

- (void)viewWillAppear:(BOOL)animated
{
    CGRect viewRect = scrollView.bounds;
    
    float screenAspect = viewRect.size.width / viewRect.size.height;
    float imageAspect = image.size.width/image.size.height;
    
    NSLog(@"Image Size %fx%f with ar %f", image.size.width, image.size.height, imageAspect);
    NSLog(@"Frame Size %fx%f with ar %f", viewRect.size.width, viewRect.size.height, screenAspect);
    
    CGRect zoomRect;
    
    if (imageAspect > screenAspect) {
        zoomRect = CGRectMake(0, 0, image.size.height * screenAspect, image.size.height);
    } else {
        zoomRect = CGRectMake(0, 0, image.size.width, image.size.width / screenAspect);
    }
    
    zoomRect.origin.x = (image.size.width - zoomRect.size.width) / 2;
    zoomRect.origin.y = (image.size.height - zoomRect.size.height) / 2;
    
    NSLog(@"Zoomrect %f,%f - %fx%f with ar %f", zoomRect.origin.x, zoomRect.origin.y, 
          zoomRect.size.width, zoomRect.size.height, zoomRect.size.width / zoomRect.size.height);
    
    [scrollView zoomToRect:zoomRect animated:NO];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)sender
{
    return self.imageView;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    
    
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait ||
            interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
            interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

@end
