# GlobalButton

本文档列出了不同分支上的使用方法

## Use
可以直接把GlobalButton 相关代码{DHGlobalConfig,DHGlobalContentButton,Unity}拖到项目中引用DHGlobalConfig头文件使用
pod 'GlobalButton',:subspecs => ['complex']
pod 'GlobalButton',:subspecs => ['only']

## Example
原生使用接口单一场景

#import "DHGlobalConfig.h"

[DHGlobalConfig setEnvironmentMap:@{
    @"UAT":@"www.UAT.com",
    @"PRO":@"www.PRO.com",
    @"SIT":@"www.SIT.com",
} currentEnv:DHGlobalConfig.envstring];
或者
使用相对复杂场景，例如原生与H5交互，但是每个页面的请求还不相同：

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

//complex 分支(界面选择窗口)
[[DHGlobeManager sharedInstance]setEnvironmentMap:dictURL]



## Test

- (void)applicationWillResignActive:(UIApplication *)application
{
//complex 分支
    NSLog(@"1、%@",DHGlobalConfig.HostURL);
    NSLog(@"2、%@",DHGlobalConfig.HostDomain);
    NSLog(@"3、%@",DHGlobalConfig.HtmlURL);
    NSLog(@"4、%@",DHGlobalConfig.envstring);
//master分支
    NSLog(@"1、%@",DHGlobalConfig.HostURL);
    NSLog(@"aoppdele标示、%@",DHGlobalConfig.envstring);
}

## Use  branch

单一场景
pod 'GlobalButton', :branch =>'master'
复杂场景
亦或 
pod 'GlobalButton', :subspecs => ['complex']


