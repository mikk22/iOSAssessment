//
//  SSTableViewDelegateForwarder.m
//  IOSAssessment
//
//  Created by user on 16.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import "SSTableViewDelegateForwarder.h"

@implementation SSTableViewDelegateForwarder

- (BOOL)respondsToSelector:(SEL)selector {
  BOOL isParentRespondingToSelector = [super respondsToSelector:selector];
  BOOL isScrollViewDelegateRespondingToSelector =
      [self.scrollViewDelegate respondsToSelector:selector];
  BOOL isTableViewDelegateRespondingToSelector =
      [self.tableViewDelegate respondsToSelector:selector];

  return (isParentRespondingToSelector ||
          isScrollViewDelegateRespondingToSelector ||
          isTableViewDelegateRespondingToSelector);
}

- (NSMethodSignature*)methodSignatureForSelector:(SEL)selector {
  NSMethodSignature* signature = [super methodSignatureForSelector:selector];
  if (!signature) {
    signature = [self.scrollViewDelegate methodSignatureForSelector:selector];
  }
  if (!signature) {
    signature = [self.tableViewDelegate methodSignatureForSelector:selector];
  }

  return signature;
}

- (void)forwardInvocation:(NSInvocation*)invocation {
  SEL selector = invocation.selector;
  if ([super respondsToSelector:selector]) {
    [super forwardInvocation:invocation];
  } else if ([self.scrollViewDelegate respondsToSelector:selector]) {
    [invocation invokeWithTarget:self.scrollViewDelegate];
  } else if ([self.tableViewDelegate respondsToSelector:selector]) {
    [invocation invokeWithTarget:self.tableViewDelegate];
  }
}

@end
