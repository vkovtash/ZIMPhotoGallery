//
//  ZIMRootViewController.m
//  ZIMPhotoGallery
//
//  Created by kovtash on 26.11.14.
//  Copyright (c) 2014 ZIM. All rights reserved.
//

#import "ZIMRootViewController.h"
#import "ZIMGalleryViewController.h"
#import "ZIMTestGalleryDatasource.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ZIMRootViewController ()
@property (strong, nonatomic) ZIMTestGalleryDatasource *datasource;
@end

@implementation ZIMRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.datasource = [ZIMTestGalleryDatasource defaultDatasource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showGallery:(id)sender {
    ZIMGalleryViewController *gc = [ZIMGalleryViewController new];
    gc.datasource = self.datasource;
    
    __weak  ZIMGalleryViewController *weakGallery = gc;
    
    gc.finishedCallback = ^() {
        [weakGallery dismissViewControllerAnimated:YES completion:nil];
    };
    
    [self presentViewController:gc
                       animated:YES
                     completion:nil];
}

@end
