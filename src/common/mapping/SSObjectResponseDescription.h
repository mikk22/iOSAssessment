//
//  SSObjectResponseDescription.h
//  IOSAssessment
//
//  Created by Mihail Koltsov on 14.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SSObjectMapping;

@interface SSObjectResponseDescription : NSObject

@property(nonatomic, strong, readonly) id<SSObjectMapping> mapping;
@property(nonatomic, copy, readonly) NSString* keyPath;

- (instancetype)initWithObjectMapping:(id<SSObjectMapping>)mapping
                              keyPath:(NSString*)keyPath
    NS_DESIGNATED_INITIALIZER;

@end
