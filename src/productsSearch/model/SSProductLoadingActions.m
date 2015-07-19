//
//  SSProductLoadingActions.m
//  IOSAssessment
//
//  Created by Mihail Koltsov on 15.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import "SSProductLoadingActions.h"

#import "SSObjectResponseDescription.h"
#import "SSObjectResponseMapper.h"
#import "SSProductMapping.h"
#import "SSProductSearchDataFormatter.h"
#import "SSProductSearchDataSource.h"
#import "SSRequestOperationManager.h"
#import "SSURLRequestFactory.h"

@implementation SSProductLoadingActions

- (SSRequestOperationManager*)requestOperationManager {
  return [SSRequestOperationManager sharedManager];
}

- (SSURLRequestFactory*)URLRequestFactory {
  return [self requestOperationManager].URLRequestFactory;
}

- (NSURLRequest*)URLrequestWithKeyPath:(NSString*)keyPath
                             pageIndex:(NSUInteger)pageIndex
                             pageSize:(NSUInteger)pageSize {
  NSParameterAssert(pageSize);
  NSMutableDictionary* URLParameters = [@{
    @"show" : @"sku,name,thumbnailImage,regularPrice",
    @"pageSize" : @(pageSize)
  } mutableCopy];
  if (pageIndex) {
    [URLParameters setObject:@(pageIndex) forKey:@"page"];
  }

  NSString* keyPathWithSearchData = [SSProductSearchDataFormatter
      URLStringWithBaseKeyPath:keyPath
                 andSearchData:self.searchDataSource];
  NSDictionary* requestParameters = [URLParameters copy];
  NSURLRequest* request =
      [[self URLRequestFactory] GETRequestWithKeyPath:keyPathWithSearchData
                                           parameters:requestParameters];

  return request;
}

- (void)requestObjectsWithPageIndex:(NSUInteger)pageIndex
                           pageSize:(NSUInteger)pageSize
                        finishBlock:(void(^)(NSArray* objects))finishBlock
                         errorBlock:(void(^)(NSError* error))errorBlock {
  NSString* keyPath = @"products";
  NSURLRequest* request = [self URLrequestWithKeyPath:keyPath
                                            pageIndex:pageIndex
                                             pageSize:pageSize];
  void(^successBlock)(id responseObject) = ^(id responseObject) {
    SSProductMapping* mapping = [[SSProductMapping alloc] init];
    SSObjectResponseDescription* responseDescription =
        [[SSObjectResponseDescription alloc] initWithObjectMapping:mapping
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
