//
//  SSObjectsListLoadingActions.h
//  IOSAssessment
//
//  Created by Mihail Koltsov on 15.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SSObjectsListLoadingActions<NSObject>

- (void)requestObjectsWithPageIndex:(NSUInteger)pageIndex
                           pageSize:(NSUInteger)pageSize
                        finishBlock:(void(^)(NSArray* objects))finishBlock
                         errorBlock:(void(^)(NSError* error))errorBlock;

@end
