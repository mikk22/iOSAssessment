//
//  SSCategoriesLoadingActions.m
//  IOSAssessment
//
//  Created by Mihail Koltsov on 13.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import "SSCategoriesLoadingActions.h"

#import "SSCategoryMapping.h"
#import "SSObjectResponseDescription.h"
#import "SSObjectResponseMapper.h"
#import "SSRequestOperationManager.h"
#import "SSURLRequestFactory.h"

@implementation SSCategoriesLoadingActions

- (SSRequestOperationManager*)requestOperationManager {
  return [SSRequestOperationManager sharedManager];
}

- (SSURLRequestFactory*)URLRequestFactory {
  return [self requestOperationManager].URLRequestFactory;
}

- (NSURLRequest*)URLRequestWithKeyPath:(NSString*)keyPath
                             pageIndex:(NSUInteger)pageIndex
                              pageSize:(NSUInteger)pageSize {
  NSParameterAssert(pageSize);
  NSMutableDictionary* URLParameters = [@{
                                          @"show":@"id,name",
                                          @"pageSize":@(pageSize),
                                          } mutableCopy];
  if (pageIndex) {
    [URLParameters setObject:@(pageIndex) forKey:@"page"];
  }

  NSDictionary* requestParameters = [URLParameters copy];
  NSURLRequest* request =
      [[self URLRequestFactory] GETRequestWithKeyPath:keyPath
                                           parameters:requestParameters];
  return request;
}

- (void)requestObjectsWithPageIndex:(NSUInteger)pageIndex
                           pageSize:(NSUInteger)pageSize
                        finishBlock:(void(^)(NSArray* objects))finishBlock
                         errorBlock:(void(^)(NSError* error))errorBlock {
  NSString* keyPath = @"categories";
  NSURLRequest* request = [self URLRequestWithKeyPath:keyPath
                                            pageIndex:pageIndex
                                             pageSize:pageSize];

  void(^successBlock)(id responseObject) = ^(id responseObject) {
    SSCategoryMapping* categoryMapping = [[SSCategoryMapping alloc] init];
    SSObjectResponseDescription* responseDescription =
        [[SSObjectResponseDescription alloc]
            initWithObjectMapping:categoryMapping
                          keyPath:keyPath];

    NSArray* objects =
        [SSObjectResponseMapper mapObjectsFromDictionary:responseObject
                                 withResponseDescription:responseDescription];
    if (finishBlock) {
      finishBlock(objects);
    }
  };
  
  [[self requestOperationManager]
      perfromHTTPRequestOperationWithRequest:request
                                     success:successBlock
                                       error:errorBlock];
}

@end
