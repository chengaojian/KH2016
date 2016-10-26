//
//  NetworkRequest.m
//  KeHai
//
//  Created by 三海 on 16/10/26.
//  Copyright © 2016年 陈高健. All rights reserved.
//

#import "NetworkRequest.h"
#import "AFNetWorking.h"
#import "MBProgressHUD.h"
#import "CommonParams.h"
#import "NSObject+Reflection.h"
#import "NSDictionary+Merge.h"
#import "PreferenceFileUtil.h"

@implementation NetworkRequest

// 管理对象
static AFHTTPSessionManager *manager = nil;
// 超时时长
static int TIMEOUTINTERVAL = 10;

+ (NetworkRequest *)sharedRequest{
    static NetworkRequest *_sharedRequest = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _sharedRequest = [[NetworkRequest alloc]init];
        manager = [AFHTTPSessionManager manager];
        manager.requestSerializer.timeoutInterval = TIMEOUTINTERVAL;
    });
    return _sharedRequest;
}

- (void)httpRequestWithApiCode:(NSString *)apiCode andDictParams:(NSDictionary *)dictParams andSuccess:(HttpSuccessBlock)success andFailure:(HttpFailureBlock)failure{
    
    NSString * requsetUrl = [self httpReplaceRequestPostWithApiCode:apiCode andReplaceDictParams:dictParams];
    
    [self judgeNetWorkWith:requsetUrl failed:failure];
    
    [manager POST:requsetUrl parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSDictionary *resultData = responseObject;
        Response *response = [[Response alloc]init];
        response.resCode = [resultData objectForKey:@"resCode"];
        response.resMsg = [resultData objectForKey:@"resMsg"];
        response.data = [resultData objectForKey:@"data"];
        response.currTime = [resultData objectForKey:@"currTime"];
        if (success) {
            success(response);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"http post request error : %@", error);
        if (error.code == -1001) {
            
        }else{
            
        }
        if (failure) {
            failure(error);
        }
    }];
}

/**
 根据apiCode接口代码,获取网络请求地址

 @param apiCode 接口编码
 @param params  参数

 @return 请求地址
 */
- (NSString *)httpReplaceRequestPostWithApiCode:(NSString *)apiCode andReplaceDictParams:(NSDictionary *)params{
    
    CommonParams *commonParams = [CommonParams sharedInstanceWithAppId: _appId];
    NSDictionary *commonDict = [commonParams propertyDictionary];
    
    PreferenceFileUtil *fileUtil = [PreferenceFileUtil shareInstance];
    ApiListModel * listModel = [fileUtil getApiForKey:apiCode];
    ServiceListModel * serviceModel = [fileUtil getServiceForKey:listModel.serviceName];
    
    NSDictionary *dict = [commonDict dictionaryByMergingWith:params];
    NSString * requsetUrl = @"";
    
    if ([listModel.apiUrl containsString:@"{"]) {
        NSString *replaceStr = [self replaceNsstring:listModel.apiUrl andDict:params];
        requsetUrl = [NSString stringWithFormat:@"%@%@",serviceModel.pVal,replaceStr];
    }else {
        requsetUrl = serviceModel.pVal;
        requsetUrl = [requsetUrl stringByAppendingString:listModel.apiUrl];
    }
    requsetUrl = [NSString stringWithFormat:@"%@?%@",requsetUrl,[self dictToUrlString:dict]];
    requsetUrl = [requsetUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"http post request : %@", requsetUrl);
    
    return requsetUrl;
    
}

/**
 *  根据字典替换字符串{}之间的内容
 *
 *  @param string string
 *  @param dict   dict
 *
 *  @return 替换后的字符串
 */
