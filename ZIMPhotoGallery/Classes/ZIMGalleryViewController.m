//
//  ZIMGalleryViewController.m
//  ZIMPhotoGallery
//
//  Created by kovtash on 25.11.14.
//  Copyright (c) 2014 ZIM. All rights reserved.
//

#import "ZIMGalleryViewController.h"
#import "ZIMGalleryToolbarView.h"
#import "MHGalleryImageViewerViewController.h"

static CGFloat kToolbarSize = 60;
static CGFloat kToolbarButtonsBottonInset = 5;
static CGFloat kToolbarAnimationDuration = 0.7;

@class ZIMGalleryViewController;

@interface MHImageViewController(ZIMCreation)
+ (MHImageViewController *) zim_imageViewControllerForMHMediaItem:(MHGalleryItem *)item
                                                   viewController:(ZIMGalleryViewController *)viewController;
@end

@implementation MHImageViewController(ZIMCreation)
+ (MHImageViewController *) zim_imageViewControllerForMHMediaItem:(MHGalleryItem *)item
                                                   viewController:(ZIMGalleryViewController *)viewController {
    MHImageViewController *controller = [MHImageViewController imageViewControllerForMHMediaItem:item
                                                                                  viewController:(MHGalleryImageViewerViewController *)viewController];
    
    for (id recognizer in controller.view.gestureRecognizers) {
        if ([recognizer isKindOfClass:[UITapGestureRecognizer class]]) {
            [controller.view removeGestureRecognizer:recognizer];
        }
    }
    
    return controller;
}
@end


@interface ZIMGalleryToolbarView(ZIMCreation)
+ (ZIMGalleryToolbarView *) zim_defaultToolbar;
@end

@implementation ZIMGalleryToolbarView(ZIMCreation)
+ (ZIMGalleryToolbarView *) zim_defaultToolbar {
    ZIMGalleryToolbarView *toolbar = [ZIMGalleryToolbarView new];
    [toolbar.closeButton setImage:[UIImage imageNamed:@"close_button"] forState:UIControlStateNormal];
    [toolbar.shareButton setImage:[UIImage imageNamed:@"share_button"] forState:UIControlStateNormal];
    toolbar.closeButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, kToolbarButtonsBottonInset, 0);
    toolbar.shareButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, kToolbarButtonsBottonInset, 0);
    toolbar.indexLabel.textColor = [UIColor whiteColor];
    toolbar.indexLabel.textAlignment = NSTextAlignmentCenter;
    return toolbar;
}
@end


@interface ZIMGalleryViewController ()
@property (strong, nonatomic) ZIMGalleryToolbarView *toolbarView;
@property (nonatomic, strong) MHTransitionPresentMHGallery *interactivePresentationTranstion;
@property (nonatomic, strong) MHTransitionCustomization *transitionCustomization;
@property (nonatomic, strong) MHUICustomization *UICustomization;
@property (nonatomic, getter = isUserScrolling) BOOL userScrolls;
@property (nonatomic, getter = isHiddingToolBarAndNavigationBar) BOOL hiddingToolBarAndNavigationBar;
@end

@implementation ZIMGalleryViewController

-(void) viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.14 green:0.14 blue:0.14 alpha:1];
    
    self.UICustomization = [MHUICustomization new];
    [self.UICustomization setMHGalleryBackgroundColor:self.view.backgroundColor
                                          forViewMode:MHGalleryViewModeImageViewerNavigationBarHidden];
    
    [self.UICustomization setMHGalleryBackgroundColor:self.view.backgroundColor
                                          forViewMode:MHGalleryViewModeImageViewerNavigationBarShown];
    
    [self.UICustomization setMHGalleryBackgroundColor:self.view.backgroundColor
                                          forViewMode:MHGalleryViewModeOverView];
    
    self.pageViewController = [UIPageViewController.alloc initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                            navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                          options:@{ UIPageViewControllerOptionInterPageSpacingKey : @30.f }];
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    self.pageViewController.automaticallyAdjustsScrollViewInsets = NO;
    
    MHImageViewController *imageViewController = [self imageViewControllerForPageIndex:self.pageIndex];

    [self.pageViewController setViewControllers:@[imageViewController]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:nil];
    
    
    [self addChildViewController:self.pageViewController];
    [self.pageViewController didMoveToParentViewController:self];
    [self.view addSubview:self.pageViewController.view];
    
    [(UIScrollView*)self.pageViewController.view.subviews[0] setDelegate:self];
    [(UIGestureRecognizer*)[[self.pageViewController.view.subviews[0] gestureRecognizers] firstObject] setDelegate:self];
    
    [self updateTitleForIndex:self.pageIndex];
    
    self.toolbarView = [ZIMGalleryToolbarView zim_defaultToolbar];
    [self.view addSubview:self.toolbarView];
    
    [self.toolbarView.shareButton addTarget:self action:@selector(sharePressed) forControlEvents:UIControlEventTouchUpInside];
    [self.toolbarView.closeButton addTarget:self action:@selector(closePressed) forControlEvents:UIControlEventTouchUpInside];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    self.pageViewController.view.frame = self.view.bounds;
    [self.pageViewController.view.subviews.firstObject setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    [self updateToolbarLayoutForOrientation:[self currentOrientation]];
    if (animated) {
        self.toolbarView.alpha = 0;
        [UIView animateWithDuration:kToolbarAnimationDuration animations:^{
            self.toolbarView.alpha = 1;
        }];
    }
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (BOOL) prefersStatusBarHidden {
    return YES;
}

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:UIButton.class]) {
        if (touch.view.tag != 508) {
            return YES;
        }
    }
    return ([touch.view isKindOfClass:UIControl.class] == NO);
}

