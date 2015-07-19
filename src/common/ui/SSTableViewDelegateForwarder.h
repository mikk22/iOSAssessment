//
//  SSTableViewDelegateForwarder.h
//  IOSAssessment
//
//  Created by user on 16.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSTableViewDelegateForwarder : NSObject<UITableViewDelegate>

@property(nonatomic, weak) NSObject<UIScrollViewDelegate>* scrollViewDelegate;
@property(nonatomic, weak) NSObject<UITableViewDelegate>* tableViewDelegate;

@end
