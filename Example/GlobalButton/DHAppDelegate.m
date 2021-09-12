//
//  DHAppDelegate.m
//  GlobalButton
//
//  Created by localhost3585@gmail.com on 07/27/2021.
//  Copyright (c) 2021 localhost3585@gmail.com. All rights reserved.
//

#import "DHAppDelegate.h"
//#import "DHGlobeManager.h"
#import "DHGlobalConfig.h"

@implementation DHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSDictionary *dictURL = @{
        @"UAT":@{
                @"HostDomain":@"我是UAT环境网络Domain接口",
                @"HostURL":@"我是UAT环境网络URL接口",
                @"HtmlURL":@"我是UAT环境H5URL"
        },
        @"PRO":@{
                @"HostDomain":@"我是PRO环境网络Domain接口",
                @"HostURL":@"我是PRO环境网络URL接口",
                @"HtmlURL":@"我是PRO环境H5URL"
        },
        @"SIT":@{
                @"HostDomain":@"我是SIT环境网络Domain接口",
                @"HostURL":@"我是SIT环境网络URL接口",
                @"HtmlURL":@"我是SIT环境H5URL"
        }
    };
//    [[DHGlobeManager sharedInstance]setEnvironmentMap:dictURL];
    [DHGlobalConfig setEnvironmentMap:dictURL currentEnv:DHGlobalConfig.envstring];

    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    NSLog(@"1、%@",DHGlobalConfig.HostURL);
    NSLog(@"2、%@",DHGlobalConfig.HostDomain);
    NSLog(@"3、%@",DHGlobalConfig.HtmlURL);
    NSLog(@"aoppdele标示、%@",DHGlobalConfig.envstring);
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