-(void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    self.pageViewController.view.frame = self.view.bounds;
    [self.pageViewController.view.subviews.firstObject setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    [UIView animateWithDuration:duration animations:^{
        [self updateToolbarLayoutForOrientation:toInterfaceOrientation];
    }];
}

#pragma mark - Layout and interface updates

- (void) updateToolbarLayoutForOrientation:(UIInterfaceOrientation) orientation {
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        self.toolbarView.frame = CGRectMake(self.view.bounds.size.width - kToolbarSize, 0, kToolbarSize, self.view.bounds.size.height);
        self.toolbarView.layoutStyle = ZIMGalleryToolbarViewLayoutStyleVertical;
        self.toolbarView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleHeight;
    }
    else {
        self.toolbarView.frame = CGRectMake(0, 0, self.view.bounds.size.width, kToolbarSize);
        self.toolbarView.layoutStyle = ZIMGalleryToolbarViewLayoutStyleHorizontal;
        self.toolbarView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleWidth;
    }
}

-(void) updateTitleAndDescriptionForScrollView:(UIScrollView*)scrollView {
    NSInteger pageIndex = self.pageIndex;
    if (scrollView.contentOffset.x > (self.view.frame.size.width + self.view.frame.size.width/2)) {
        pageIndex++;
    }
    if (scrollView.contentOffset.x < self.view.frame.size.width/2) {
        pageIndex--;
    }
    [self updateTitleForIndex:pageIndex];
}

-(void) updateTitleForIndex:(NSInteger)pageIndex {
    if (self.numberOfGalleryItems > 0) {
        self.toolbarView.indexLabel.text = [NSString stringWithFormat:@"%ld/%ld",(long)pageIndex + 1, (long)self.numberOfGalleryItems];
    }
    else {
        self.toolbarView.indexLabel.text = nil;
    }
}

#pragma mark - Private API

-(UIInterfaceOrientation) currentOrientation {
    return UIApplication.sharedApplication.statusBarOrientation;
}

-(void) sharePressed {
    UIImage *image = [(MHImageViewController*)self.pageViewController.viewControllers.firstObject imageView].image;
    
    if (!image) {
        return;
    }
    
    UIActivityViewController *act = [UIActivityViewController.alloc initWithActivityItems:@[image]
                                                                    applicationActivities:nil];
    [self presentViewController:act animated:YES completion:nil];
}

- (void) closePressed {
    self.finishedCallback ? self.finishedCallback() : nil;
}

#pragma mark - Datasource API

-(NSInteger) numberOfGalleryItems {
    return [self.datasource numberOFURLs];
}

- (MHGalleryItem *) itemForIndex:(NSInteger)index {
    NSURL *url = [self.datasource urlForIndex:index];
    
    if (!url) {
        return nil;
    }
    
    return [MHGalleryItem itemWithURL:[url absoluteString] galleryType:MHGalleryTypeImage];
}

#pragma mark - UIScrollViewDelegate

-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.userScrolls = NO;
    [self updateTitleAndDescriptionForScrollView:scrollView];
}

-(void) scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.userScrolls = YES;
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView {
    [self updateTitleAndDescriptionForScrollView:scrollView];
}

#pragma mark - UIPageViewControllerDelegate, UIPageViewControllerDataSource

-(void) pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray *)previousViewControllers
       transitionCompleted:(BOOL)completed {
    
    self.pageIndex = [pageViewController.viewControllers.firstObject pageIndex];
}

- (UIViewController *) pageViewController:(UIPageViewController *)pvc viewControllerBeforeViewController:(MHImageViewController *)vc {
    return [self imageViewControllerForPageIndex:vc.pageIndex - 1];
}

- (UIViewController *) pageViewController:(UIPageViewController *)pvc viewControllerAfterViewController:(MHImageViewController *)vc {
    return [self imageViewControllerForPageIndex:vc.pageIndex + 1];
}

- (MHImageViewController*) imageViewControllerForPageIndex:(NSInteger)pageIndex {
    MHGalleryItem *item = nil;
    if (pageIndex >= 0 && pageIndex < self.numberOfGalleryItems) {
        item = [self itemForIndex:pageIndex];
    }
    
    MHImageViewController *imageViewController =[MHImageViewController zim_imageViewControllerForMHMediaItem:item
                                                                                              viewController:self];
    if (item) {
        imageViewController.pageIndex  = pageIndex;
    }
    
    if (pageIndex >= self.numberOfGalleryItems) {
        imageViewController.pageIndex  = self.numberOfGalleryItems - 1;
    }
    
    if (pageIndex < 0) {
        imageViewController.pageIndex  = 0;
    }

    return imageViewController;
}

@end
