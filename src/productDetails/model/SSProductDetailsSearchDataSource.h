//
//  SSProductDetailsSearchDataSource.h
//  IOSAssessment
//
//  Created by user on 19.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SSProductSearchData.h"

@interface SSProductDetailsSearchDataSource : NSObject<SSProductSearchData>

@property(nonatomic, copy, readonly) NSString* sku;

- (instancetype)initWithSKU:(NSString*)sku NS_DESIGNATED_INITIALIZER;

@end
