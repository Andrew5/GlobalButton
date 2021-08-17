# GlobalButton


## Example
//可以直接把GlobalButton 文件夹拖到项目中引用头文件使用
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

## Requirements
