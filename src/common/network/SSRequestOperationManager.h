//
//  SSHTTPRequestOperationManager.h
//  IOSAssessment
//
//  Created by user on 12.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SSRequestOperationManagerConfiguration;
@class SSURLRequestFactory;

@interface SSRequestOperationManager : NSObject

@property(nonatomic, strong, readonly) SSURLRequestFactory* URLRequestFactory;

+ (instancetype)sharedManager;

- (void)setupWithConfiguration:
    (SSRequestOperationManagerConfiguration*)configuration;

- (void)perfromHTTPRequestOperationWithRequest:(NSURLRequest*)request
    success:(void(^)(id responseObject))successBlock
      error:(void(^)(NSError* error))errorBlock;

@end
