//
//  SSNewCategorySelectViewController.h
//  IOSAssessment
//
//  Created by user on 20.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import "SSObjectsListViewController.h"

@class SSCategory;

@protocol SSCategorySelectViewControllerDelegate;

@interface SSCategorySelectViewController : SSObjectsListViewController

@property(nonatomic, weak) id<SSCategorySelectViewControllerDelegate> delegate;

@end

@protocol SSCategorySelectViewControllerDelegate<NSObject>

- (SSCategory*)selectedCategoryForCategorySelectViewController:
    (SSCategorySelectViewController*)categorySelectViewController;

- (void)categorySelectViewController:
    (SSCategorySelectViewController*)categorySelectViewController
                   didSelectCategory:(SSCategory*)category;

@end
