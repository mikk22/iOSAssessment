//
//  SSProduct.h
//  IOSAssessment
//
//  Created by Mihail Koltsov on 15.07.15.
//  Copyright (c) 2015 SuiteSupply. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSProduct : NSObject

@property(nonatomic, strong) NSNumber* sku;
@property(nonatomic, copy) NSString* name;
@property(nonatomic, copy) NSString* thumbnailImage;
@property(nonatomic, strong) NSNumber* regularPrice;
//full
@property(nonatomic, copy) NSString* longDescription;
@property(nonatomic, strong) NSNumber* salePrice;
@property(nonatomic, strong) NSNumber* onSale;
@property(nonatomic, copy) NSString* largeImage;
@property(nonatomic, strong) NSNumber* customerReviewCount;
@property(nonatomic, strong) NSNumber* customerReviewAverage;
//related products
@property(nonatomic, copy) NSArray* accessories;
@property(nonatomic, copy) NSArray* relatedProducts;

@end
