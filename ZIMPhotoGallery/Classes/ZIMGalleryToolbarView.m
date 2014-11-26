//
//  ZIMGalleryToolbarView.m
//  ZIMPhotoGallery
//
//  Created by kovtash on 26.11.14.
//  Copyright (c) 2014 ZIM. All rights reserved.
//

#import "ZIMGalleryToolbarView.h"


static const CGFloat kButtonsInset = 30;


@interface ZIMGalleryToolbarView()
@property (strong, nonatomic) NSArray *horizontalLayoutConstraints;
@property (strong, nonatomic) NSArray *verticalLayoutConstraints;
@end

@implementation ZIMGalleryToolbarView

- (instancetype) init {
    self = [super initWithFrame:CGRectMake(0, 0, 80, 40)];
    if (self) {
        [self zim_galleryToolbarViewPostInit];
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self zim_galleryToolbarViewPostInit];
    }
    return self;
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self zim_galleryToolbarViewPostInit];
    }
    return self;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    return CGRectContainsPoint(self.shareButton.frame, point) || CGRectContainsPoint(self.closeButton.frame, point);
}

- (void) zim_galleryToolbarViewPostInit {
    _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _indexLabel = [UILabel new];
    
    _shareButton.translatesAutoresizingMaskIntoConstraints = NO;
    _closeButton.translatesAutoresizingMaskIntoConstraints = NO;
    _indexLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:_shareButton];
    [self addSubview:_closeButton];
    [self addSubview:_indexLabel];
    
    [_shareButton addConstraint:[NSLayoutConstraint constraintWithItem:_shareButton
                                                     attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:nil
                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                            multiplier:1
                                                              constant:40]];
    [_shareButton addConstraint:[NSLayoutConstraint constraintWithItem:_shareButton
                                                             attribute:NSLayoutAttributeHeight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:nil
                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                            multiplier:1
                                                              constant:40]];
    
    [_closeButton addConstraint:[NSLayoutConstraint constraintWithItem:_closeButton
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:nil
                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                            multiplier:1
                                                              constant:40]];
    [_closeButton addConstraint:[NSLayoutConstraint constraintWithItem:_closeButton
                                                             attribute:NSLayoutAttributeHeight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:nil
                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                            multiplier:1
                                                              constant:40]];
    
    [_indexLabel addConstraint:[NSLayoutConstraint constraintWithItem:_indexLabel
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:nil
                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                            multiplier:1
                                                              constant:100]];
    [_indexLabel addConstraint:[NSLayoutConstraint constraintWithItem:_indexLabel
                                                             attribute:NSLayoutAttributeHeight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:nil
                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                            multiplier:1
                                                              constant:40]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_indexLabel
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1
                                                      constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_indexLabel
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1
                                                      constant:0]];
    
    NSMutableArray *horizontalLayouts = [NSMutableArray new];
    
    [horizontalLayouts addObject:[NSLayoutConstraint constraintWithItem:_shareButton
                                                              attribute:NSLayoutAttributeCenterY
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self
                                                              attribute:NSLayoutAttributeCenterY
                                                             multiplier:1
                                                               constant:0]];
    
    [horizontalLayouts addObject:[NSLayoutConstraint constraintWithItem:_closeButton
                                                              attribute:NSLayoutAttributeCenterY
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self
                                                              attribute:NSLayoutAttributeCenterY
                                                             multiplier:1
                                                               constant:0]];
    
    [horizontalLayouts addObject:[NSLayoutConstraint constraintWithItem:_shareButton
                                                              attribute:NSLayoutAttributeCenterX
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self
                                                              attribute:NSLayoutAttributeLeft
                                                             multiplier:1
                                                               constant:kButtonsInset]];
    
    [horizontalLayouts addObject:[NSLayoutConstraint constraintWithItem:_closeButton
                                                              attribute:NSLayoutAttributeCenterX
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self
                                                              attribute:NSLayoutAttributeRight
                                                             multiplier:1
                                                               constant:-kButtonsInset]];
    _horizontalLayoutConstraints = [horizontalLayouts copy];
    
    NSMutableArray *verticalLayouts = [NSMutableArray new];
    
    [verticalLayouts addObject:[NSLayoutConstraint constraintWithItem:_shareButton
                                                            attribute:NSLayoutAttributeCenterX
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self
                                                            attribute:NSLayoutAttributeCenterX
                                                           multiplier:1
                                                             constant:0]];
    
    [verticalLayouts addObject:[NSLayoutConstraint constraintWithItem:_closeButton
                                                            attribute:NSLayoutAttributeCenterX
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self
                                                            attribute:NSLayoutAttributeCenterX
                                                           multiplier:1
                                                             constant:0]];
    
    [verticalLayouts addObject:[NSLayoutConstraint constraintWithItem:_shareButton
                                                            attribute:NSLayoutAttributeCenterY
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self
                                                            attribute:NSLayoutAttributeBottom
                                                           multiplier:1
                                                             constant:-kButtonsInset]];
    
    [verticalLayouts addObject:[NSLayoutConstraint constraintWithItem:_closeButton
                                                            attribute:NSLayoutAttributeCenterY
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self
                                                            attribute:NSLayoutAttributeTop
                                                           multiplier:1
                                                             constant:kButtonsInset]];
    _verticalLayoutConstraints = [verticalLayouts copy];
    
    [self setLayoutStyle:ZIMGalleryToolbarViewLayoutStyleHorizontal];
}

- (void) setLayoutStyle:(ZIMGalleryToolbarViewLayoutStyle)layoutStyle {
    switch (layoutStyle) {
        case ZIMGalleryToolbarViewLayoutStyleHorizontal:
            [self layoutHorizontal];
            break;
            
        case ZIMGalleryToolbarViewLayoutStyleVertical:
            [self layoutVertical];
            break;
    }
}

- (void) layoutHorizontal {
    [self removeConstraints:self.verticalLayoutConstraints];
    [self addConstraints:self.horizontalLayoutConstraints];
    [self layoutIfNeeded];
}

- (void) layoutVertical {
    [self removeConstraints:self.horizontalLayoutConstraints];
    [self addConstraints:self.verticalLayoutConstraints];
    [self layoutIfNeeded];
}

@end
