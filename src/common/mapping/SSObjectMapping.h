//
//  SSObjectMapping.h
//  IOSAssessment
//
//  Created by Mihail Koltsov on 14.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DCParserConfiguration;

@protocol SSObjectMapping<NSObject>

- (Class)mappingClass;
- (DCParserConfiguration*)mappingConfiguration;

@end
