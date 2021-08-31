//
//  DHViewController.m
//  GlobalButton
//
//  Created by localhost3585@gmail.com on 07/27/2021.
//  Copyright (c) 2021 localhost3585@gmail.com. All rights reserved.
//

#import "DHViewController.h"
#import "DHGlobalConfig.h"

@interface DHViewController ()
@property (nonatomic, strong)UILabel *unreadLabel;
@end

@implementation DHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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
    self.unreadLabel.text =[NSString stringWithFormat:@"%@,%@,%@,%@",DHGlobalConfig.HostURL,DHGlobalConfig.HostDomain,DHGlobalConfig.HtmlURL,DHGlobalConfig.envstring];
    [self.view addSubview:self.unreadLabel];
    
    NSLog(@"1、%@",DHGlobalConfig.HostURL);
    NSLog(@"2、%@",DHGlobalConfig.HostDomain);
    NSLog(@"3、%@",DHGlobalConfig.HtmlURL);
    NSLog(@"标识、%@",DHGlobalConfig.envstring);
}
- (UILabel *)unreadLabel {
    if (_unreadLabel == nil) {
        _unreadLabel = [[UILabel alloc] init];
        _unreadLabel.layer.masksToBounds = YES;
        _unreadLabel.layer.cornerRadius  = 4;
        _unreadLabel.backgroundColor = UIColor.redColor;
        _unreadLabel.textColor = UIColor.blackColor;
        _unreadLabel.numberOfLines = 2;
        _unreadLabel.frame = CGRectMake(10, 100, 300, 80);
    }
    return _unreadLabel;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
