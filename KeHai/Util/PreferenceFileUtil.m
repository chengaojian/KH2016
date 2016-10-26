//
//  PreferenceFileUtil.m
//  KeHai
//
//  Created by 三海 on 16/10/26.
//  Copyright © 2016年 陈高健. All rights reserved.
//

#import "PreferenceFileUtil.h"
#import "NSDictionary+Merge.h"
#import "NSObject+Reflection.h"

@implementation PreferenceFileUtil

/**
 *  单例中用到对象
 */
static PreferenceFileUtil *_shPreferenceFileUtil;

/**
 *  document目录路径
 */
static NSString *_documentPath;

+ (PreferenceFileUtil *)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shPreferenceFileUtil = [[PreferenceFileUtil alloc] init];
        _documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    });
    return _shPreferenceFileUtil;
}

/**
 *  获取SHParamList.plist中配置
 *
 *  @return SHParamList
 */
- (NSArray *)getContentsOfParamList{
    NSString *paramListFilePath = [_documentPath stringByAppendingPathComponent:@"SHParamList.plist"];
    return [NSArray arrayWithContentsOfFile:paramListFilePath];
}

/**
 *  获取SHServiceList.plist中配置
 *
 *  @return SHServiceList
 */
- (NSArray *)getContentsOfServiceList{
    NSString *serviceListFilePath = [_documentPath stringByAppendingPathComponent:@"SHServiceList.plist"];
    return [NSArray arrayWithContentsOfFile:serviceListFilePath];
}

/**
 *  获取SHApiList.plist中配置
 *
 *  @return SHApiList
 */
- (NSArray *)getContentsOfApiList{
    NSString *apiListFilePath = [_documentPath stringByAppendingPathComponent:@"SHApiList.plist"];
    return [NSArray arrayWithContentsOfFile:apiListFilePath];
}

/**
 *  获取SHDictList.plist中配置
 *
 *  @return SHDictList
 */
- (NSArray *)getContentsOfDictList{
    NSString *dictListFilePath = [_documentPath stringByAppendingPathComponent:@"SHDictList.plist"];
    return [NSArray arrayWithContentsOfFile:dictListFilePath];
}

/**
 *  获取SHUserInfo.plist中配置
 *
 *  @return SHUserInfo 字典
 */
- (NSDictionary *)getContentsOfUserInfo{
    NSString *userInfoFilePath = [_documentPath stringByAppendingPathComponent:@"SHUserInfo.plist"];
    return [NSDictionary dictionaryWithContentsOfFile:userInfoFilePath];
}
/**
 *  根据key,获取SHUserInfo.plist中配置
 *
 *  @return获取到的信息
 */
- (id)getUserInfoForKey:(NSString *)key{
    return [[self getContentsOfUserInfo] objectForKey:key];
}

- (NSString *)getUserId{
    if ([[[self getContentsOfUserInfo] objectForKey:@"userIdentity"] isEqualToString:@"-1"]) {
        return [[self getContentsOfUserInfo] objectForKey:@"touristsUserId"];
    }
    return [[self getContentsOfUserInfo] objectForKey:@"userId"];
}

/**
 *  根据key获取字典值
 * SHDictList
 *  @return 字典值
 */
- (NSString *)getDictValForKey:(NSString *)key{
    NSArray *array = [self getContentsOfDictList];
    for (NSDictionary *dict in array) {
        if ([[dict objectForKey:@"dictCode"] isEqualToString:key]) {
            return [dict objectForKey:@"dictVal"];
        }
    }
    return nil;
}

/**
 *  根据pKey获取参数值
 *  SHParamList中数据
 *  @return 参数值
 */
- (NSString *)getParamValForKey:(NSString *)key{
    NSArray *array = [self getContentsOfParamList];
    for (NSDictionary *dict in array) {
        if ([[dict objectForKey:@"pKey"] isEqualToString:key]) {
            return [dict objectForKey:@"pVal"];
        }
    }
    return nil;
}

/**
 *  根据key获取service对象
 *  SHServiceList
 *  @return SHServiceListModel
 */
- (ServiceListModel *)getServiceForKey:(NSString *)key{
    NSArray *array = [self getContentsOfServiceList];
    for (NSDictionary *dict in array) {
        if ([[dict objectForKey:@"pKey"] isEqualToString:key]) {
            ServiceListModel *serviceModel = [[ServiceListModel alloc] init];
            serviceModel.pKey = [dict objectForKey:@"pKey"];
            serviceModel.pVal = [dict objectForKey:@"pVal"];
            serviceModel.des = [dict objectForKey:@"des"];
            return serviceModel;
        }
    }
    return nil;
}

/**
 *  根据key获取api对象
 *  SHApiList
 *  @return SHApiListModel
 */
