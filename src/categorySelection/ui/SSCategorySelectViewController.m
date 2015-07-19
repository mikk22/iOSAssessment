//
//  SSNewCategorySelectViewController.m
//  IOSAssessment
//
//  Created by user on 20.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import "SSCategorySelectViewController.h"
#import "SSObjectsListViewController_Protected.h"

#import "SSCategoriesLoadingActions.h"
#import "SSCategory.h"
#import "SSCategoryCell.h"

static NSString* const kSSCategoryCellIdentifier = @"SSCategoryCellIdentifier";

@implementation SSCategorySelectViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
  self = [super initWithStyle:style];
  if (self) {
    self.navigationItem.title = @"Select Category";
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupNavigationBarItems];
}

- (void)setupTableView {
  [super setupTableView];
  [self.tableView registerClass:[SSCategoryCell class]
         forCellReuseIdentifier:kSSCategoryCellIdentifier];
}

- (id<SSObjectsListLoadingActions>)loadingActions {
  return [[SSCategoriesLoadingActions alloc] init];
}

- (void)setupNavigationBarItems {
  UIBarButtonItem* doneButtonItem =
      [[UIBarButtonItem alloc] initWithTitle:@"done"
                                       style:UIBarButtonItemStyleDone
                                      target:self
                                      action:@selector(doneButtonTouch:)];
  self.navigationItem.rightBarButtonItem = doneButtonItem;
  
  SEL categoryResetButtonTouchSel = @selector(categoryResetButtonTouch:);
  UIBarButtonItem* categoryResetItem =
      [[UIBarButtonItem alloc] initWithTitle:@"reset"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:categoryResetButtonTouchSel];
  self.navigationItem.leftBarButtonItem = categoryResetItem;
}

- (void)categoryResetButtonTouch:(id)sender {
  [self.delegate categorySelectViewController:self didSelectCategory:nil];
  [self.tableView reloadData];
}

- (void)doneButtonTouch:(id)sender {
  [self dismissViewControllerAnimated:YES completion:NULL];
}

- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath {
  SSCategoryCell *cell = (SSCategoryCell*)[tableView
      dequeueReusableCellWithIdentifier:kSSCategoryCellIdentifier
                           forIndexPath:indexPath];
  NSArray* objects = self.dataLoader.objects;
  NSParameterAssert(objects.count > indexPath.row);
  SSCategory* category = objects[indexPath.row];
  NSParameterAssert([category isKindOfClass:[SSCategory class]]);
  [cell setCategory:category];
  if ([category isEqual:[self.delegate selectedCategoryForCategorySelectViewController:self]]) {
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
  } else {
    cell.accessoryType = UITableViewCellAccessoryNone;
  }

  return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView*)tableView
    didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
  SSCategory* category = self.dataLoader.objects[indexPath.row];
  [self.delegate categorySelectViewController:self didSelectCategory:category];
  [self.tableView reloadRowsAtIndexPaths:@[ indexPath ]
                        withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
