//
//  SSHTTPRequestOperationManagerConfiguration.h
//  IOSAssessment
//
//  Created by user on 12.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSRequestOperationManagerConfiguration : NSObject

@property(nonatomic, strong, readonly) NSURL* baseURL;
@property(nonatomic, copy, readonly) NSDictionary* baseURLParameters;

+ (instancetype)configuration;

@end
