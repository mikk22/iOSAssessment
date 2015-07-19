//
//  SSProductCell.m
//  IOSAssessment
//
//  Created by Mihail Koltsov on 15.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import "SSProductCell.h"

#import <PureLayout/PureLayout.h>
#import <SDWebImage/UIImageView+WebCache.h>

#import "SSProduct.h"

@interface SSProductCell ()

@property(nonatomic, assign) BOOL didSetupConstraints;
@property(nonatomic, strong) UIImageView* productImageView;
@property(nonatomic, strong) UILabel* productNameLabel;
@property(nonatomic, strong) UILabel* productPriceLabel;

@end

static CGFloat const kSSProductCellInset = 10.f;

@implementation SSProductCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString*)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    _productImageView = [[UIImageView alloc] init];
    _productImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_productImageView];
    
    _productNameLabel = [[UILabel alloc] init];
    _productNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _productNameLabel.numberOfLines = 2;
    _productNameLabel.font = [UIFont systemFontOfSize:17.f];

    [self.contentView addSubview:_productNameLabel];

    _productPriceLabel = [[UILabel alloc] init];
    _productPriceLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _productPriceLabel.numberOfLines = 0;
    _productPriceLabel.font = [UIFont systemFontOfSize:17.f];
    [self.contentView addSubview:_productPriceLabel];
    
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  // for multiline UILabel's you need set the preferredMaxLayoutWidth
  // you need to do this after [super layoutSubviews] as the frames will have a value from Auto Layout at this point
  CGFloat maxX = CGRectGetMaxX(self.productImageView.frame);
  self.productNameLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.contentView.bounds) - maxX - 2* kSSProductCellInset;
}

- (void)updateConstraints {
  if (!self.didSetupConstraints) {
    [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
      [self.productImageView autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
    }];
    [self.productImageView autoSetDimensionsToSize:CGSizeMake(90, 90)];
    [self.productImageView autoPinEdgeToSuperviewEdge:ALEdgeLeading
                                            withInset:kSSProductCellInset];
    [self.productImageView autoPinEdgeToSuperviewEdge:ALEdgeTop
                                            withInset:kSSProductCellInset];
    [self.productImageView autoPinEdgeToSuperviewEdge:ALEdgeBottom
                                            withInset:kSSProductCellInset
                                             relation:NSLayoutRelationGreaterThanOrEqual];
    
    [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
      [self.productNameLabel autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
    }];
    
    [self.productNameLabel autoPinEdgeToSuperviewEdge:ALEdgeTop
                                            withInset:kSSProductCellInset];
    [self.productNameLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom
                                            withInset:kSSProductCellInset
                                             relation:NSLayoutRelationGreaterThanOrEqual];
    [self.productNameLabel autoPinEdge:ALEdgeLeading
                                toEdge:ALEdgeTrailing
                                ofView:self.productImageView
                            withOffset:kSSProductCellInset];
    [self.productNameLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing
                                            withInset:kSSProductCellInset];

    [self.productPriceLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom
                                            withInset:kSSProductCellInset];
    [self.productPriceLabel autoPinEdge:ALEdgeLeading
                                 toEdge:ALEdgeTrailing
                                 ofView:self.productImageView
                             withOffset:kSSProductCellInset];
    [self.productPriceLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing
                                             withInset:kSSProductCellInset];

    self.didSetupConstraints = YES;
  }

  [super updateConstraints];
}

- (void)setProduct:(SSProduct*)product {
  self.productNameLabel.text = product.name;
  self.productPriceLabel.text =
      [NSString stringWithFormat:@"%.2f", product.regularPrice.floatValue];

  NSURL* URL = [NSURL URLWithString:product.thumbnailImage];
  [self.productImageView sd_setImageWithURL:URL];
}

@end
