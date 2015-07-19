//
//  SSURLRequestFactory.m
//  IOSAssessment
//
//  Created by user on 19.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import "SSURLRequestFactory.h"

#import <AFNetworking/AFURLRequestSerialization.h>

#import "SSRequestOperationManagerConfiguration.h"

@interface SSURLRequestFactory ()

@property(nonatomic, strong, readonly)
    SSRequestOperationManagerConfiguration* configuration;

@end

@implementation SSURLRequestFactory

- (instancetype)init {
  return [self initWithConfiguration:nil];
}

- (instancetype)initWithConfiguration:
    (SSRequestOperationManagerConfiguration*)configuration {
  NSParameterAssert(configuration);
  if (!configuration) {
    return nil;
  }

  self = [super init];
  if (self) {
    _configuration = configuration;
  }
  return self;
}

- (NSURLRequest*)GETRequestWithKeyPath:(NSString*)keyPath
                            parameters:(NSDictionary*)parameters {
  static NSString* const kSSRequestGETMethod = @"GET";
  return [self requestWithMethod:kSSRequestGETMethod
                         keyPath:keyPath
                      parameters:parameters];
}

- (NSURLRequest*)requestWithMethod:(NSString*)method
                           keyPath:(NSString*)keyPath
                        parameters:(NSDictionary*)parameters {
  NSParameterAssert(method);
  NSString* baseURLString = [self.configuration.baseURL absoluteString];
  NSString* URLString = [baseURLString stringByAppendingString:keyPath];

  NSMutableDictionary* mutableParameters =
      [[NSMutableDictionary alloc] initWithDictionary:parameters];
  [mutableParameters
      addEntriesFromDictionary:self.configuration.baseURLParameters];
  NSDictionary* requestParameters = [mutableParameters copy];

  AFHTTPRequestSerializer* serializer = [AFHTTPRequestSerializer serializer];
  NSMutableURLRequest* request =
      [serializer requestWithMethod:method
                          URLString:URLString
                         parameters:requestParameters
                              error:NULL];
  return [request copy];
}

@end
