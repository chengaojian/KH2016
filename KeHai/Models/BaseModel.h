//
//  BaseModel.h
//  KeHai
//
//  Created by 三海 on 16/10/26.
//  Copyright © 2016年 陈高健. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

- (id)initWithDic:(NSDictionary*)dic;//初始化方法

- (void)setValue:(id)value forUndefinedKey:(NSString *)key;//防崩

@end
