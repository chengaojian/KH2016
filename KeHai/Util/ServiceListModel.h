//
//  ServiceListModel.h
//  KeHai
//
//  Created by 三海 on 16/10/26.
//  Copyright © 2016年 陈高健. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceListModel : NSObject

// 服务key
@property (nonatomic, copy) NSString *pKey;

// 服务value
@property (nonatomic, copy) NSString *pVal;

// 服务备注
@property (nonatomic, copy) NSString *des;

@end
