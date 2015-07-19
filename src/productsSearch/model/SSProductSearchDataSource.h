//
//  SSproductSearchParameters.h
//  IOSAssessment
//
//  Created by user on 17.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SSProductSearchData.h"

@interface SSProductSearchDataSource : NSObject<SSProductSearchData>

@property(nonatomic, strong) SSCategory* category;
@property(nonatomic, copy) NSString* searchString;

@end
