//
//  DHGlobeM.m
//  DHTabBar_Example
//
//  Created by jabraknight on 2021/9/7.
//  Copyright © 2021 Mr. Zhao. All rights reserved.
//
#import "DHGlobeManager.h"
#import "DHGlobalView.h"

//#define DJ_SINGLETON_IMP(_type_) + (_type_ *)sharedInstance{\
//static _type_ *theSharedInstance = nil;\
//static dispatch_once_t onceToken;\
//dispatch_once(&onceToken, ^{\
//theSharedInstance = [[super alloc] init];\
//});\
//return theSharedInstance;\
//}
static NSString * _evnstring1;
static NSDictionary * _envMap;
static NSString * _HostDomain1 ;
static NSString * _HostURL1 ;
static NSString * _HtmlURL1 ;

@interface DHGlobeManager()

@property (nonatomic,assign) CGPoint startingPosition;
@property (nonatomic, strong) DHGlobalView *entryWindow;
//@property (nonatomic, strong, class) NSDictionary *envMap;

@end

@implementation DHGlobeManager
/*
 由Objective-C的一些特性可以知道，在对象创建的时候，无论是alloc还是new，都会调用到 allocWithZone方法。在通过拷贝的时候创建对象时，会调用到-(id)copyWithZone:(NSZone *)zone，-(id)mutableCopyWithZone:(NSZone *)zone方法。因此，可以重写这些方法，让创建的对象唯一。
 */
+ (id)allocWithZone:(NSZone *)zone{
    return [DHGlobeManager sharedInstance];
}
+ (DHGlobeManager *)sharedInstance{
    static DHGlobeManager * s_instance_dj_singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_instance_dj_singleton = [[super allocWithZone:nil] init];
    });
    return s_instance_dj_singleton;
}
- (id)copyWithZone:(NSZone *)zone{
    return [DHGlobeManager sharedInstance];
}
- (id)mutableCopyWithZone:(NSZone *)zone{
    return [DHGlobeManager sharedInstance];
}

//启用默认位置
- (void)install{
    CGPoint defaultPosition = CGPointMake(0, [UIScreen mainScreen].bounds.size.height/3.0);
    [self installWithStartingPosition:defaultPosition];
}

#pragma mark -按钮初始化
- (void)installWithStartingPosition:(CGPoint) position{
    _startingPosition = position;
    [self installWithCustom];
}

- (void)installWithCustom{
    [self initEntry:self.startingPosition];
}

- (void)initEntry:(CGPoint)startingPosition{
    _entryWindow = [[DHGlobalView alloc] initWithStartPoint:startingPosition];
    _entryWindow.hidden = NO;
}

//设置默认值
- (void)normalDataWithTag:(NSString *)tagStr{
    __block NSString *envStr = @"环境标识";
    __block NSDictionary *dict = [NSDictionary dictionary];
    [DHGlobeManager.envMap enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([tagStr isEqualToString:key]) {
            envStr = key;
            dict = obj;
            *stop = YES;
        }
    }];
    _HostDomain1 =  dict[@"HostDomain"];
    _HtmlURL1 =  dict[@"HtmlURL"];
    _HostURL1 = dict[@"HtmlURL"];
    _evnstring1 = tagStr;

    [_entryWindow.globalButton setTitle:tagStr forState:(UIControlStateNormal)];
}

//TODO:设置环境变量
- (void)setEnvironmentMap:(NSDictionary *)environmentMap {
    [self install];
    //设置环境变量
    _envMap = environmentMap;
    //设置默认环境
    if (DHGlobeManager.envstring.length <= 0 || DHGlobeManager.envstring == nil) {
        DHGlobeManager.envstring = @"SIT";
        [self normalDataWithTag:DHGlobeManager.envstring];
        return;
    }
    //获取真实环境
    DHGlobeManager.envstring = DHGlobeManager.envstring;
}

#pragma mark -setter/getter
+ (NSDictionary *)envMap{
    return _envMap;
}
+ (void)setEnvMap:(NSDictionary *)envMap{
    _envMap = envMap;
}
+ (NSString *)HostURL{
    return _HostURL1;
}
+ (void)setHostURL:(NSString *)HostURL1{
    _HostURL1 = HostURL1;
}
+ (NSString *)HostDomain{
    return _HostDomain1;
}
+ (void)setHostDomain:(NSString *)HostDomain{
    _HostDomain1 = HostDomain;
}
+ (NSString *)HtmlURL{
    return _HtmlURL1;
}
+ (void)setHtmlURL:(NSString *)HtmlURL{
    _HtmlURL1 = HtmlURL;
}
//标识别
+ (void)setEnvstring:(NSString *)envstring {
    _evnstring1 = envstring;
    
}
+ (NSString *)envstring{
    return _evnstring1;
}
@end


