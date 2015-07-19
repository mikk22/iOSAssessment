//
//  SSProductSearchDataFormatter.h
//  IOSAssessment
//
//  Created by user on 18.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SSProductSearchData;

@interface SSProductSearchDataFormatter : NSObject

+ (NSString*)URLStringWithBaseKeyPath:(NSString*)baseKeyPath
    andSearchData:(id<SSProductSearchData>)productSearchData;

@end
