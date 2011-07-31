//
//  FlickrFetcher.m
//
//  Created for Stanford CS193p Fall 2010
//  Copyright Stanford University
//

#import "FlickrFetcher.h"
#import "FlickrAPIKey.h"
#import "JSON.h"

@implementation FlickrFetcher

static int maxResults = 50;
+ (void)setMaximumResultsPerQuery:(int)anInt { if (anInt > 0) maxResults = anInt; }
+ (int)maximumResultsPerQuery { return maxResults; }

// Adds the common part of a flickr request api url, the api_key and the json specifiers, then performs the query, converts from JSON, and returns.

+ (NSDictionary *)flickrQuery:(NSString *)queryString
{
	NSString *urlString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.%@&api_key=%@&format=json&nojsoncallback=1", queryString, FlickrAPIKey];
	NSLog(@"Sent to Flickr: %@", urlString);
	return [[NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding error:nil] JSONValue];
}

+ (NSArray *)topPlaces
{
	return [[[self flickrQuery:@"places.getTopPlacesList&place_type_id=7"] objectForKey:@"places"] objectForKey:@"place"];
}

// Core flickr.photos.search method.
//
// tags can be nil
// lastUploadDate can be nil (will only fetch recent photos, per flickr api limitations)
// additionalArguments can be any flickr.photos.search argument
// ... for example &place_id=63v7zaqQCZxX& (Vancouver)
// ... or &tag_mode=all (to match all tags, not "any" tag which is the default)
//
// This method could probably be public (although it exposes the flickr url api via additionalArguments),
// but for simplicity of the API it is currently private.

+ (NSArray *)photosWithTags:(NSArray *)tags uploadedSince:(NSDate *)lastUploadDate additionalArguments:(NSString *)additionalArguments
{
	NSMutableString *tagsString = [[NSMutableString alloc] init];
	for (NSString *tag in tags) {
		if ([tagsString length]) {
			[tagsString appendFormat:@",%@", tag];
		} else {
			[tagsString appendFormat:@"&tags=%@", tag];
		}
	}
	[tagsString autorelease];

	NSString *lastUploadString = @"";
	if (lastUploadDate) {
		lastUploadString = [NSString stringWithFormat:@"&min_upload_date=%.10g", [lastUploadDate timeIntervalSince1970]];
	}

	if (!additionalArguments) additionalArguments = @"";

	// someday we should invent a FlickrFetcherDelegate to return pagewise results
	unsigned int page = 1;
	unsigned int perPage = maxResults;

	NSDictionary *flickrQueryResults = [self flickrQuery:[NSString stringWithFormat:@"photos.search&page=%d&per_page=%d%@%@%@&extras=original_format,tags,description,geo,date_upload,owner_name", page, perPage, lastUploadString, tagsString, additionalArguments]];
	return [[flickrQueryResults objectForKey:@"photos"] objectForKey:@"photo"];
}

+ (NSArray *)photosAtPlace:(NSString *)flickrPlaceId
{
	return [self photosWithTags:nil uploadedSince:nil additionalArguments:[NSString stringWithFormat:@"&place_id=%@", flickrPlaceId]];
}

// Passed flickrInfo dictionary must contain values for all these keys: farm, server, id, secret.

+ (NSString *)urlStringForPhotoWithFlickrInfo:(NSDictionary *)flickrInfo format:(FlickrFetcherPhotoFormat)format;
{
	id farm = [flickrInfo objectForKey:@"farm"];
	id server = [flickrInfo objectForKey:@"server"];
	id photo_id = [flickrInfo objectForKey:@"id"];
	id secret = [flickrInfo objectForKey:@"secret"];
	if (format == FlickrFetcherPhotoFormatOriginal) secret = [flickrInfo objectForKey:@"originalsecret"];
	NSString *fileType = @"jpg";
	if (format == FlickrFetcherPhotoFormatOriginal) fileType = [flickrInfo objectForKey:@"originalformat"];
	
	if (!farm || !server || !photo_id || !secret) return nil;
	
	NSString *formatString = @"s";
	switch (format) {
		case FlickrFetcherPhotoFormatSquare:    formatString = @"s"; break;
		case FlickrFetcherPhotoFormatLarge:     formatString = @"b"; break;
		case FlickrFetcherPhotoFormatThumbnail: formatString = @"t"; break;
		case FlickrFetcherPhotoFormatSmall:     formatString = @"m"; break;
		case FlickrFetcherPhotoFormatMedium:    formatString = @"-"; break;
		case FlickrFetcherPhotoFormatOriginal:  formatString = @"o"; break;
	}

	return [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_%@.%@", farm, server, photo_id, secret, formatString, fileType];
}	

+ (NSData *)imageDataForPhotoWithURLString:(NSString *)urlString
{
	return [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
//    
//    NSError* error = nil;
//    NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString] options:NSDataReadingMapped error:&error];
//    if (error) {
//        NSLog(@"%@", [error localizedDescription]);
//        [error release];
//    } else {
//        NSLog(@"Data has loaded successfully.");
//    }
//    
//    return data;
}

+ (NSData *)imageDataForPhotoWithFlickrInfo:(NSDictionary *)flickrInfo format:(FlickrFetcherPhotoFormat)format;
{
	return [self imageDataForPhotoWithURLString:[self urlStringForPhotoWithFlickrInfo:flickrInfo format:format]];
}

@end
