//
//  CommonParams.h
//  KeHai
//
//  Created by 三海 on 16/10/26.
//  Copyright © 2016年 陈高健. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonParams : NSObject

// 发布环境 stu_release 等
@property (nonatomic, strong) NSString *appId;

// 设备token，由服务器端返回
@property (nonatomic, strong) NSString *token;

// 当前用户id
@property (nonatomic, strong) NSString *userId;

// 当前用户身份 -1：游客 0：老师 1：大学生 2：学生 3：机构 4：咨询师
@property (nonatomic, strong) NSString *userIdentity;

// 设备id，设备唯一标识
@property (nonatomic, strong) NSString *deviceId;

// app版本号
@property (nonatomic, strong) NSString *appVersion;

// 设备使用网络类型
@property (nonatomic, strong) NSString *netType;

// 单例
+(CommonParams *)sharedInstanceWithAppId:(NSString *)appId;

// 设置用户Token
-(void)setToken:(NSString *)token;

// 设置用户Id
-(void)setUserId:(NSString *)userId;

// 设置用户身份
-(void)setUserIdentity:(NSString *)userIdentity;

// 设置设备Id
-(void)setDeviceId:(NSString *)deviceId;

// 设置app版本
-(void)setAppVersion:(NSString *)appVersion;

@end
