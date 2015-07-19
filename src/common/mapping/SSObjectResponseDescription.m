//
//  SSObjectResponseDescription.m
//  IOSAssessment
//
//  Created by Mihail Koltsov on 14.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import "SSObjectResponseDescription.h"

@implementation SSObjectResponseDescription

- (instancetype)init {
  return [self initWithObjectMapping:nil keyPath:nil];
}

- (instancetype)initWithObjectMapping:(id<SSObjectMapping>)mapping
                              keyPath:(NSString*)keyPath {
  NSParameterAssert(mapping);
  if (!mapping) {
    return nil;
  }

  self = [super init];
  if (self) {
    _mapping = mapping;
    _keyPath = [keyPath copy];
  }
  return self;
}

@end
