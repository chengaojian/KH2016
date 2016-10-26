//
//  ComParams.m
//  KeHai
//
//  Created by 三海 on 16/10/26.
//  Copyright © 2016年 陈高健. All rights reserved.
//

#import "ComParams.h"
#import "PreferenceFileUtil.h"
#import "UIDevice+Hardware.h"

@implementation ComParams

-(instancetype)initWithDefault{
    self = [super init];
    if (self) {
        self.paramVersion = [self getParamVersion];
        self.serviceVersion = [self getServiceVersion];
        self.dictVersion = [self getDictVersion];
        self.apiVersion = [self getDictVersion];
        self.longitude = [self getLongitude];
        self.deviceModel = [self getDeviceModel];
        self.os = @"1";
        self.osVersion = [self getOSVersion];
    }
    return self;
}

- (NSString *)getParamVersion{
    NSString *paramVersion = [[PreferenceFileUtil shareInstance] getUserInfoForKey:@"paramVersion"];
    return paramVersion?paramVersion:@"0";
}

- (NSString *)getServiceVersion{
    NSString *serviceVersion = [[PreferenceFileUtil shareInstance] getUserInfoForKey:@"serviceVersion"];
    return serviceVersion?serviceVersion:@"0";
}

- (NSString *)getApiVersion{
    NSString *apiVersion = [[PreferenceFileUtil shareInstance] getUserInfoForKey:@"apiVersion"];
    return apiVersion?apiVersion:@"0";
}

- (NSString *)getDictVersion{
    NSString *dictVersion = [[PreferenceFileUtil shareInstance] getUserInfoForKey:@"dictVersion"];
    return dictVersion?dictVersion:@"0";
}

- (NSString *)getLongitude{
    NSString *longitude = [[PreferenceFileUtil shareInstance] getUserInfoForKey:@"longitude"];
    return longitude?longitude:@"-1";
}

- (NSString *)getLatitude{
    NSString *latitude = [[PreferenceFileUtil shareInstance] getUserInfoForKey:@"latitude"];
    return latitude?latitude:@"-1";
}

- (NSString *)getDeviceModel{
    NSString *deviceModel = [[UIDevice currentDevice] hardwareSimpleDescription];
    return deviceModel;
}

- (NSString *)getOSVersion{
    NSString *osVersion = [[UIDevice currentDevice] systemVersion];
    return osVersion;
}

@end
