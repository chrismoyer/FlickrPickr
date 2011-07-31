//
//  FlickrFetcher.h
//
//  Created for Stanford CS193p Fall 2010
//  Copyright Stanford University
//

#import <Foundation/Foundation.h>

typedef enum {
	FlickrFetcherPhotoFormatSquare,
	FlickrFetcherPhotoFormatLarge,
	FlickrFetcherPhotoFormatThumbnail,
	FlickrFetcherPhotoFormatSmall,
	FlickrFetcherPhotoFormatMedium,
	FlickrFetcherPhotoFormatOriginal
} FlickrFetcherPhotoFormat;

@interface FlickrFetcher : NSObject

// Returns place structures for the top 100 recent places photos were taken.
// It is highly recommended to call NSLog(@"%@", [FlickrFetcher topPlaces]) and look in the console to get an idea what Flickr returns.

+ (NSArray *)topPlaces;

// Returns an array of photo structures recently taken at the place specified by flickrPlaceId.
// The flickrPlaceId comes out of the dictionaries returned in the array from topPlaces (key is "place_id").

+ (NSArray *)photosAtPlace:(NSString *)flickrPlaceId;

// Returns a photo's image data for a given dictionary of flickr information about that photo.
// The returned NSData is suitable to be passed to [UIImage imageWithData:] or stored in a file or Core Data database.
// All four keys (id, server, farm, secret) must be in the flickrInfo dictionary or this will return nil.
// The dictionaries returned in the arrays by the method above are suitable for passing to this method unmodified.

+ (NSData *)imageDataForPhotoWithFlickrInfo:(NSDictionary *)flickrInfo format:(FlickrFetcherPhotoFormat)format;
+ (NSString *)urlStringForPhotoWithFlickrInfo:(NSDictionary *)flickrInfo format:(FlickrFetcherPhotoFormat)format;
+ (NSData *)imageDataForPhotoWithURLString:(NSString *)urlString;

@end
