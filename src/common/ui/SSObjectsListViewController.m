//
//  SSCategorySelectViewController.m
//  IOSAssessment
//
//  Created by user on 12.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import "SSObjectsListViewController.h"
#import "SSObjectsListViewController_Protected.h"

#import "SSObjectsListLoadingConfiguration.h"
#import "SSScrollViewLastPageSensor.h"
#import "SSTableViewDelegateForwarder.h"

@interface SSObjectsListViewController ()<
    JTModelDelegate,
    SSScrollViewLastPageSensorDelegate>

@property(nonatomic, strong) SSScrollViewLastPageSensor* lastPageSensor;
@property(nonatomic, strong)
    SSTableViewDelegateForwarder* tableViewDelegateForwarder;

@end

@implementation SSObjectsListViewController

@synthesize dataLoader = _dataLoader;

- (SSScrollViewLastPageSensor*)lastPageSensor {
  if (!_lastPageSensor) {
    _lastPageSensor = [[SSScrollViewLastPageSensor alloc] init];
    _lastPageSensor.delegate = self;
  }
  return _lastPageSensor;
}

- (id<SSObjectsListLoadingActions>)loadingActions {
  NSAssert(NO, @"This delegate method should be implemented in subclass");
  return nil;
}

- (SSObjectsListLoadingConfiguration*)loadingConfiguration {
  return [SSObjectsListLoadingConfiguration defaultConfiguration];
}

- (SSObjectsListLoader*)dataLoader {
  if (!_dataLoader) {
    SSObjectsListLoadingConfiguration* configuration =
        [self loadingConfiguration];
    id<SSObjectsListLoadingActions> loadingActions = [self loadingActions];
    _dataLoader =
        [[SSObjectsListLoader alloc] initWithActions:loadingActions
                                       configuration:configuration];
    _dataLoader.delegate = self;
  }
  return _dataLoader;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupTableView];
  [self setupRefreshControl];
  [self loadData];
}

- (void)loadData {
  [self.dataLoader load];
}

- (void)setupRefreshControl {
  UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
  [refreshControl addTarget:self
                     action:@selector(loadData)
           forControlEvents:UIControlEventValueChanged];
  
  [self.tableView addSubview:refreshControl];
  self.refreshControl = refreshControl;
}

- (void)setupTableView {
  self.tableView.tableFooterView = [[UIView alloc] init];
  self.tableViewDelegateForwarder = [[SSTableViewDelegateForwarder alloc] init];
  self.tableViewDelegateForwarder.scrollViewDelegate = self.lastPageSensor;
  self.tableViewDelegateForwarder.tableViewDelegate = self;
  self.tableView.delegate = self.tableViewDelegateForwarder;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView*)tableView
    numberOfRowsInSection:(NSInteger)section {
  return self.dataLoader.objects.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath {
  NSAssert(NO, @"This delegate method should be implemented in subclass");
  return nil;
}

#pragma mark - SSScrollViewLastPageSensorDelegate

- (void)scrollViewLastPageSensorDidReachLastPage:
    (SSScrollViewLastPageSensor*)lastPageSensor {
  if (!self.dataLoader.noMoreObjects) {
    [self.dataLoader loadMore];
  }
}

#pragma mark - JTModelDelegate

- (void)modelDidLoad:(JTModel*)model {
  [self.tableView reloadData];
  [self.refreshControl endRefreshing];
}

- (void)modelWillLoadMore:(JTModel*)model {
  UIActivityIndicatorView* activityView = [[UIActivityIndicatorView alloc]
      initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
  activityView.frame = CGRectMake(0.f, 0.f, 0.f, 50.f);
  [activityView startAnimating];
  self.tableView.tableFooterView = activityView;
}

- (void)model:(JTModel*)model didLoadMoreWithObjects:(id)newObjects {
  //should reload only for new objects
  //fix in future
  [self.tableView reloadData];
  self.tableView.tableFooterView = nil;
}

- (void)model:(JTModel*)model error:(NSError*)aError {
  //should show info error here
  [self.refreshControl endRefreshing];
}

@end
