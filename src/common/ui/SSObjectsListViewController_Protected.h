//
//  SSCategorySelectViewController_Protected.h
//  IOSAssessment
//
//  Created by user on 20.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import "SSObjectsListViewController.h"

#import "SSObjectsListLoader.h"

@interface SSObjectsListViewController ()

@property(nonatomic, strong, readonly) SSObjectsListLoader* dataLoader;

- (id<SSObjectsListLoadingActions>)loadingActions;
- (void)setupTableView;
- (void)loadData;

@end
