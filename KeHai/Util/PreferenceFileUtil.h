//
//  PreferenceFileUtil.h
//  KeHai
//
//  Created by 三海 on 16/10/26.
//  Copyright © 2016年 陈高健. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceListModel.h"
#import "ApiListModel.h"

@interface PreferenceFileUtil : NSObject

// 单例
+(PreferenceFileUtil *)shareInstance;

// 获取用户信息
- (NSDictionary *)getContentsOfUserInfo;

// 获取SHDictList.plist中配置
- (NSArray *)getContentsOfDictList;

// 获取SHApiList.plist中配置
- (NSArray *)getContentsOfApiList;

// 获取SHParamList.plist中配置
- (NSArray *)getContentsOfParamList;

// 获取SHServiceList.plist中配置
- (NSArray *)getContentsOfServiceList;

// 根据key,获取SHUserInfo.plist中配置
- (id)getUserInfoForKey:(NSString *)key;

// 获取userId
- (NSString *)getUserId;

// 根据key获取ParamList中的数据
- (NSString *)getParamValForKey:(NSString *)key;

// 根据key获取DictList中的数据
- (NSString *)getDictValForKey:(NSString *)key;

// 根据key获取ServiceList中的数据
- (ServiceListModel *)getServiceForKey:(NSString *)key;

// 根据key获取ApiList中的数据
- (ApiListModel *)getApiForKey:(NSString *)key;

// 写入数据到字典中到ParamList
- (void)writeToParamList:(NSString *)key andVal:(NSString *)val;

// 写入数据到字典中到ParamList
- (void)writeToParamList:(NSArray *)array;

// 写入数据到字典中到DictList
- (void)writeToDictList:(NSString *)dictCode andVal:(NSString *)dictVal;

// 写入数据到字典中到DictList
- (void)writeToDictList:(NSArray *)array;

// 写入服务配置文件到ServiceList
- (void)writeToServiceList:(ServiceListModel *)serviceModel;

// 写入服务配置文件到ServiceList
- (void)writeToServiceListWithArray:(NSArray *)serviceList;

// 写入api配置文件到ApiList
- (void)writeToApiList:(ApiListModel *)apiModel;

// 写入api配置文件到ApiList
- (void)writeToApiListWithArray:(NSArray *)apiList;

// 写入用户信息到UserInfo
- (void)writeToUserInfo:(id)val withKey:(NSString *)key;

// 写入用户信息到UserInfo
- (void)writeToUserInfoWithDict:(NSDictionary *)dict;

// 将SHUserInfo.plist中部分值设为空
- (void)clearUserInfo;

// 合并数组中的数据到一个数组中
- (NSArray *)arrayMerge:(NSArray *)array1 toArray:(NSArray *)array2 withKey:(NSString *)key;

@end
