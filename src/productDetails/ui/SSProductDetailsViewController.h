//
//  SSProductDetailsViewController.h
//  IOSAssessment
//
//  Created by user on 19.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSProduct;

@interface SSProductDetailsViewController : UITableViewController

- (instancetype)initWithProduct:(SSProduct*)product NS_DESIGNATED_INITIALIZER;

@end
