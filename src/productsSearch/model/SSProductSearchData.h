//
//  SSProductSearchData.h
//  IOSAssessment
//
//  Created by user on 18.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SSCategory;

@protocol SSProductSearchData<NSObject>

@optional

@property(nonatomic, strong) SSCategory* category;
@property(nonatomic, copy) NSString* searchString;
@property(nonatomic, copy, readonly) NSString* sku;

@end
