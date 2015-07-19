//
//  SSProductSearchDataFormatter.m
//  IOSAssessment
//
//  Created by user on 18.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import "SSProductSearchDataFormatter.h"

#import "SSCategory.h"
#import "SSProductSearchData.h"

@implementation SSProductSearchDataFormatter

+ (NSString*)URLStringWithBaseKeyPath:(NSString*)baseKeyPath
    andSearchData:(id<SSProductSearchData>)productSearchData {
  NSParameterAssert(baseKeyPath);
  NSMutableArray* searchParameters = [[NSMutableArray alloc] init];

  NSString* categorySearchString =
      [self categorySearchStringFromSearchData:productSearchData];
  if (categorySearchString) {
    [searchParameters addObject:categorySearchString];
  }

  NSString* searchString =
      [self searchStringFromSearchData:productSearchData];
  if (searchString) {
    [searchParameters addObject:searchString];
  }
  
  NSString* skuString = [self skuStringFromSearchData:productSearchData];
  if (skuString) {
    [searchParameters addObject:skuString];
  }
  
  NSMutableString* resultURLString = [baseKeyPath mutableCopy];
  if (searchParameters.count) {
    NSString* searchParamsString =
        [searchParameters componentsJoinedByString:@"&"];
    [resultURLString appendFormat:@"(%@)", searchParamsString];
  }

  return [resultURLString copy];
}

+ (NSString*)categorySearchStringFromSearchData:
    (id<SSProductSearchData>)productSearchData {
  if (![productSearchData respondsToSelector:@selector(category)]) {
    return nil;
  }

  SSCategory* category = [productSearchData category];
  if (!category) {
    return nil;
  }

  static NSString* const kSSCategoryPathIdKey = @"categoryPath.id";
  NSString* categorySearchString =
      [NSString stringWithFormat:@"%@=%@",
                                 kSSCategoryPathIdKey,
                                 category.identifier];
  return categorySearchString;
}

+ (NSString*)searchStringFromSearchData:
    (id<SSProductSearchData>)productSearchData {
  if (![productSearchData respondsToSelector:@selector(searchString)]) {
    return nil;
  }

  NSString* searchString = [productSearchData searchString];
  if (!searchString.length) {
    return nil;
  }

  static NSString* const kSSSearchStringKey = @"search";
  NSString* resultSearchString = [NSString stringWithFormat:@"%@=%@",
                                                            kSSSearchStringKey,
                                                            searchString];

  return resultSearchString;
}

+ (NSString*)skuStringFromSearchData:
    (id<SSProductSearchData>)productSearchData {
  if (![productSearchData respondsToSelector:@selector(sku)]) {
    return nil;
  }
  
  NSString* skuString = [productSearchData sku];
  if (!skuString.length) {
    return nil;
  }
  
  static NSString* const kSSSKUStringKey = @"sku";
  NSString* resultSkuString = [NSString stringWithFormat:@"%@=%@",
                                                         kSSSKUStringKey,
                                                         skuString];
  
  return resultSkuString;
}

@end
