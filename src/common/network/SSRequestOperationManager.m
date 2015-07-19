//
//  SSHTTPRequestOperationManager.m
//  IOSAssessment
//
//  Created by user on 12.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import "SSRequestOperationManager.h"

#import <AFNetworking/AFHTTPRequestOperationManager.h>

#import "SSRequestOperationManagerConfiguration.h"
#import "SSURLRequestFactory.h"

@interface SSRequestOperationManager ()

@property(nonatomic, strong, readwrite)
    AFHTTPRequestOperationManager* requestOperationManager;
@property(nonatomic, strong, readwrite) SSURLRequestFactory* URLRequestFactory;

@end

@implementation SSRequestOperationManager

+ (instancetype)sharedManager {
  static SSRequestOperationManager* sharedManager;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedManager = [[SSRequestOperationManager alloc] init];
  });
  return sharedManager;
}

- (void)setupWithConfiguration:
    (SSRequestOperationManagerConfiguration*)configuration {
  self.requestOperationManager =
      [self createRequestOperationManagerWithConfiguration:configuration];
  self.URLRequestFactory =
      [self createURLRequestFactoryWithConfiguration:configuration];
}

- (AFHTTPRequestOperationManager*)
    createRequestOperationManagerWithConfiguration:
        (SSRequestOperationManagerConfiguration*)configuration {
  NSURL* baseURL = configuration.baseURL;
  NSParameterAssert(baseURL);
  if (!baseURL) {
    return nil;
  }

  AFHTTPRequestOperationManager* requestOperationManager =
      [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
  requestOperationManager.requestSerializer =
      [[AFJSONRequestSerializer alloc] init];
  return requestOperationManager;
}

- (SSURLRequestFactory*)createURLRequestFactoryWithConfiguration:
    (SSRequestOperationManagerConfiguration*)configuration {
  return [[SSURLRequestFactory alloc] initWithConfiguration:configuration];
}

- (void)perfromHTTPRequestOperationWithRequest:(NSURLRequest*)request
    success:(void(^)(id responseObject))successBlock
      error:(void(^)(NSError* error))errorBlock {
  NSParameterAssert(self.requestOperationManager);
  AFHTTPRequestOperation* operation =
      [self.requestOperationManager HTTPRequestOperationWithRequest:request
                                                            success:
          ^(AFHTTPRequestOperation* operation, id responseObject) {
            if (successBlock) {
              successBlock(responseObject);
            }
          } failure:^(AFHTTPRequestOperation* operation, NSError* error) {
            if (errorBlock) {
              errorBlock(error);
            }
          }];
  
  [self.requestOperationManager.operationQueue addOperation:operation];
}

@end
