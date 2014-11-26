//
//  ZIMTestGalleryDatasource.h
//  ZIMPhotoGallery
//
//  Created by kovtash on 26.11.14.
//  Copyright (c) 2014 ZIM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZIMGalleryViewControllerDatasource.h"

@interface ZIMTestGalleryDatasource : NSObject <ZIMGalleryViewControllerDatasource>
@property (strong, nonatomic) NSArray *urls;

+ (instancetype) defaultDatasource;
@end
