//
//  AppDelegate.m
//  NewsList
//
//  Created by Johnson on 2022/6/17.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    ViewController *vc = [[ViewController alloc] init];
    
//    UINavigationController *navVc = [[UINavigationController alloc] initWithRootViewController:vc];
//    navVc.navigationBar.backgroundColor = [UIColor colorWithRed:43/255 green:129/255 blue:1 alpha:1];
//    navVc.navigationBar.barTintColor = [UIColor whiteColor];
//    [navVc setNavigationBarHidden:NO];
//
//    navVc.navigationBar.barTintColor = [UIColor colorWithRed:43/255 green:129/255 blue:1 alpha:1];
//    navVc.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
//    [navVc.navigationBar setBackgroundImage:[UIImage new] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
//
//    navVc.navigationBar.tintColor = [UIColor whiteColor];
//    navVc.navigationBar.translucent = NO;
    
//    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    window.rootViewController = navVc;
//    [window makeKeyAndVisible];
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
