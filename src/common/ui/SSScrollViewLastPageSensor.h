//
//  SSScrollViewLastPageSensor.h
//  IOSAssessment
//
//  Created by user on 15.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SSScrollViewLastPageSensorDelegate;

@interface SSScrollViewLastPageSensor : NSObject<UIScrollViewDelegate>

@property(nonatomic, weak) id<SSScrollViewLastPageSensorDelegate> delegate;

@end

@protocol SSScrollViewLastPageSensorDelegate<NSObject>

- (void)scrollViewLastPageSensorDidReachLastPage:
    (SSScrollViewLastPageSensor*)lastPageSensor;

@end
