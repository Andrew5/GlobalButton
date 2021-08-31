# GlobalButton
# Artifacts

本文档列出了不同分支上的使用方法

## Example
//可以直接把GlobalButton 相关代码{DHGlobalConfig,DHGlobalContentButton,Unity}拖到项目中引用DHGlobalConfig头文件使用
亦或pod 'GlobalButton',:branch =>'master'

#import "DHGlobalConfig.h"

[DHGlobalConfig setEnvironmentMap:@{
    @"UAT":@"www.UAT.com",
    @"PRO":@"www.PRO.com",
    @"SIT":@"www.SIT.com",
} currentEnv:DHGlobalConfig.envstring];

测试方法
- (void)viewDidLoad {
    [super viewDidLoad];
    [self showErrorAlert:DHGlobalConfig.envstring];
}
- (void)showErrorAlert:(NSString *)errorString
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:errorString preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [ac addAction:action];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:ac animated:YES completion:nil];
    });
}

## 使用分支
pod 'GlobalButton', :branch =>'feature/moreEnv'

pod 'GlobalButton', :branch =>'master'

## GitHub Requirements

feature/moreEnv分支使用相对复杂场景，例如原生与H5交互，但是每个页面的请求还不相同：
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
[DHGlobalConfig setEnvironmentMap:dictURL currentEnv:DHGlobalConfig.envstring];


