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

@implementation SSProductImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString*)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    _productImageView = [[UIImageView alloc] init];
    _productImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_productImageView];
  }
  return self;
}

- (void)setImageURL:(NSURL*)URL {
  [self.productImageView sd_setImageWithURL:URL];
}

@end
