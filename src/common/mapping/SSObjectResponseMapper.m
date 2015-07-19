//
//  SSObjectResponseMapper.m
//  IOSAssessment
//
//  Created by Mihail Koltsov on 14.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import "SSObjectResponseMapper.h"

#import <DCKeyValueObjectMapping/DCKeyValueObjectMapping.h>
#import <DCKeyValueObjectMapping/DCParserConfiguration.h>

#import "SSObjectMapping.h"
#import "SSObjectResponseDescription.h"

@implementation SSObjectResponseMapper

+ (NSArray*)mapObjectsFromDictionary:(NSDictionary*)dictionary
    withResponseDescription:(SSObjectResponseDescription*)responseDescription {
  NSString* keyPath = responseDescription.keyPath;
  id source = dictionary;
  if (keyPath) {
    source = dictionary[keyPath];
  }

  id<SSObjectMapping> mapping = responseDescription.mapping;
  return [self mapObjectsFromResponseObject:source withMapping:mapping];
}

+ (NSArray*)mapObjectsFromResponseObject:(id)responseObject
                             withMapping:(id<SSObjectMapping>)mapping {
  Class mappingClass = [mapping mappingClass];
  DCParserConfiguration* configuration = [mapping mappingConfiguration];
  DCKeyValueObjectMapping* parser =
      [DCKeyValueObjectMapping mapperForClass:mappingClass
                             andConfiguration:configuration];
  if ([responseObject isKindOfClass:[NSArray class]]) {
    NSArray* resultArray = [parser parseArray:responseObject];
    return resultArray;
  } else {
    id resultObject = [parser parseDictionary:responseObject];
    return @[ resultObject ];
  }
}

@end
