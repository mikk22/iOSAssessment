//
//  SSObjectListLoader.h
//  IOSAssessment
//
//  Created by Mihail Koltsov on 15.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import "JTModel.h"

@class SSObjectsListLoadingConfiguration;

@protocol SSObjectsListLoadingActions;

@interface SSObjectsListLoader : JTModel

@property(nonatomic, copy, readonly) NSArray* objects;

- (instancetype)initWithActions:(id<SSObjectsListLoadingActions>)actions
    configuration:(SSObjectsListLoadingConfiguration*)configuration;

@end
