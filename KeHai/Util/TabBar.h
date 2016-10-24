//
//  TabBar.h
//  KeHai
//
//  Created by 三海 on 16/10/24.
//  Copyright © 2016年 陈高健. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^composeButtonClickClourse)();
@interface TabBar : UITabBar
@property (copy, nonatomic) composeButtonClickClourse buttonClickBlock;
@end
