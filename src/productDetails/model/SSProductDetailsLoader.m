//
//  SSProductDetailsLoader.m
//  IOSAssessment
//
//  Created by user on 19.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import "SSProductDetailsLoader.h"

#import "SSObjectDetailsLoadingActions.h"
#import "SSProduct.h"

@interface SSProductDetailsLoader ()

@property(nonatomic, strong, readwrite) SSProduct* object;
@property(nonatomic, strong, readonly)
    id<SSObjectDetailsLoadingActions> actions;

@end

@implementation SSProductDetailsLoader

- (instancetype)initWithActions:(id<SSObjectDetailsLoadingActions>)actions
                         object:(SSProduct*)object {
  NSParameterAssert(actions);
  NSParameterAssert(object);
  if (!actions || ! object) {
    return nil;
  }

  self = [super initWithDelegate:nil];
  if (self) {
    _actions = actions;
    _object = object;
  }
  return self;
}

- (void)load {
  if (![self willLoad]) {
    return;
  }
  
  [super load];
  [self.actions requestObjectWithIdentifier:self.object.sku.stringValue
                                finishBlock:^(NSArray* objects) {
    self.object =  [objects lastObject];
    [self didLoad];
  } errorBlock:^(NSError* error) {
    [self error:error];
  }];
}

@end
