//
//  ComParams.h
//  KeHai
//
//  Created by 三海 on 16/10/26.
//  Copyright © 2016年 陈高健. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComParams : NSObject

/**
 *  按照默认值初始化
 *
 *  @return 初始化后的对象
 */
-(instancetype)initWithDefault;

/**
 * paramVersion
 */
@property (nonatomic, copy) NSString *paramVersion;

/**
 * dictVersion
 */
@property (nonatomic, copy) NSString *dictVersion;

/**
 * serviceVersion
 */
@property (nonatomic, copy) NSString *serviceVersion;

/**
 * apiVersion
 */
@property (nonatomic, copy) NSString *apiVersion;

/**
 * longitude
 */
@property (nonatomic, copy) NSString *longitude;

/**
 * latitude
 */
@property (nonatomic, copy) NSString *latitude;

/**
 * deviceModel
 */
@property (nonatomic, copy) NSString *deviceModel;

/**
 * os
 */
@property (nonatomic, copy) NSString *os;

/**
 * osVersion
 */
@property (nonatomic, copy) NSString *osVersion;

@end
