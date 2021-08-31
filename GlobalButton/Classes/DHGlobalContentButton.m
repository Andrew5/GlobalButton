//
//  DHGlobalContentButton.m
//  testSingature
//
//  Created by jabraknight on 2021/7/26.
//  Copyright ©https://github.com/miniLV/MNFloatBtn All rights reserved.
//

#import "DHGlobalContentButton.h"

static NSString * _evnstring = nil;


static NSString * _HostDomain;
static NSString * _HostURL;
static NSString * _HtmlURL;


@interface DHGlobalContentButton()

//当前展示的环境
@property (nonatomic, copy)NSString *environmentStr;
//本地保存环境对象
@property (nonatomic, strong) NSUserDefaults *defaults;
@property (nonatomic, strong) NSMutableDictionary *tmpDict;

@end
@implementation DHGlobalContentButton

//系统默认version
#define SystemVersionFloat [[[NSBundle mainBundle]infoDictionary]valueForKey:@"CFBundleShortVersionString"]

+ (DHGlobalContentButton *)sharedInstance{
    static dispatch_once_t once;
    static DHGlobalContentButton *instance;
    dispatch_once(&once, ^{
        instance = [[DHGlobalContentButton alloc] init];
    });
    return instance;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        NSString *title = [NSString stringWithFormat:@"Ver:%@ %@\n",SystemVersionFloat,self.environmentStr];
        [self setTitle:title forState:UIControlStateNormal];
        self.tmpDict = [NSMutableDictionary dictionary];
        self.backgroundColor = [UIColor colorWithRed:0/255.0f green:197/255.0f blue:205/255.0f alpha:1];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 10;
    }
    return self;
}

//设置环境变量
- (void)changeEnvironment{
    
    NSArray *envKeys = self.environmentMap.allKeys;
    if (!envKeys || envKeys.count <= 0) {
        NSLog(@"请设置环境变量");
        return;
    }
    NSInteger currentIndex = 0;
    if ([envKeys containsObject:self.environmentStr]) {
        currentIndex = [envKeys indexOfObject:self.environmentStr];
    }
    NSInteger nextEnvIndex = (currentIndex + 1) % envKeys.count;
    
    self.environmentStr = envKeys[nextEnvIndex];
    //更新当前环境按钮状态
    [self p_updateBtnTitle];
    
//    NSString *envBaseUrl = self.environmentMap[self.environmentStr];
    //更新环境状态
    [self environmentSet];

}
- (void)environmentSet{
    NSString *saveBaseUrlKey = @"DHGlobalConfigURL";

    if (self.environmentMap[self.environmentStr] == nil) {
        DHGlobalContentButton.evnstring = self.environmentStr;
        DHGlobalContentButton.HostURL = self.environmentMap[@"HostURL"];
        DHGlobalContentButton.HostDomain = self.environmentMap[@"HostDomain"];
        DHGlobalContentButton.HtmlURL = self.environmentMap[@"HtmlURL"];
    }else{
        DHGlobalContentButton.evnstring = self.environmentStr;
        DHGlobalContentButton.HostURL = self.environmentMap[self.environmentStr][@"HostURL"];
        DHGlobalContentButton.HostDomain = self.environmentMap[self.environmentStr][@"HostDomain"];
        DHGlobalContentButton.HtmlURL = self.environmentMap[self.environmentStr][@"HtmlURL"];
    }
    [self.tmpDict setObject:DHGlobalContentButton.HostURL forKey:@"HostURL"];
    [self.tmpDict setObject:DHGlobalContentButton.HostDomain forKey:@"HostDomain"];
    [self.tmpDict setObject:DHGlobalContentButton.HtmlURL forKey:@"HtmlURL"];
    [self.tmpDict setObject:self.environmentStr forKey:@"TAG"];
    [[NSUserDefaults standardUserDefaults]setObject:self.tmpDict forKey:saveBaseUrlKey];
}

//设置环境变量
- (void)setEnvironmentMap:(NSDictionary *)environmentMap
             currentEnvir:(NSString *)currentEnvir{
    __block NSString *envStr = @"测试";
    __block NSDictionary *dict = [NSDictionary dictionary];
    [environmentMap enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([currentEnvir isEqualToString:key]) {
            envStr = key;
            dict = obj;
            *stop = YES;
        }
    }];
    self.environmentStr = envStr;
    self.environmentMap = dict;
    [self environmentSet];
    [self p_updateBtnTitle];
}

- (void)p_updateBtnTitle{
    NSString *title = [NSString stringWithFormat:@"Ver:%@ %@\n",SystemVersionFloat,self.environmentStr];
    //如果createBtn的时候直接改title，可能会出现title无法更新问题，所以加个0.01s的延迟函数
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setTitle:title forState:UIControlStateNormal];
    });
}


- (NSString *)environmentStr{
    if (!_environmentStr) {
        _environmentStr = @"环境";
    }
    return _environmentStr;
}
#pragma mark -set、get方法
//标示
+ (NSString *)evnstring{
    return _evnstring;
}

+ (void)setEvnstring:(NSString *)evnstring{
    _evnstring = evnstring;
}

//分别配置环境
+ (NSString *)HostURL{
    return _HostURL;
}
+ (void)setHostURL:(NSString *)HostURL{
    _HostURL = HostURL;
}
+ (NSString *)HostDomain{
    return _HostDomain;
}
+ (void)setHostDomain:(NSString *)HostDomain{
    _HostDomain = HostDomain;
}
+ (NSString *)HtmlURL{
    return _HtmlURL;
}
+ (void)setHtmlURL:(NSString *)HtmlURL{
    _HtmlURL = HtmlURL;
}
@end
