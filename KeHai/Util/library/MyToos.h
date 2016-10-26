//
//  AppDelegate.h
//  KeHai
//
//  Created by 三海 on 16/10/22.
//  Copyright © 2016年 陈高健. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>
#import <CoreText/CoreText.h>


@interface MyToos : NSObject

#pragma mark- 得到颜色
+ (UIColor *)colorWithHexString: (NSString *)color;
#pragma mark- 获取导航栏颜色
+ (UIColor *)getThemeColor;
//
- (NSString *)getUserId;

@end
