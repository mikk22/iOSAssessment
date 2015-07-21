//
//  SSProductSearchViewController.m
//  IOSAssessment
//
//  Created by user on 12.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import "SSProductSearchViewController.h"
#import "SSObjectsListViewController_Protected.h"

#import "SSCategory.h"
#import "SSCategorySelectViewController.h"
#import "SSProductCell.h"
#import "SSProductDetailsViewController.h"
#import "SSProductLoadingActions.h"
#import "SSProductSearchDataSource.h"

@interface SSProductSearchViewController ()<
    SSCategorySelectViewControllerDelegate,
    UISearchBarDelegate>

@property(nonatomic, strong, readonly)
    SSProductSearchDataSource* searchDataSource;

@end

static NSString* const kSSProductCellIdentifier = @"SSProductCellIdentifier";

@implementation SSProductSearchViewController

@synthesize searchDataSource = _searchDataSource;

- (SSProductSearchDataSource*)searchDataSource {
  if (!_searchDataSource) {
    _searchDataSource = [[SSProductSearchDataSource alloc] init];
  }
  return _searchDataSource;
}

- (id<SSObjectsListLoadingActions>)loadingActions {
  SSProductLoadingActions* loadingActions =
      [[SSProductLoadingActions alloc] init];
  loadingActions.searchDataSource = self.searchDataSource;
  return loadingActions;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupNavigationBarItems];
  [self setupSearchBar];
}

- (void)setupNavigationBarItems {
  SEL selectCategoryItemTouchedSel = @selector(selectCategoryItemTouched:);
  UIBarButtonItem* categorySelectItem =
      [[UIBarButtonItem alloc] initWithTitle:@"category"
                                      style:UIBarButtonItemStylePlain
                                     target:self
                                     action:selectCategoryItemTouchedSel];
  self.navigationItem.leftBarButtonItem = categorySelectItem;
}

- (void)setupTableView {
  [super setupTableView];
  [self.tableView registerClass:[SSProductCell class]
         forCellReuseIdentifier:kSSProductCellIdentifier];
  
  self.tableView.estimatedRowHeight = 200.0;
  self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)setupSearchBar {
  UISearchBar* searchBar =
      [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 0, 44.f)];
  searchBar.placeholder = @"Search";
  searchBar.delegate = self;
  self.tableView.tableHeaderView = searchBar;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)selectCategoryItemTouched:(id)sender {
  SSCategorySelectViewController* categorySelectVc =
      [[SSCategorySelectViewController alloc] init];
  categorySelectVc.delegate = self;
  UINavigationController* nc = [[UINavigationController alloc]
      initWithRootViewController:categorySelectVc];
  [self presentViewController:nc animated:YES completion:NULL];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath {
  SSProductCell* cell = (SSProductCell*)[tableView dequeueReusableCellWithIdentifier:kSSProductCellIdentifier
                                                                        forIndexPath:indexPath];
  NSArray* categories = self.dataLoader.objects;
  NSParameterAssert(categories.count > indexPath.row);
  SSProduct* product = categories[indexPath.row];
  [cell setProduct:product];

  [cell setNeedsUpdateConstraints];
  [cell updateConstraintsIfNeeded];
  return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView*)tableView
    didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:NO];

  SSProduct* product = self.dataLoader.objects[indexPath.row];
  SSProductDetailsViewController* productDetailsVc =
      [[SSProductDetailsViewController alloc] initWithProduct:product];
  [self.navigationController pushViewController:productDetailsVc animated:YES];
}

#pragma mark - SSCategorySelectViewControllerDelegate

- (SSCategory*)selectedCategoryForCategorySelectViewController:
    (SSCategorySelectViewController*)categorySelectViewController {
  return self.searchDataSource.category;
}

- (void)categorySelectViewController:
    (SSCategorySelectViewController*)categorySelectViewController
                   didSelectCategory:(id)category {
  if ([self.searchDataSource.category isEqual:category]) {
    return;
  }

  self.searchDataSource.category = category;
  [self loadData];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar*)searchBar {
  NSString* searchString = searchBar.text;
  self.searchDataSource.searchString = searchString;
  [self loadData];

  [searchBar resignFirstResponder];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar*)searchBar {
  [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar*)searchBar {
  if (searchBar.text && !self.searchDataSource.searchString.length) {
    searchBar.text = nil;
  }

  if (!searchBar.text.length && self.searchDataSource.searchString.length) {
    self.searchDataSource.searchString = nil;
    [self loadData];
  }

  [searchBar setShowsCancelButton:NO animated:YES];
  [searchBar resignFirstResponder];
}

@end
