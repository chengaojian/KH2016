//
//  BaseModel.m
//  KeHai
//
//  Created by 三海 on 16/10/26.
//  Copyright © 2016年 陈高健. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if(self)
    {
        [self setValuesForKeysWithDictionary:dic];//kvc给这个类的属性赋值
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    //实现就行，防崩
    NSLog(@"%@缺少的key为%@",self,key);
}

@end
