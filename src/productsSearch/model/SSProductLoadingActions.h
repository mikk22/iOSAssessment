//
//  SSProductLoadingActions.h
//  IOSAssessment
//
//  Created by Mihail Koltsov on 15.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SSObjectsListLoadingActions.h"

@protocol SSProductSearchData;

@interface SSProductLoadingActions : NSObject<
    SSObjectsListLoadingActions>

@property(nonatomic, weak) id<SSProductSearchData> searchDataSource;

@end
