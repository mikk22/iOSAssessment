//
//  SSObjectsListLoadingConfiguration.m
//  IOSAssessment
//
//  Created by user on 15.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import "SSObjectsListLoadingConfiguration.h"

@interface SSObjectsListLoadingConfiguration()

@property(nonatomic, assign, readwrite) NSUInteger pageSize;

@end

@implementation SSObjectsListLoadingConfiguration

+ (instancetype)defaultConfiguration {
  SSObjectsListLoadingConfiguration* configuration =
      [[SSObjectsListLoadingConfiguration alloc] init];
  static NSUInteger const kSSObjectsListLoadingConfigurationPageSize = 20;
  configuration.pageSize = kSSObjectsListLoadingConfigurationPageSize;
  return configuration;
}

@end
