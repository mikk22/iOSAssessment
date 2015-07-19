//
//  SSScrollViewLastPageSensor.m
//  IOSAssessment
//
//  Created by user on 15.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import "SSScrollViewLastPageSensor.h"

@interface SSScrollViewLastPageSensor()

@property(nonatomic, assign) CGPoint currentContentOffset;

@end

@implementation SSScrollViewLastPageSensor

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  CGPoint contentOffsetDelta =
      CGPointMake(scrollView.contentOffset.x - self.currentContentOffset.x,
                  scrollView.contentOffset.y - self.currentContentOffset.y);

  BOOL scrollingToBottom = contentOffsetDelta.y > 0;
  BOOL contentHeightGreaterThanBounds = scrollView.contentSize.height > scrollView.bounds.size.height;
  CGFloat const scrollViewFooterHeight = 0.f;
  
  if (contentHeightGreaterThanBounds && scrollingToBottom &&
      (scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.bounds.size.height- scrollViewFooterHeight)
      ) {
    [self notifyDelegateDidReachLastPage];
  }

  self.currentContentOffset = scrollView.contentOffset;
}

- (void)notifyDelegateDidReachLastPage {
  [self.delegate scrollViewLastPageSensorDidReachLastPage:self];
}

@end
