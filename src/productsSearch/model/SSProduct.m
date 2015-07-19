//
//  SSProduct.m
//  IOSAssessment
//
//  Created by Mihail Koltsov on 15.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import "SSProduct.h"

@implementation SSProduct

- (NSUInteger)hash {
  return self.sku.hash;
}

- (BOOL)isEqual:(SSProduct*)object {
  if (![object isMemberOfClass:[SSProduct class]]) {
    return NO;
  };

  if ([self.sku isEqualToNumber:object.sku]) {
    return YES;
  }

  return NO;
}

- (NSString*)description {
  return [NSString stringWithFormat:@"%@ sku=%@, name=%@",
          [super description],
          self.sku,
          self.name];
}

@end
