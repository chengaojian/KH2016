//
//  NetworkRequest.h
//  KeHai
//
//  Created by 三海 on 16/10/26.
//  Copyright © 2016年 陈高健. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Response.h"

@interface NetworkRequest : NSObject

typedef void (^HttpSuccessBlock)(Response *response);
typedef void (^HttpFailureBlock)(NSError *error);

// app网络环境
@property (nonatomic, copy) NSString *appId;

/**
 创建网络请求代码单例

 @return 网络请求单例
 */
+ (NetworkRequest *)sharedRequest;

/**
 通用网络请求 -- Post

 @param apiCode    Api编码(接口)
 @param dictParams 参数
 @param success    成功后回调
 @param failure     失败后回调
 */
- (void)httpRequestWithApiCode:(NSString *)apiCode andDictParams:(NSDictionary *)dictParams andSuccess:(HttpSuccessBlock)success andFailure:(HttpFailureBlock)failure;

/**
 *  NSURLSession 封装的Post请求网络请求
 *
 *  @param url     请求地址
 *  @param params  参数
 *  @param success 成功后回调
 *  @param failure 失败后回调
 */
- (void)httpSessionRequestPostWithUrl:(NSString *)url andDictParams:(NSDictionary *)params Success:(HttpSuccessBlock)success failed:(HttpFailureBlock)failure;

@end
