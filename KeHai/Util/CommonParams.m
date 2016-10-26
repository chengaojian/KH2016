//
//  CommonParams.m
//  KeHai
//
//  Created by 三海 on 16/10/26.
//  Copyright © 2016年 陈高健. All rights reserved.
//

#import "CommonParams.h"
#import "PreferenceFileUtil.h"

@implementation CommonParams

+ (CommonParams *)sharedInstanceWithAppId:(NSString *)appId{
    static dispatch_once_t onceCommonParams;
    static CommonParams *_shareIntance;
    dispatch_once(&onceCommonParams, ^{
        _shareIntance = [[CommonParams alloc] initWithDefaultWithAppId:appId];
    });
    return _shareIntance;
}

- (instancetype)initWithDefaultWithAppId:(NSString *)appId{
    self = [super init];
    if (self) {
        self.appId = appId;
        self.token = [self getToken];
        self.userId = [self getUserId];
        self.userIdentity = [self getUserIdentity];
        self.deviceId = [self getDeviceId];
        self.appVersion = [self getAppVersion];
        self.netType = [self getNetType];
    }
    return self;
}

- (void)setAppId:(NSString *)appId{
    [[PreferenceFileUtil shareInstance] writeToUserInfo:appId withKey:@"appId"];
}

- (NSString *)getAppId{
    NSString *appId = [[PreferenceFileUtil shareInstance] getUserInfoForKey:@"appId"];
    return appId?appId:@"";
}

- (NSString *)getToken{
    NSString *token = [[PreferenceFileUtil shareInstance] getUserInfoForKey:@"token"];
    return token?token:@"";
}

- (NSString *)getUserId{
    NSString *userId = [[PreferenceFileUtil shareInstance] getUserInfoForKey:@"userId"];
    return userId?userId:@"";
}

- (NSString *)getUserIdentity{
    NSString *userIdentity = [[PreferenceFileUtil shareInstance] getUserInfoForKey:@"userIdentity"];
    return userIdentity?userIdentity:@"-1";
}

- (void)setDeviceId:(NSString *)deviceId{
    [[PreferenceFileUtil shareInstance] writeToUserInfo:deviceId withKey:@"deviceId"];
}

- (NSString *)getDeviceId{
    NSString *deviceId = [[UIDevice currentDevice].identifierForVendor UUIDString];
    return [deviceId stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

- (NSString *)getAppVersion{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

- (NSString *)getNetType{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *children = [[[app valueForKeyPath:@"statusBar"]valueForKeyPath:@"foregroundView"]subviews];
    NSString *state = @"3";
    
    int netType =0;
    //获取到网络返回码
    for (id childin in children) {
        if ([childin isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            //获取到状态栏
            netType = [[childin valueForKeyPath:@"dataNetworkType"] intValue];
            
            switch (netType) {
                case 0:
                    //无网
                    state = @"0";
                    break;
                case 1:
                    //2G
                    state = @"2";
                    break;
                case 2:
                    //3G
                    state = @"3";
                    break;
                case 3:
                    //4G
                    state = @"4";
                    break;
                case 5:
                    //WIFI
                    state = @"1";
                    break;
                case 6:
                    //5G
                    state = @"5";
                default:
                    break;
            }
        }
        
    }
    return state;
}

@end
