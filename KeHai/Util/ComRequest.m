//
//  ComRequest.m
//  KeHai
//
//  Created by 三海 on 16/10/26.
//  Copyright © 2016年 陈高健. All rights reserved.
//

#import "ComRequest.h"
#import "CommonParams.h"
#import "ComParams.h"
#import "AFNetworking.h"
#import "NSDictionary+Merge.h"
#import "NSObject+Reflection.h"
#import "PreferenceFileUtil.h"
#import "AFURLRequestSerialization.h"
#import "NetworkRequest.h"

@implementation ComRequest

+(ComRequest *)shareInstanceWithUrl:(NSString *)url andAppId:(NSString *)appId{
    static ComRequest *_shareComRequest = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _shareComRequest = [[ComRequest alloc] initWithComUrl:url andAppId:appId];
    });
    return _shareComRequest;
}

-(instancetype)initWithComUrl:(NSString *)url andAppId:(NSString *)appId{
    self = [super init];
    if (self) {
        self.url = url;
        self.appId = appId;
    }
    return self;
}

-(void)httpComRequestGetSuccess:(HttpSuccessBlock)success
                         failed:(HttpFailedBlock)failure{
    
    
    CommonParams *commonParams = [CommonParams sharedInstanceWithAppId:self.appId];
    ComParams *comParams = [[ComParams alloc] initWithDefault];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *commonDict = [commonParams propertyDictionary];
    NSDictionary *comDict = [comParams propertyDictionary];
    NSDictionary *dict = [commonDict dictionaryByMergingWith:comDict];
    
    
    
    
    NSString *urlStr = [self.url stringByAppendingString:[self dictToUrlString:dict]];
    NSLog(@"comUrl : %@",urlStr);
    
    
    [manager GET:self.url parameters:dict
         success:^(NSURLSessionTask *task, id responseObject) {
             NSDictionary *resultData = responseObject;
             Response *response = [[Response alloc]init];
             response.resCode = [resultData objectForKey:@"resCode"];
             response.resMsg = [resultData objectForKey:@"resMsg"];
             response.data = [resultData objectForKey:@"data"];
             if ([response.resCode isEqualToString:@"000"] || [response.resCode isEqualToString:@"200"]) {
                 NSArray *paramList = [response.data objectForKey:@"paramList"];
                 if (paramList.count > 0) {
                     [[PreferenceFileUtil shareInstance] writeToParamList:paramList];
                 }
                 NSArray *dictList = [response.data objectForKey:@"dictList"];
                 if (dictList.count > 0) {
                     [[PreferenceFileUtil shareInstance] writeToDictList:dictList];
                 }
                 NSArray *serviceList = [response.data objectForKey:@"serviceList"];
                 if (serviceList.count > 0) {
                     [[PreferenceFileUtil shareInstance] writeToServiceListWithArray:serviceList];
                 }
                 NSArray *apiList = [response.data objectForKey:@"apiList"];
                 if (apiList.count > 0) {
                     [[PreferenceFileUtil shareInstance] writeToApiListWithArray:apiList];
                 }
                 
                 NSArray *removeArray = [NSArray arrayWithObjects:@"paramList",@"dictList",@"serviceList",@"apiList", nil];
                 NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithDictionary:response.data];
                 [paramDict removeObjectsForKeys:removeArray];
                 // 游客身份 userId 单独保存
                 if([[paramDict objectForKey:@"userIdentity"] isEqualToString:@"-1"]){
                     // 游客userId加入配置文件
                     [paramDict setObject:[paramDict objectForKey:@"userId"] forKey:@"touristsUserId"];
                 }
                 [[PreferenceFileUtil shareInstance] writeToUserInfoWithDict:paramDict];
             }
             if (success) {
                 success(response);
             }
         }failure:^(NSURLSessionTask *operation, NSError *error){
             NSLog(@"com request error: %@",error);
             if (error.code == -1001) {
                 NSLog(@"请求超时!");
             }
             if (failure) {
                 failure(error);
             }
         }];
}


/**
 *  通过nsurlSession 访问主接口
 *
 *  @param success
 *  @param failure 
 */
-(void)httpComSessionRequestPostSuccess:(HttpSuccessBlock)success
                                 failed:(HttpFailedBlock)failure{
    
    CommonParams *commonParams = [CommonParams sharedInstanceWithAppId:self.appId];
    ComParams *comParams = [[ComParams alloc] initWithDefault];
    
    NSDictionary *commonDict = [commonParams propertyDictionary];
    NSDictionary *comDict = [comParams propertyDictionary];
    NSDictionary *dict = [commonDict dictionaryByMergingWith:comDict];
    
    [[NetworkRequest sharedRequest] httpSessionRequestPostWithUrl:self.url andDictParams:dict Success:^(Response *response) {
        if ([response.resCode isEqualToString:@"000"] || [response.resCode isEqualToString:@"200"]) {
            NSArray *paramList = [response.data objectForKey:@"paramList"];
            if (paramList.count > 0) {
                [[PreferenceFileUtil shareInstance] writeToParamList:paramList];
            }
            NSArray *dictList = [response.data objectForKey:@"dictList"];
            if (dictList.count > 0) {
                [[PreferenceFileUtil shareInstance] writeToDictList:dictList];
            }
            NSArray *serviceList = [response.data objectForKey:@"serviceList"];
            if (serviceList.count > 0) {
                [[PreferenceFileUtil shareInstance] writeToServiceListWithArray:serviceList];
            }
            NSArray *apiList = [response.data objectForKey:@"apiList"];
            if (apiList.count > 0) {
                [[PreferenceFileUtil shareInstance] writeToApiListWithArray:apiList];
            }
            
            NSArray *removeArray = [NSArray arrayWithObjects:@"paramList",@"dictList",@"serviceList",@"apiList", nil];
            NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithDictionary:response.data];
            [paramDict removeObjectsForKeys:removeArray];
            // 游客身份 userId 单独保存
            if([[paramDict objectForKey:@"userIdentity"] isEqualToString:@"-1"]){
                // 游客userId加入配置文件
                [paramDict setObject:[paramDict objectForKey:@"userId"] forKey:@"touristsUserId"];
            }
            [[PreferenceFileUtil shareInstance] writeToUserInfoWithDict:paramDict];
        }
        if (success) {
            success(response);
        }
    } failed:^(NSError *error) {
        if (error.code == -1001) {
            NSLog(@"请求超时!");
        }
        if (failure) {
            failure(error);
        }
    }];

}


-(NSString *)dictToUrlString:(NSDictionary *)dict{
    NSMutableString *str = [NSMutableString string];
    for (NSString *key in dict) {
        [str appendFormat:@"%@=%@&", key, [dict objectForKey:key]];
    }
    return str;
}

@end
