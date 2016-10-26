//
//  PictureModel.h
//  KeHai
//
//  Created by 三海 on 16/10/26.
//  Copyright © 2016年 陈高健. All rights reserved.
//

#import "BaseModel.h"

@interface PictureModel : BaseModel

// 图片地址
@property (nonatomic, copy) NSString *picUrl;
// 图片类型
@property (nonatomic, copy) NSString *picType;
// 图片描述
@property (nonatomic, copy) NSString *picDec;
// 图片Id
@property (nonatomic, copy) NSString *picId;

@end
