//
//  SSCategoryMapper.m
//  IOSAssessment
//
//  Created by Mihail Koltsov on 13.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import "SSCategoryMapping.h"

#import <DCKeyValueObjectMapping/DCObjectMapping.h>
#import <DCKeyValueObjectMapping/DCParserConfiguration.h>

#import "SSCategory.h"

@implementation SSCategoryMapping

- (Class)mappingClass {
  return [SSCategory class];
}

- (DCParserConfiguration*)mappingConfiguration {
  Class mappingClass = [self mappingClass];
  DCParserConfiguration* configuration = [DCParserConfiguration configuration];
  DCObjectMapping* identifier = [DCObjectMapping mapKeyPath:@"id"
                                                toAttribute:@"identifier"
                                                    onClass:mappingClass];
  DCObjectMapping* name = [DCObjectMapping mapKeyPath:@"name"
                                          toAttribute:@"name"
                                              onClass:mappingClass];
  [configuration addObjectMapping:identifier];
  [configuration addObjectMapping:name];

  return configuration;
}

@end
