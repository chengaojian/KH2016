//
//  ApiListModel.h
//  KeHai
//
//  Created by 三海 on 16/10/26.
//  Copyright © 2016年 陈高健. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApiListModel : NSObject

// api编码，唯一
@property (nonatomic, copy) NSString *apiCode;

// api的url
@property (nonatomic, copy) NSString *apiUrl;

// serviceName 服务名 bbsUrl
@property (nonatomic, copy) NSString *serviceName;

// apiDesc api备注
@property (nonatomic, copy) NSString *apiDesc;

@end
