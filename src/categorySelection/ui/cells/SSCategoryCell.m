//
//  SSCategoryCell.m
//  IOSAssessment
//
//  Created by user on 12.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import "SSCategoryCell.h"

#import "SSCategory.h"

@implementation SSCategoryCell

- (void)setCategory:(SSCategory*)category {
  if ([category.name isEqualToString:self.textLabel.text]) {
    return;
  }

  self.textLabel.text = category.name;
}

@end