- (ApiListModel *)getApiForKey:(NSString *)key{
    NSArray *array = [self getContentsOfApiList];
    for (NSDictionary *dict in array) {
        if ([[dict objectForKey:@"apiCode"] isEqualToString:key]) {
            ApiListModel *apiModel = [[ApiListModel alloc] init];
            apiModel.apiCode = [dict objectForKey:@"apiCode"];
            apiModel.apiUrl = [dict objectForKey:@"apiUrl"];
            apiModel.serviceName = [dict objectForKey:@"serviceName"];
            apiModel.apiDesc = [dict objectForKey:@"apiDesc"];
            return apiModel;
        }
    }
    return nil;
}

/**
 *  写入参数配置文件
 *  增量写入
 *  @param key 键
 *  @param val 值
 */
-(void)writeToParamList:(NSString *)key andVal:(NSString *)val{
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    NSArray *array = [self getContentsOfParamList];
    BOOL isExistForDict = NO;
    for (NSDictionary *dict in array) {
        if ([[dict objectForKey:@"pKey"] isEqualToString:key]) {
            [dict setValue:val forKey:@"pVal"];
            isExistForDict = TRUE;
        }
        [mArray addObject:dict];
    }
    if (!isExistForDict) {
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:key, @"pKey", val, @"pVal", nil];
        [mArray addObject:dict];
    }
    NSString *paramListFilePath = [_documentPath stringByAppendingPathComponent:@"SHParamList.plist"];
    [mArray writeToFile:paramListFilePath atomically:YES];
}

/**
 *  写入参数配置文件
 *  增量写入
 *  @param array 参数列表
 */
- (void)writeToParamList:(NSArray *)array{
    NSString *paramListFilePath = [_documentPath stringByAppendingPathComponent:@"SHParamList.plist"];
    NSArray *localArray = [self getContentsOfParamList];
    // TODO: pkey -> pKey
    NSArray *saveArray = [self arrayMerge:localArray toArray:array withKey:@"pKey"];
    [saveArray writeToFile:paramListFilePath atomically:YES];
}

/**
 *  写入服务配置文件
 *  增量写入
 *  @param serviceModel 服务对象
 */
- (void)writeToServiceList:(ServiceListModel *)serviceModel{
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    NSArray *array = [self getContentsOfServiceList];
    BOOL isExistForDict = NO;
    for (NSDictionary *dict in array) {
        if ([[dict objectForKey:@"pKey"] isEqualToString:[serviceModel pKey]]) {
            [dict setValue:[serviceModel pVal] forKey:@"pVal"];
            [dict setValue:[serviceModel des] forKey:@"des"];
            isExistForDict = TRUE;
        }
        [mArray addObject:dict];
    }
    if (!isExistForDict) {
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[serviceModel pKey], @"pKey", [serviceModel pVal], @"pVal", [serviceModel des], @"des", nil];
        [mArray addObject:dict];
    }
    NSString *serviceListFilePath = [_documentPath stringByAppendingPathComponent:@"SHServiceList.plist"];
    [mArray writeToFile:serviceListFilePath atomically:YES];
}

/**
 *  写入服务配置文件
 *  增量写入
 *
 */
- (void)writeToServiceListWithArray:(NSArray *)serviceList{
    NSString *serviceListFilePath = [_documentPath stringByAppendingPathComponent:@"SHServiceList.plist"];
    NSArray *localArray = [self getContentsOfServiceList];
    NSArray *saveArray = [self arrayMerge:localArray toArray:serviceList withKey:@"pKey"];
    [saveArray writeToFile:serviceListFilePath atomically:YES];
}

/**
 *  写入字典配置文件
 *  增量写入
 *  @param dictCode 键
 *  @param dictVal 值
 */
- (void)writeToDictList:(NSString *)dictCode andVal:(NSString *)dictVal{
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    NSArray *array = [self getContentsOfDictList];
    BOOL isExistForDict = NO;
    for (NSDictionary *dict in array) {
        if ([[dict objectForKey:@"dictCode"] isEqualToString:dictCode]) {
            [dict setValue:dictVal forKey:@"dictVal"];
            isExistForDict = YES;
        }
        [mArray addObject:dict];
    }
    if (!isExistForDict) {
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:dictCode, @"dictCode", dictVal, @"dictVal", nil];
        [mArray addObject:dict];
    }
    NSString *dictListFilePath = [_documentPath stringByAppendingPathComponent:@"SHDictList.plist"];
    [mArray writeToFile:dictListFilePath atomically:YES];
}

/**
 *  写入字典配置文件
 *  增量写入
 *  @param array 字典列表
 */
- (void)writeToDictList:(NSArray *)array{
    NSString *dictListFilePath = [_documentPath stringByAppendingPathComponent:@"SHDictList.plist"];
    NSArray *localArray = [self getContentsOfDictList];
    NSArray *saveArray = [self arrayMerge:localArray toArray:array withKey:@"dictCode"];
    [saveArray writeToFile:dictListFilePath atomically:YES];
}

/**
 *  写入api配置文件
 *  增量写入
 *  @param apiModel api对象
 */
