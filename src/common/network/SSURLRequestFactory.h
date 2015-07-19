//
//  SSURLRequestFactory.h
//  IOSAssessment
//
//  Created by user on 19.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SSRequestOperationManagerConfiguration;

@interface SSURLRequestFactory : NSObject

- (instancetype)initWithConfiguration:
    (SSRequestOperationManagerConfiguration*)configuration
        NS_DESIGNATED_INITIALIZER;

- (NSURLRequest*)GETRequestWithKeyPath:(NSString*)keyPath
                            parameters:(NSDictionary*)parameters;

@end
