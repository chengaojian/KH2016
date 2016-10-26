//
//  AppDelegate.m
//  KeHai
//
//  Created by 三海 on 16/10/22.
//  Copyright © 2016年 陈高健. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "ScheduleViewController.h"
#import "PhotoViewController.h"
#import "ShoppingViewController.h"
#import "MyViewController.h"
#import "TabBar.h"
#import "ComRequest.h"

@interface AppDelegate ()

// 存放title数组
@property (nonatomic, copy) NSArray *titleArr;
// 存放控制器数据
@property (nonatomic, copy) NSArray *vcArr;
// 存放导航控制器数组
@property (nonatomic, copy) NSMutableArray *viewCtrs;
// 存放tabBarItem资源图片
@property (nonatomic, copy) NSArray *tabBarItemImageArr;

@end

@implementation AppDelegate

- (void)setRootVC{
    
    // 初始化标题数据
    _titleArr = @[@"首页",@"课程表",@"拍照",@"购物车",@"我的"];
    
    // 初始化控制器
    HomeViewController *homeVC = [[HomeViewController alloc]init]; //首页
    ScheduleViewController *scheduleVC = [[ScheduleViewController alloc]init]; //课程表
    PhotoViewController *photoVC = [[PhotoViewController alloc]init]; // 拍照
    ShoppingViewController *shopingVC = [[ShoppingViewController alloc]init]; //购物车
    MyViewController *myVC = [[MyViewController alloc]init];// 我的
    
    // 添加控制器到数组控制器中
    _vcArr = @[homeVC,scheduleVC,photoVC,shopingVC,myVC];
    // 初始化导航控制器
    _viewCtrs = [NSMutableArray array];
    for (int i = 0; i < _titleArr.count; i ++) {
        UIViewController *vc = _vcArr[i];
        vc.title = _titleArr[i];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        nav.navigationBar.barTintColor = [UIColor colorWithRed:250/255.0 green:178/255.0 blue:49/255.0 alpha:1];
        nav.navigationBar.tintColor = [UIColor whiteColor];
        nav.navigationBar.titleTextAttributes =
        @{ NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName : [UIFont boldSystemFontOfSize:22] };
        [_viewCtrs addObject:nav];
    }
    
    // 设置tabBar控制器
    self.rootTabBarController = [[UITabBarController alloc]init];
    [self.rootTabBarController setViewControllers:_viewCtrs animated:YES];
    
    // 设置windos根控制器
    self.window.rootViewController = self.rootTabBarController;
    
    // 初始化tabBarItem资源图片
    _tabBarItemImageArr = @[@"tab_new_main_", @"tab_new_schedule_", @"tab_new_camera", @"tab_new_shopCar_", @"tab_new_mine_"];
    // 创建自定义TabBar
    TabBar *tabBar = [[TabBar alloc]init];
    __weak typeof(self) wSelf = self;
    tabBar.buttonClickBlock = ^() {
        if (wSelf) {
            NSLog(@"弹出照相机");
        }
    };
    
    // 利用KVC去设置只读属性
    [self.rootTabBarController setValue:tabBar forKey:@"tabBar"];
    // 设置tabBarItem图片
    for (int i = 0; i < _titleArr.count; i++) {
         UIViewController *vc = _vcArr[i];
        if (i != 2){ // 如果是拍照,则单独处理
            vc.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@sel",_tabBarItemImageArr[i]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            vc.tabBarItem.image = [[UIImage imageNamed:[NSString stringWithFormat:@"%@nor",_tabBarItemImageArr[i]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
    }
    // 设置tabBarItem字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [MyToos getThemeColor]} forState:UIControlStateSelected];
    // 设置主窗口并显示
    [self.window makeKeyAndVisible];
}

// 请求主接口
- (void)comRequest{
    
    NSString *appCode = APPCODE;
    NSString *comURL = com_url;
    ComRequest *req = [ComRequest shareInstanceWithUrl:comURL andAppId:appCode];
    [req httpComSessionRequestPostSuccess:^(Response *response) {
        [self setRootVC];
        NSDictionary *dict = response.data;
        NSLog(@"%@",dict);
    } failed:^(NSError *error) {
        
    }];
    
    
    
    
//    ComRequest *req = [ComRequest shareInstanceWithUrl:comURL andAppId:appCode];
//    [req httpComSessionRequestPostSuccess:^(SHResponse *response){
////        isRequestComSuccess = YES;//  请求成功
//     
//        if (!isFirstStart) {
//            myWindow.rootViewController = [SHMainTabBarController sharedTabBar];
//        }else {
//            [self fisrtGuid];
//        }
//    }failed:^(NSError *error) {
//        [[DMCAlertCenter defaultCenter] postAlertWithMessage:@"请检查网络"];
//        if (!isFirstStart) {
//            NewLoginViewController *new=[[NewLoginViewController alloc]init];
//            new.isRootVC = YES;
//            UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:new];
//            myWindow.rootViewController = new;
//        }else {
//            [self fisrtGuid];
//        }
//    }];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self comRequest];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
