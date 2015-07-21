//
//  SSProductDescriptionCell.m
//  IOSAssessment
//
//  Created by user on 19.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import "SSProductDescriptionCell.h"

#import <PureLayout/PureLayout.h>

@interface SSProductDescriptionCell ()

@property(nonatomic, assign) BOOL didSetupConstraints;
@property(nonatomic, strong) UILabel* productDescriptionLabel;
@property(nonatomic, strong) UILabel* productNameLabel;

@end

static CGFloat const kSSProductCellInset = 10.f;

@implementation SSProductDescriptionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString*)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    _productNameLabel = [[UILabel alloc] init];
    _productNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _productNameLabel.numberOfLines = 0;
    _productNameLabel.font = [UIFont boldSystemFontOfSize:17.f];
    _productNameLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_productNameLabel];
    
    _productDescriptionLabel = [[UILabel alloc] init];
    _productDescriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _productDescriptionLabel.numberOfLines = 0;
    _productDescriptionLabel.font = [UIFont systemFontOfSize:17.f];
    [self.contentView addSubview:_productDescriptionLabel];
  }
  return self;
}

- (void)updateConstraints {
  if (!self.didSetupConstraints) {
    [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
      [self.productNameLabel autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
      [self.productDescriptionLabel autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
    }];

    [self.productNameLabel autoPinEdgeToSuperviewEdge:ALEdgeLeading
                                            withInset:kSSProductCellInset];
    [self.productNameLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing
                                            withInset:kSSProductCellInset];
    [self.productNameLabel autoPinEdgeToSuperviewEdge:ALEdgeTop
                                            withInset:kSSProductCellInset];
    [self.productNameLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom
                                            withInset:kSSProductCellInset
                                             relation:NSLayoutRelationGreaterThanOrEqual];

    [self.productDescriptionLabel autoPinEdgeToSuperviewEdge:ALEdgeLeading
                                            withInset:kSSProductCellInset];
    [self.productDescriptionLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing
                                                   withInset:kSSProductCellInset];
    [self.productDescriptionLabel autoPinEdge:ALEdgeTop
                                       toEdge:ALEdgeBottom
                                       ofView:self.productNameLabel
                                   withOffset:kSSProductCellInset];

    [self.productDescriptionLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom
                                                   withInset:kSSProductCellInset];
    self.didSetupConstraints = YES;
  }
  [super updateConstraints];
}

- (void)setProductName:(NSString*)name description:(NSString*)description {
  if ([self.productNameLabel.text isEqualToString:name]  &&
      [self.productDescriptionLabel.text isEqualToString:description]) {
    return;
  }

  self.productNameLabel.text = name;
  self.productDescriptionLabel.text = description;
}

@end
