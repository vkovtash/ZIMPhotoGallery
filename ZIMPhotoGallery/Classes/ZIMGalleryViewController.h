//
//  ZIMGalleryViewController.h
//  ZIMPhotoGallery
//
//  Created by kovtash on 25.11.14.
//  Copyright (c) 2014 ZIM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZIMGalleryViewControllerDatasource.h"

@interface ZIMGalleryViewController : UIViewController <UIPageViewControllerDelegate,
                                                        UIPageViewControllerDataSource,
                                                        UIScrollViewDelegate,
                                                        UIGestureRecognizerDelegate>

@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, weak) id <ZIMGalleryViewControllerDatasource> datasource;

@property (nonatomic, copy) void (^finishedCallback)();
@end
