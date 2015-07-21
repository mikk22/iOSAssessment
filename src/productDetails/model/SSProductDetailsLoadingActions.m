//
//  SSProductDetailsLoadingActions.m
//  IOSAssessment
//
//  Created by user on 20.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import "SSProductDetailsLoadingActions.h"

#import "SSObjectResponseDescription.h"
#import "SSObjectResponseMapper.h"
#import "SSProductDetailsSearchDataSource.h"
#import "SSProductMapping.h"
#import "SSProductSearchDataFormatter.h"
#import "SSRequestOperationManager.h"
#import "SSURLRequestFactory.h"

@implementation SSProductDetailsLoadingActions

- (SSRequestOperationManager*)requestOperationManager {
  return [SSRequestOperationManager sharedManager];
}

- (SSURLRequestFactory*)URLRequestFactory {
  return [self requestOperationManager].URLRequestFactory;
}

- (NSURLRequest*)URLRequestWithKeyPath:(NSString*)keyPath
                            identifier:(NSString*)identifier {
  NSDictionary* requestParameters = @{
    @"show":@"sku,name,thumbnailImage,image,largeImage,regularPrice,salePrice,onSale,"
             "longDescription,customerReviewCount,customerReviewAverage,"
             "accessories,relatedProducts",
  };

  SSProductDetailsSearchDataSource* searchDataSource =
      [[SSProductDetailsSearchDataSource alloc] initWithSKU:identifier];
  NSString* keyPathWithSearchData =
      [SSProductSearchDataFormatter URLStringWithBaseKeyPath:keyPath
                                               andSearchData:searchDataSource];
  NSURLRequest* request =
      [[self URLRequestFactory] GETRequestWithKeyPath:keyPathWithSearchData
                                           parameters:requestParameters];
  return request;
}

- (void)requestObjectWithIdentifier:(NSString*)identifier
                        finishBlock:(void(^)(NSArray* objects))finishBlock
                         errorBlock:(void(^)(NSError* error))errorBlock {
  NSParameterAssert(identifier);
  NSString* keyPath = @"products";
  NSURLRequest* request = [self URLRequestWithKeyPath:keyPath
                                           identifier:identifier];

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
  
  [self.requestOperationManager
      perfromHTTPRequestOperationWithRequest:request
                                     success:successBlock
                                       error:errorBlock];
}

@end
