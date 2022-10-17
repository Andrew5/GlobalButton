# GlobalButton

本文档列出了不同分支上的使用方法


## Example
原生使用接口单一场景

#import "DHGlobalConfig.h"

[DHGlobalConfig setEnvironmentMap:@{
    @"UAT":@"www.UAT.com",
    @"PRO":@"www.PRO.com",
    @"SIT":@"www.SIT.com",
} currentEnv:DHGlobalConfig.envstring];


使用相对复杂场景，例如原生与H5交互，但是每个页面的请求还不相同：

#import "DHGlobeManager.h"

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
    NSLog(@"1、%@",DHGlobeManager.HostURL);
    NSLog(@"2、%@",DHGlobeManager.HostDomain);
    NSLog(@"3、%@",DHGlobeManager.HtmlURL);
    NSLog(@"4、%@",DHGlobeManager.envstring);
//master分支
    NSLog(@"1、%@",DHGlobalConfig.HostURL);
    NSLog(@"aoppdele标示、%@",DHGlobalConfig.envstring);
}

## Use  install
OC版本安装
CocoaPods安装: 在podfile文件中添加以下描述,然后 pod install
单一场景
pod 'GlobalButton', :branch =>'master'
复杂场景
pod 'GlobalButton', :subspecs => ['complex']

手动导入集成
1.拖动LSTPopView文件下5个文件到项目中
单一场景
DHGlobalConfig.h
DHGlobalConfig.m
DHGlobalContentButton.h
DHGlobalContentButton.m
Unity.h
Unity.m
复杂场景
DHGlobeManager.h
DHGlobeManager.m
DHGlobalView.h
DHGlobalView.m
DHHomeDataListView.h
DHHomeDataListView.m
