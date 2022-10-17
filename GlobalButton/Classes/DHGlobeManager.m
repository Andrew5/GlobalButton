//
//  DHGlobeM.m
//  DHTabBar_Example
//
//  Created by jabraknight on 2021/9/7.
//  Copyright © 2021 Mr. Zhao. All rights reserved.
//
#import "DHGlobeManager.h"
#import "DHGlobalView.h"
#import <objc/runtime.h>

//#define DJ_SINGLETON_IMP(_type_) + (_type_ *)sharedInstance{\
//static _type_ *theSharedInstance = nil;\
//static dispatch_once_t onceToken;\
//dispatch_once(&onceToken, ^{\
//theSharedInstance = [[super alloc] init];\
//});\
//return theSharedInstance;\
//}
static char NotificationAction;
typedef void (^NotificationActionBlock)(NSNotification* sender);

@interface NSNotificationCenter (CustomNotificationCenter)
- (void)addObserver:(id)observer name:(nullable NSNotificationName)aName object:(nullable id)anObject addAction:(NotificationActionBlock)block;

@end

@implementation NSNotificationCenter (CustomNotificationCenter)

- (void)addObserver:(id)observer name:(nullable NSNotificationName)aName object:(nullable id)anObject addAction:(NotificationActionBlock)block {
    objc_setAssociatedObject(self, &NotificationAction, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(action:) name:aName object:anObject];
}

- (void)action:(NSNotification *)sender {
    NotificationActionBlock blockAction = (NotificationActionBlock)objc_getAssociatedObject(self, &NotificationAction);
    if (blockAction) {
        blockAction(sender);
    }
}

@end


static NSString * _evnstring1;
static NSDictionary * _envMap;
static NSString * _HostDomain1;
static NSString * _HostURL1;
static NSString * _HtmlHomeURL1;
static NSString * _HtmlCommunityURL1;
static NSString * _HtmlMineURL1;

@interface DHGlobeManager()

@property (nonatomic,assign) CGPoint startingPosition;
@property (nonatomic, strong) DHGlobalView *entryWindow;

@end

@implementation DHGlobeManager
/*
 由Objective-C的一些特性可以知道，在对象创建的时候，无论是alloc还是new，都会调用到 allocWithZone方法。在通过拷贝的时候创建对象时，会调用到-(id)copyWithZone:(NSZone *)zone，-(id)mutableCopyWithZone:(NSZone *)zone方法。
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
    [[NSNotificationCenter defaultCenter] addObserver:self name:@"restart" object:nil addAction:^(NSNotification * _Nonnull sender) {
        if (self.restartCallback) {
            self.restartCallback(YES);
        }
    }];
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
    ///FIXME: 数据过于限制，需要动态赋值?
    //赋值
    _HostDomain1        =   dict[@"HostDomain"];
    _HtmlCommunityURL1  =   dict[@"HtmlCommunityURL"];
    _HtmlMineURL1       =   dict[@"HtmlMineURL"];
    _HtmlHomeURL1       =   dict[@"HtmlHomeURL"];
    _HostURL1           =   dict[@"HostURL"];
    _evnstring1         =   tagStr;

    [_entryWindow.globalButton setTitle:tagStr forState:(UIControlStateNormal)];
}

//TODO:设置环境变量
- (void)setEnvironmentMap:(NSDictionary *)environmentMap currectEnvironment:(NSString *)environment{
    [self install];
    //设置环境变量
    _envMap = environmentMap;
    //设置当前环境
    if (DHGlobeManager.envstring.length <= 0 || DHGlobeManager.envstring == nil) {
        DHGlobeManager.envstring = [[NSUserDefaults standardUserDefaults] objectForKey:@"TAG"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"TAG"]:environment;
        [self normalDataWithTag:DHGlobeManager.envstring];
        return;
    }
    //获取真实环境
    DHGlobeManager.envstring = DHGlobeManager.envstring;
}
///???: 需要的数据要不要写死
#pragma mark -setter/getter
+ (NSDictionary *)envMap{
    return _envMap;
}
+ (void)setEnvMap:(NSDictionary *)envMap{
    _envMap = envMap;
}
//原生接口
+ (NSString *)HostURL{
    return _HostURL1;
}
+ (void)setHostURL:(NSString *)HostURL{
    _HostURL1 = HostURL;
}
+ (NSString *)HostDomain{
    return _HostDomain1;
}
+ (void)setHostDomain:(NSString *)HostDomain{
    _HostDomain1 = HostDomain;
}
//H5
+ (NSString *)HtmlHomeURL{
    return _HtmlHomeURL1;
}
+ (void)setHtmlHomeURL:(NSString *)HtmlHomeURL{
    _HtmlHomeURL1 = HtmlHomeURL;
}
+ (NSString *)HtmlCommunityURL{
    return _HtmlCommunityURL1;
}
+ (void)setHtmlCommunityURL:(NSString *)HtmlCommunityURL{
    _HtmlCommunityURL1 = HtmlCommunityURL;
}
+ (NSString *)HtmlMineURL{
    return _HtmlMineURL1;
}
+ (void)setHtmlMineURL:(NSString *)HtmlMineURL{
    _HtmlMineURL1 = HtmlMineURL;
}
//标识
+ (void)setEnvstring:(NSString *)envstring {
    _evnstring1 = envstring;
    
}
+ (NSString *)envstring{
    return _evnstring1;
}
@end


