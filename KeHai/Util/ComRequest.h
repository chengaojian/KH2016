//
//  ComRequest.h
//  KeHai
//
//  Created by 三海 on 16/10/26.
//  Copyright © 2016年 陈高健. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Response.h"

@interface ComRequest : NSObject

/**
 * 主接口地址
 */
@property (nonatomic, copy) NSString *url;

/**
 * appId, 具体应用传过来的参数
 */
@property (nonatomic, copy) NSString *appId;

+(ComRequest *)shareInstanceWithUrl:(NSString *)url andAppId:(NSString *)appId;

typedef void(^HttpSuccessBlock)(Response *response);
typedef void(^HttpFailedBlock)(NSError *error);

/**
 *  调用主接口入口
 *
 */
-(void)httpComRequestGetSuccess:(HttpSuccessBlock) success
                         failed:(HttpFailedBlock) failure;

/**
 *  主接口方法2 通过urlsession调用
 *
 */
-(void)httpComSessionRequestPostSuccess:(HttpSuccessBlock)success
                                 failed:(HttpFailedBlock)failure;

@end
