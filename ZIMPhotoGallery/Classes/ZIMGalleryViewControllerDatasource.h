//
//  ZIMGalleryViewControllerDatasource.h
//  ZIMPhotoGallery
//
//  Created by kovtash on 26.11.14.
//  Copyright (c) 2014 ZIM. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZIMGalleryViewControllerDatasource <NSObject>
- (NSUInteger) numberOFURLs;
- (NSURL *) urlForIndex:(NSUInteger) index;
@end
