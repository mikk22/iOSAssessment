//
//  SSProductImageCell.m
//  IOSAssessment
//
//  Created by user on 19.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import "SSProductImageCell.h"

#import <PureLayout/PureLayout.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface SSProductImageCell ()

@property(nonatomic, assign) BOOL didSetupConstraints;
@property(nonatomic, strong) UIImageView* productImageView;

@end

static CGFloat const kSSProductCellInset = 10.f;

@implementation SSProductImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString*)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    _productImageView = [[UIImageView alloc] init];
    _productImageView.contentMode = UIViewContentModeScaleAspectFit;
    _productImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_productImageView];
  }
  return self;
}

- (void)updateConstraints {
  if (!self.didSetupConstraints) {
    [self.productImageView autoPinEdgeToSuperviewEdge:ALEdgeLeading
                                                   withInset:kSSProductCellInset];
    [self.productImageView autoPinEdgeToSuperviewEdge:ALEdgeTrailing
                                                   withInset:kSSProductCellInset];
    [self.productImageView autoPinEdgeToSuperviewEdge:ALEdgeTop
                                                   withInset:kSSProductCellInset];
    [self.productImageView autoPinEdgeToSuperviewEdge:ALEdgeBottom
                                                   withInset:kSSProductCellInset];
    self.didSetupConstraints = YES;
  }
  [super updateConstraints];
}

- (void)setImageURL:(NSURL*)URL {
  [self.productImageView sd_setImageWithURL:URL];
}

@end
