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
#import "SSProductDescriptionCell.h"

typedef NS_ENUM(NSUInteger, SSProductDetailsCells) {
  SSProductDetailsImageCell,
  SSProductDetailsDescriptionCell,
//  SSProductDetailsPriceCell,
//  SSProductDetailsCustomerReviewsCell,
//  SSProductDetailsRelatedProductsCell,
//  SSProductDetailsAccessoriesCell,
  SSProductDetailsCellsCount
};

@interface SSProductDetailsViewController()<JTModelDelegate>

@property(nonatomic, strong, readonly) SSProductDetailsLoader* dataLoader;
@property(nonatomic, strong, readonly)
    SSProductDetailsSearchDataSource* searchDataSource;

@end

static NSString* const kSSProductImageCellIdentifier =
    @"SSProductImageCellIdentifier";
static NSString* const kSSProductDescriptionCellIdentifier =
    @"SSProductDescriptionCellIdentifier";

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
    self.title = @"Product Details";
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
  [self.tableView registerClass:[SSProductDescriptionCell class]
         forCellReuseIdentifier:kSSProductDescriptionCellIdentifier];
  
  self.tableView.rowHeight = UITableViewAutomaticDimension;
  self.tableView.estimatedRowHeight = 200.0;
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

- (NSInteger)tableView:(UITableView*)tableView
    numberOfRowsInSection:(NSInteger)section {
  return SSProductDetailsCellsCount;
}

- (CGFloat)tableView:(UITableView*)tableView
    heightForRowAtIndexPath:(NSIndexPath*)indexPath {
  switch (indexPath.row) {
    case SSProductDetailsImageCell:
      return ceilf(CGRectGetWidth(self.view.bounds) / 2);
    case SSProductDetailsDescriptionCell:
      return UITableViewAutomaticDimension;
  }
  NSParameterAssert(NO);
  return 0;
}

- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath {
  UITableViewCell* cell;
  switch (indexPath.row) {
      case SSProductDetailsImageCell:
      cell = [self productImageCellForTableView:tableView];
      break;
      case SSProductDetailsDescriptionCell:
      cell = [self productDescriptionCellForTableView:tableView];
      break;
  }
  
  [cell setNeedsUpdateConstraints];
  [cell updateConstraintsIfNeeded];
  return cell;
}

- (UITableViewCell*)productImageCellForTableView:(UITableView*)tableView {
  NSIndexPath* indexPath =
      [NSIndexPath indexPathForRow:SSProductDetailsImageCell inSection:0];
  SSProductImageCell* cell = (SSProductImageCell*)[tableView
      dequeueReusableCellWithIdentifier:kSSProductImageCellIdentifier
                           forIndexPath:indexPath];

  SSProduct* product = (SSProduct*)self.dataLoader.object;
  NSString* imageURLString =  product.largeImage ?: product.thumbnailImage;
  [cell setImageURL:[NSURL URLWithString:imageURLString]];
  return cell;
}

- (UITableViewCell*)productDescriptionCellForTableView:(UITableView*)tableView {
  NSIndexPath* indexPath =
  [NSIndexPath indexPathForRow:SSProductDetailsDescriptionCell inSection:0];
  SSProductDescriptionCell* cell = (SSProductDescriptionCell*)[tableView
      dequeueReusableCellWithIdentifier:kSSProductDescriptionCellIdentifier
                           forIndexPath:indexPath];

  SSProduct* product = (SSProduct*)self.dataLoader.object;
  [cell setProductName:product.name description:product.longDescription];
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