- (NSString *)replaceNsstring:(NSString *)string andDict:(NSDictionary *)dict{
    
    NSArray * array = [string componentsSeparatedByString:@"/"];
    NSMutableString * urlString = [NSMutableString string];
    NSInteger index = 0;
    
    for (NSString * str in array) {
        
        if (str.length>0 && [[str substringToIndex:1] isEqualToString:@"{"]) {
            
            NSRange range = [str rangeOfString:@"}"];
            NSMutableString * muString = [NSMutableString stringWithString:str];
            NSString * subString = [muString substringWithRange:NSMakeRange(1, range.location-range.length)];
            muString = (NSMutableString *) [muString stringByReplacingOccurrencesOfString:subString withString:[dict objectForKey:subString]];
            
            NSString * finalStr = [muString substringWithRange:NSMakeRange(1, muString.length-1)];
            NSArray * finalArray = [finalStr componentsSeparatedByString:@"}"];
            finalStr = [finalArray componentsJoinedByString:@""];
            if (index == array.count-1) {
                [urlString appendFormat:@"%@",finalStr];
            }else{
                [urlString appendFormat:@"%@/",finalStr];
            }
            
            index++;
        }else{
            [urlString appendFormat:@"%@/",str];
            index++;
        }
    }
    //判断请求地址最后一个字符是否为@"/"是则删除,不是则直接返回
    if([urlString hasSuffix:@"/"]){
        return [urlString substringWithRange:NSMakeRange(0, urlString.length-1)];
    }
    return urlString;
}

/**
 *  字典转字符串
 *
 *  @param dict dict
 *
 *  @return 字符串
 */
- (NSString *)dictToUrlString:(NSDictionary *)dict{
    NSMutableString *str = [NSMutableString string];
    for (NSString *key in dict) {
        [str appendFormat:@"%@=%@&", key, [dict objectForKey:key]];
    }
    return str;
}

/**
 *  根据url 判断网络状况
 *
 *  @param requestUrl 请求url
 */
- (void)judgeNetWorkWith:(NSString *)requestUrl failed:(HttpFailureBlock)failure{
    BOOL net=[self isConnectionAvailable];
    if(net == NO){

        if (failure) {
            failure(nil);
        }
        return;
    }
    
    BOOL isHttp = [self isHttpUrlNSPredicate:requestUrl];
    if (isHttp == NO) {

        if (failure) {
            failure(nil);
        }
        return;
    }
}

//判断是不是有网
- (BOOL) isConnectionAvailable{
    
    BOOL isExistenceNetwork = YES;
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *children = [[[app valueForKeyPath:@"statusBar"]valueForKeyPath:@"foregroundView"]subviews];
    int netType =0;
    //获取到网络返回码
    for (id childin in children) {
        if ([childin isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            //获取到状态栏
            netType = [[childin valueForKeyPath:@"dataNetworkType"]intValue];
        }
    }
    
    if(netType==0){
        isExistenceNetwork = NO;
    }
    
    return isExistenceNetwork;
}

/**
 *  判断URL的格式
 *
 *  @param httpUrl httpUrl
 *
 *  @return BOOL
 */
- (BOOL)isHttpUrlNSPredicate:(NSString *)httpUrl{
    if ([httpUrl containsString:@"(null)"]) {
        return NO;
    }
    NSString * urlPredicate = @"^(http://|https://)?((?:[A-Za-z0-9]+-[A-Za-z0-9]+|[A-Za-z0-9]+).)+([A-Za-z]+)[/\?:]?.*$";
    NSPredicate *httpUrlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlPredicate];
    return [httpUrlTest evaluateWithObject:httpUrl];
}

- (void)httpSessionRequestPostWithUrl:(NSString *)urlString
                        andDictParams:(NSDictionary *)params
                              Success:(HttpSuccessBlock)success
                               failed:(HttpFailureBlock)failure {
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    request.HTTPMethod = @"POST";
    
    NSData *parametersData;
    if ([params.allKeys count]>0) {
        NSMutableString *parameterString = [NSMutableString string];
        for (NSString *key in params.allKeys) {
            [parameterString appendFormat:@"%@=%@&",key,params[key]];
        }
        
        NSLog(@"post url =======:%@?%@",urlString,parameterString);
        
        parametersData = [[parameterString substringToIndex:parameterString.length-1] dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    
    request.HTTPBody = parametersData;
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (failure) {
                    failure(error);
                }
            });
            
        }else {
            NSDictionary * resultData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            if (error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (failure) {
                        failure(error);
                    }
                });
            }else {
                Response *response = [[Response alloc] init];
                response.resCode = [resultData objectForKey:@"resCode"];
                response.resMsg = [resultData objectForKey:@"resMsg"];
                response.data = [resultData objectForKey:@"data"];
                response.currTime = [resultData objectForKey:@"currTime"];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (success) {
                        success(response);
                    }
                });
            }
        }
    }];
    [task resume];
}

@end
