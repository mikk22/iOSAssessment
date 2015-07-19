//
//  SSObjectResponseMapper.h
//  IOSAssessment
//
//  Created by Mihail Koltsov on 14.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SSObjectResponseDescription;

@interface SSObjectResponseMapper : NSObject

+ (NSArray*)mapObjectsFromDictionary:(NSDictionary*)dictionary
    withResponseDescription:(SSObjectResponseDescription*)responseDescription;

@end
