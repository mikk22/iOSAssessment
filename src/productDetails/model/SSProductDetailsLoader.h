//
//  SSProductDetailsLoader.h
//  IOSAssessment
//
//  Created by user on 19.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import "JTModel.h"

@class SSProduct;
@class SSProductDetailsLoadingActions;

@protocol SSObjectDetailsLoadingActions;

@interface SSProductDetailsLoader : JTModel

@property(nonatomic, strong, readonly) SSProduct* object;

- (instancetype)initWithActions:(id<SSObjectDetailsLoadingActions>)actions
                         object:(SSProduct*)object;

@end
