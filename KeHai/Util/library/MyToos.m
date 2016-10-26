//
//  AppDelegate.m
//  KeHai
//
//  Created by 三海 on 16/10/22.
//  Copyright © 2016年 陈高健. All rights reserved.
//


#import "MyToos.h"
#import <CommonCrypto/CommonDigest.h>
#import "PreferenceFileUtil.h"
@implementation MyToos

#pragma mark - 颜色转换 IOS中十六进制的颜色转换为UIColor
+ (UIColor *)colorWithHexString:(NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

#pragma mark - 获取导航栏,tabBarItem字体,按钮等颜色
+ (UIColor *)getThemeColor{
    
    return colorWithRGB(250, 178, 49, 1);
}

- (NSString *)getUserId{
    NSDictionary *dict = [self getFiledPathDict];
    NSString *userid = @"";
    userid = [dict objectForKey:@"userId"];
    if ([userid isEqualToString:@""]){
        userid = [dict objectForKey:@"touristsUserId"];
    }
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"login"] isEqualToString:@"login"]){
        dict = [self getFiledPathDict];
        if([dict objectForKey:@"userId"] == nil){
            
            dict = [self getAppPlistPath];
            userid = [dict objectForKey:@"userId"];
            if([dict objectForKey:@"userId"] == nil){
                
                userid = @"";
            }
            return userid;
            
        }
        return userid;
    }
    if(userid == nil){
        dict = [self getAppPlistPath];
        userid = [dict objectForKey:@"userId"];
        if([dict objectForKey:@"userId"] == nil){
            
            userid = @"";
        }
        return userid;
        
    }
    return userid;
}

- (NSDictionary *)getAppPlistPath{
    
    return nil;
}

- (NSDictionary *)getFiledPathDict{
    
    NSDictionary *dict = [[PreferenceFileUtil shareInstance] getContentsOfUserInfo];
    return dict;
}


@end
