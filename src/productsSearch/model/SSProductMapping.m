//
//  SSProductMapping.m
//  IOSAssessment
//
//  Created by Mihail Koltsov on 15.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import "SSProductMapping.h"

#import <DCKeyValueObjectMapping/DCArrayMapping.h>
#import <DCKeyValueObjectMapping/DCObjectMapping.h>
#import <DCKeyValueObjectMapping/DCParserConfiguration.h>

#import "SSProduct.h"

@implementation SSProductMapping

- (Class)mappingClass {
  return [SSProduct class];
}

//  @property(nonatomic, copy) NSArray* accessories; //accessories

- (DCParserConfiguration*)mappingConfiguration {
  Class mappingClass = [self mappingClass];
  DCParserConfiguration* configuration = [DCParserConfiguration configuration];
  DCObjectMapping* sku = [DCObjectMapping mapKeyPath:@"sku"
                                         toAttribute:@"sku"
                                             onClass:mappingClass];
  DCObjectMapping* name = [DCObjectMapping mapKeyPath:@"name"
                                          toAttribute:@"name"
                                              onClass:mappingClass];
  DCObjectMapping* longDescription = [DCObjectMapping mapKeyPath:@"longDescription"
                                                     toAttribute:@"longDescription"
                                                         onClass:mappingClass];
  DCObjectMapping* thumbnail = [DCObjectMapping mapKeyPath:@"thumbnailImage"
                                               toAttribute:@"thumbnailImage"
                                                   onClass:mappingClass];
  DCObjectMapping* largeImage = [DCObjectMapping mapKeyPath:@"image"
                                                toAttribute:@"image"
                                                    onClass:mappingClass];
  DCObjectMapping* regularPrice = [DCObjectMapping mapKeyPath:@"regularPrice"
                                                  toAttribute:@"regularPrice"
                                                      onClass:mappingClass];
  DCObjectMapping* salePrice = [DCObjectMapping mapKeyPath:@"salePrice"
                                               toAttribute:@"salePrice"
                                                   onClass:mappingClass];
  DCObjectMapping* onSale = [DCObjectMapping mapKeyPath:@"onSale"
                                            toAttribute:@"onSale"
                                                onClass:mappingClass];
  DCObjectMapping* customerReviewCount = [DCObjectMapping mapKeyPath:@"customerReviewCount"
                                                         toAttribute:@"customerReviewCount"
                                                             onClass:mappingClass];
  DCObjectMapping* customerReviewAverage = [DCObjectMapping mapKeyPath:@"customerReviewAverage"
                                                           toAttribute:@"customerReviewAverage"
                                                               onClass:mappingClass];
  DCArrayMapping* relatedProducts =
      [DCArrayMapping mapperForClassElements:[SSProduct class]
                                forAttribute:@"relatedProducts"
                                     onClass:mappingClass];

  [configuration addObjectMapping:sku];
  [configuration addObjectMapping:name];
  [configuration addObjectMapping:longDescription];
  [configuration addObjectMapping:thumbnail];
  [configuration addObjectMapping:largeImage];
  [configuration addObjectMapping:regularPrice];
  [configuration addObjectMapping:salePrice];
  [configuration addObjectMapping:onSale];
  [configuration addObjectMapping:customerReviewCount];
  [configuration addObjectMapping:customerReviewAverage];
  [configuration addArrayMapper:relatedProducts];
  return configuration;
}

@end
