//
//  ZIMTestGalleryDatasource.m
//  ZIMPhotoGallery
//
//  Created by kovtash on 26.11.14.
//  Copyright (c) 2014 ZIM. All rights reserved.
//

#import "ZIMTestGalleryDatasource.h"

@implementation ZIMTestGalleryDatasource

- (NSUInteger) numberOFURLs {
    return self.urls.count;
}

- (NSURL *) urlForIndex:(NSUInteger)index {
    if (index < self.urls.count) {
        return self.urls[index];
    }
    
    return nil;
}

+ (instancetype) defaultDatasource {
    ZIMTestGalleryDatasource *datasource = [[self class] new];
    datasource.urls = @[
                        [NSURL URLWithString:@"https://c1.staticflickr.com/9/8607/15871457445_0350a624b9_h.jpg"],
                        [NSURL URLWithString:@"https://c1.staticflickr.com/9/8651/15265549633_0d3b991c17_b.jpg"],
                        [NSURL URLWithString:@"https://c2.staticflickr.com/8/7492/15855144265_3d305baa17_h.jpg"],
                        [NSURL URLWithString:@"https://c2.staticflickr.com/8/7543/15629606239_44fa928d27_h.jpg"],
                        [NSURL URLWithString:@"https://c2.staticflickr.com/6/5603/15186847493_1d8f82baf1_h.jpg"],
                        ];
    return datasource;
}
@end
