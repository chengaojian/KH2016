//
//  Response.h
//  KeHai
//
//  Created by 三海 on 16/10/26.
//  Copyright © 2016年 陈高健. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Response : NSObject

// 响应码
@property (nonatomic, copy) NSString *resCode;

// 响应信息
@property (nonatomic, copy) NSString *resMsg;

// 数据
@property (nonatomic, copy) NSDictionary *data;

// 系统时间
@property (nonatomic, copy) NSString *currTime;

@end
