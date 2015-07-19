//
//  SSCategory.m
//  IOSAssessment
//
//  Created by user on 12.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import "SSCategory.h"

@implementation SSCategory

- (NSUInteger)hash {
  return self.identifier.hash;
}

- (BOOL)isEqual:(SSCategory*)object {
  if (![object isMemberOfClass:[SSCategory class]]) {
    return NO;
  };

  if ([self.identifier isEqualToString:object.identifier]) {
    return YES;
  }

  return NO;
}

- (NSString*)description {
  return [NSString stringWithFormat:@"%@ identifier=%@, name=%@",
                                    [super description],
                                    self.identifier,
                                    self.name];
}

@end