- (void)writeToApiList:(ApiListModel *)apiModel{
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    NSArray *array = [self getContentsOfApiList];
    BOOL isExistForDict = NO;
    for (NSDictionary *dict in array) {
        if ([[dict objectForKey:@"apiCode"] isEqualToString:[apiModel apiCode]]) {
            [dict setValue:[apiModel apiUrl] forKey:@"apiUrl"];
            [dict setValue:[apiModel serviceName] forKey:@"serviceName"];
            [dict setValue:[apiModel apiDesc] forKey:@"apiDesc"];
            isExistForDict = YES;
        }
        [mArray addObject:dict];
    }
    if (!isExistForDict) {
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[apiModel apiCode], @"apiCode", [apiModel apiUrl] ,@"apiUrl", [apiModel serviceName], @"serviceName", [apiModel apiDesc], @"apiDesc", nil];
        [mArray addObject:dict];
    }
    NSString *apiListFilePath = [_documentPath stringByAppendingPathComponent:@"SHApiList.plist"];
    [array writeToFile:apiListFilePath atomically:YES];
}

/**
 *  写入api配置文件
 *  增量写入
 *  @param apiList api列表
 */
- (void)writeToApiListWithArray:(NSArray *)apiList{
    NSString *apiListFilePath = [_documentPath stringByAppendingPathComponent:@"SHApiList.plist"];
    NSArray *localArray = [self getContentsOfApiList];
    NSArray *saveArray = [self arrayMerge:localArray toArray:apiList withKey:@"apiCode"];
    [saveArray writeToFile:apiListFilePath atomically:YES];
}

/**
 *  写入用户信息
 *
 *  @param val 用户信息
 *  @param key      键
 */
- (void)writeToUserInfo:(id)val withKey:(NSString *)key{
    NSString *userInfoFilePath = [_documentPath stringByAppendingPathComponent:@"SHUserInfo.plist"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[self getContentsOfUserInfo]];
    [dict setValue:val forKey:key];
    [dict writeToFile:userInfoFilePath atomically:YES];
}

/**
 *  写入用户数据
 *  覆盖更新已有数据
 *  
 */
- (void)writeToUserInfoWithDict:(NSDictionary *)dict{
    NSString *userInfoFilePath = [_documentPath stringByAppendingPathComponent:@"SHUserInfo.plist"];
    NSMutableDictionary *localUserDict = [NSMutableDictionary dictionaryWithDictionary:[self getContentsOfUserInfo]];
    // dict 和 localUserDict有冲突时, 以dict为准. 增量存储
    NSDictionary *saveDict = [localUserDict dictionaryByMergingWith:dict];
    [saveDict writeToFile:userInfoFilePath atomically:YES];
}

/**
 *  将SHUserInfo.plist中部分值设为空
 */
- (void)clearUserInfo{
    NSString *userInfoFilePath = [_documentPath stringByAppendingPathComponent:@"SHUserInfo.plist"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[self getContentsOfUserInfo]];
    [dict setObject:@"" forKey:@"account"];
    [dict setObject:@"" forKey:@"accountId"];
    [dict setObject:@"" forKey:@"codeName"];
    [dict setObject:@"" forKey:@"codeNum"];
    [dict setObject:@"" forKey:@"disabled"];
    [dict setObject:@"" forKey:@"nickname"];
    [dict setObject:@"" forKey:@"orgId"];
    [dict setObject:@"" forKey:@"ppResId"];
    [dict setObject:@"" forKey:@"pullPwd"];
    [dict setObject:@"" forKey:@"pullUser"];
    [dict setObject:@"" forKey:@"token"];
    [dict setObject:@"" forKey:@"trueName"];
    //    [dict setObject:@"" forKey:@"userId"];
    [dict setObject:@"-1" forKey:@"userIdentity"];
    [dict writeToFile:userInfoFilePath atomically:YES];
}

/**
 *  合并两个array 以第二个为准. array中支持 实体类 和 字典
 *
 *  @param array1 第一个array
 *  @param array2 第二个array
 *  @param key    两个array去重的key
 *
 *  @return 返回合并后的array
 */
- (NSArray *)arrayMerge:(NSArray *)array1 toArray:(NSArray *)array2 withKey:(NSString *)key{
    NSMutableArray *rtnArray = [NSMutableArray array];
    NSMutableDictionary *storageDict = [NSMutableDictionary dictionary];
    for (NSObject *value in array1) {
        NSDictionary *dict;
        if ([value isKindOfClass:[NSDictionary class]]) {
            dict = (NSDictionary *)value;
        } else{
            dict = [value propertyDictionary];
        }
        [storageDict setObject:dict forKey:[dict objectForKey:key]];
    }
    for (NSObject *value in array2) {
        NSDictionary *dict;
        if ([value isKindOfClass:[NSDictionary class]]) {
            dict = (NSDictionary *)value;
        } else{
            dict = [value propertyDictionary];
        }
        [storageDict setObject:dict forKey:[dict objectForKey:key]];
    }
    for (NSString *skey in storageDict) {
        [rtnArray addObject:[storageDict objectForKey:skey]];
    }
    return rtnArray;
}

@end
