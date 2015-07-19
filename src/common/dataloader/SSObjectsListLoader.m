//
//  SSObjectListLoader.m
//  IOSAssessment
//
//  Created by Mihail Koltsov on 15.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import "SSObjectsListLoader.h"

#import "SSObjectsListLoadingActions.h"
#import "SSObjectsListLoadingConfiguration.h"

@interface SSObjectsListLoader ()

@property(nonatomic, strong, readonly) NSMutableArray* loadedObjects;
@property(nonatomic, strong, readonly) id<SSObjectsListLoadingActions> actions;
@property(nonatomic, strong, readonly)
    SSObjectsListLoadingConfiguration* configuration;

@end

@implementation SSObjectsListLoader

@synthesize loadedObjects = _loadedObjects;

- (instancetype)initWithActions:(id<SSObjectsListLoadingActions>)actions
    configuration:(SSObjectsListLoadingConfiguration*)configuration {
  NSParameterAssert(actions);
  NSParameterAssert(configuration.pageSize);
  if (!configuration.pageSize || !actions) {
    return nil;
  }

  self = [super initWithDelegate:nil];
  if (self) {
    _actions = actions;
    _configuration = configuration;
  }
  return self;
}

- (NSMutableArray*)loadedObjects {
  if (!_loadedObjects) {
    _loadedObjects = [[NSMutableArray alloc] init];
  }
  return _loadedObjects;
}

- (NSArray*)objects {
  return [self.loadedObjects copy];
}

- (void)load {
  if (![self willLoad]) {
    return;
  }
  
  [super load];
  static NSUInteger const kSSFirstPageIndex = 1;
  [self loadCategoriesWithPageIndex:kSSFirstPageIndex
                        finishBlock:^(NSArray* objects) {
    [self.loadedObjects removeAllObjects];
    [self.loadedObjects addObjectsFromArray:objects];
    [self didLoad];
  }];
}

- (void)loadMore {
  if (![self willLoadMore]) {
    return;
  }
  
  [super willLoadMore];
  
  NSUInteger pageSize = self.configuration.pageSize;
  NSUInteger pageIndex = self.objects.count / pageSize + 1;
  [self loadCategoriesWithPageIndex:pageIndex finishBlock:^(NSArray* objects) {
    [self.loadedObjects addObjectsFromArray:objects];
    if (objects.count < pageSize) {
      self.noMoreObjects = YES;
    }
    [self didLoadMoreWithObjects:objects];
  }];
}

- (void)loadCategoriesWithPageIndex:(NSUInteger)pageIndex
                     finishBlock:(void(^)(NSArray* objects))finishBlock {
  NSUInteger pageSize = self.configuration.pageSize;
  [self.actions requestObjectsWithPageIndex:pageIndex
                                   pageSize:pageSize
                                finishBlock:^(NSArray* objects) {
                                  if (finishBlock) {
                                    finishBlock(objects);
                                  }
                                } errorBlock:^(NSError* error) {
                                  [self error:error];
                                }];
}

@end
