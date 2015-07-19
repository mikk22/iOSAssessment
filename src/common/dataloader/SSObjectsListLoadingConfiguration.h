//
//  SSObjectsListLoadingConfiguration.h
//  IOSAssessment
//
//  Created by user on 15.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSObjectsListLoadingConfiguration : NSObject

@property(nonatomic, assign, readonly) NSUInteger pageSize;

+ (instancetype)defaultConfiguration;

@end
