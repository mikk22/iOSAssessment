//
//  SSObjectDetailsLoadingActions.h
//  IOSAssessment
//
//  Created by user on 19.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SSObjectDetailsLoadingActions<NSObject>

- (void)requestObjectWithIdentifier:(NSString*)identifier
                        finishBlock:(void(^)(NSArray* objects))finishBlock
                         errorBlock:(void(^)(NSError* error))errorBlock;

@end
