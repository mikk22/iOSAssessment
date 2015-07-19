//
//  SSProductDetailsViewController.m
//  IOSAssessment
//
//  Created by user on 19.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import "SSProductDetailsViewController.h"

#import "SSProduct.h"
#import "SSProductDetailsLoader.h"
#import "SSProductDetailsLoadingActions.h"
#import "SSProductDetailsSearchDataSource.h"
#import "SSProductImageCell.h"

NS_ENUM(NSUInteger, SSProductDetailsCells) {
  SSProductDetailsImageCell,
};

@interface SSProductDetailsViewController()<JTModelDelegate>

@property(nonatomic, strong, readonly) SSProductDetailsLoader* dataLoader;
@property(nonatomic, strong, readonly)
    SSProductDetailsSearchDataSource* searchDataSource;

@end

static NSString* const kSSProductImageCellIdentifier =
    @"SSProductImageCellIdentifier";

@implementation SSProductDetailsViewController

- (instancetype)initWithCoder:(NSCoder*)aDecoder {
  return [self initWithProduct:nil];
}

- (instancetype)initWithNibName:(NSString*)nibNameOrNil
                         bundle:(NSBundle*)nibBundleOrNil {
  return [self initWithProduct:nil];
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
  return [self initWithProduct:nil];
}

- (instancetype)initWithProduct:(SSProduct*)product {
  NSParameterAssert(product);
  if (!product) {
    return nil;
  }

  self = [super initWithNibName:nil bundle:nil];
  if (self) {
    SSProductDetailsLoadingActions* loadingActions =
        [[SSProductDetailsLoadingActions alloc] init];
    _dataLoader = [[SSProductDetailsLoader alloc] initWithActions:loadingActions
                                                           object:product];
    _dataLoader.delegate = self;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupTableView];
  [self setupRefreshControl];
  [self.dataLoader load];
}

- (void)setupTableView {
  self.tableView.tableFooterView = [[UIView alloc] init];
  [self.tableView registerClass:[SSProductImageCell class]
         forCellReuseIdentifier:kSSProductImageCellIdentifier];
}

- (void)setupRefreshControl {
  UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
  [refreshControl addTarget:self
                     action:@selector(loadData)
           forControlEvents:UIControlEventValueChanged];
  
  [self.tableView addSubview:refreshControl];
  self.refreshControl = refreshControl;
}

- (void)loadData {
  [self.dataLoader load];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
  return 1;
}

- (CGFloat)tableView:(UITableView*)tableView
    heightForRowAtIndexPath:(NSIndexPath*)indexPath {
  switch (indexPath.row) {
    case SSProductDetailsImageCell:
      return CGRectGetWidth(self.view.bounds);
  }
  NSParameterAssert(NO);
  return 0;
}

- (NSInteger)tableView:(UITableView*)tableView
 numberOfRowsInSection:(NSInteger)section {
  return 1;
}

- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath {
  SSProductImageCell* cell = (SSProductImageCell*)[tableView dequeueReusableCellWithIdentifier:kSSProductImageCellIdentifier
                                                                        forIndexPath:indexPath];
  
  SSProduct* product = (SSProduct*)self.dataLoader.object;
  [cell setImageURL:[NSURL URLWithString:product.thumbnailImage]];
  
  [cell setNeedsUpdateConstraints];
  [cell updateConstraintsIfNeeded];
  return cell;
}

#pragma mark - JTModelDelegate

- (void)modelDidLoad:(JTModel*)model {
  [self.tableView reloadData];
  [self.refreshControl endRefreshing];
}

- (void)model:(JTModel*)model error:(NSError*)aError {
  //should show info error here
  [self.refreshControl endRefreshing];
}

@end
