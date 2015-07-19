//
//  SSProductDetailsSearchDataSource.m
//  IOSAssessment
//
//  Created by user on 19.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import "SSProductDetailsSearchDataSource.h"

@implementation SSProductDetailsSearchDataSource

- (instancetype)init {
  return [self initWithSKU:nil];
}

- (instancetype)initWithSKU:(NSString*)sku {
  NSParameterAssert(sku);
  if (!sku) {
    return nil;
  }

  self = [super init];
  if (self) {
    _sku = sku;
  }
  return self;
}

@end
