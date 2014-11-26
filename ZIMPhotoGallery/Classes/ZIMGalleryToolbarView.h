//
//  ZIMGalleryToolbarView.h
//  ZIMPhotoGallery
//
//  Created by kovtash on 26.11.14.
//  Copyright (c) 2014 ZIM. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(uint8_t, ZIMGalleryToolbarViewLayoutStyle) {
    ZIMGalleryToolbarViewLayoutStyleVertical,
    ZIMGalleryToolbarViewLayoutStyleHorizontal,
};

@interface ZIMGalleryToolbarView : UIView
@property (readonly, nonatomic) UIButton *shareButton;
@property (readonly, nonatomic) UIButton *closeButton;
@property (readonly, nonatomic) UILabel *indexLabel;
@property (assign, nonatomic) ZIMGalleryToolbarViewLayoutStyle layoutStyle;
@end
