//
//  SSHTTPRequestOperationManagerConfiguration.m
//  IOSAssessment
//
//  Created by user on 12.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import "SSRequestOperationManagerConfiguration.h"

@interface SSRequestOperationManagerConfiguration ()

@property(nonatomic, strong, readwrite) NSURL* baseURL;
@property(nonatomic, copy, readwrite) NSDictionary* baseURLParameters;

@end

@implementation SSRequestOperationManagerConfiguration

+ (instancetype)configuration {
  SSRequestOperationManagerConfiguration* configuration =
      [[SSRequestOperationManagerConfiguration alloc] init];

  static NSString* const kServiceURLString =
      @"http://api.remix.bestbuy.com/";
  static NSString* const kServiceApiVersionString = @"v1";
  NSString *baseURLString =
      [NSString stringWithFormat:@"%@%@/",
                                 kServiceURLString,
                                 kServiceApiVersionString];
  configuration.baseURL = [NSURL URLWithString:baseURLString];
  
  NSDictionary* baseURLParameters = @{
    @"apiKey" : @"f2dscedm6bbkdc24dhdd7xfu",
    @"format" : @"json",
  };

  configuration.baseURLParameters = baseURLParameters;
  return configuration;
}

@end
