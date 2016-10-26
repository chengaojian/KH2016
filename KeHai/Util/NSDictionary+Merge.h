//
//  NSDictionary+Merge.h
//  KeHai
//
//  Created by 三海 on 16/10/26.
//  Base on Tof Templates
//  Copyright © 2016年 陈高健. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark -
#pragma mark Category Merge for NSDictionary 
#pragma mark -

@interface NSDictionary (Merge)

/**
 *  @brief  合并两个NSDictionary
 *
 *  @param dict1 NSDictionary
 *  @param dict2 NSDictionary
 *
 *  @return 合并后的NSDictionary
 */
+ (NSDictionary *)dictionaryByMerging:(NSDictionary *)dict1 with:(NSDictionary *)dict2;

/**
 *  @brief  并入一个NSDictionary
 *
 *  @param dict NSDictionary
 *
 *  @return 增加后的NSDictionary
 */
- (NSDictionary *)dictionaryByMergingWith:(NSDictionary *)dict;

@end
