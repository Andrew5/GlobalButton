//
//  DHGlobeM.h
//  DHTabBar_Example
//
//  Created by jabraknight on 2021/9/7.
//  Copyright © 2021 Mr. Zhao. All rights reserved.
//

#import <Foundation/Foundation.h>

//#define DJ_SINGLETON_DEF(_type_) + (_type_ *)sharedInstance;\
//+(instancetype) alloc __attribute__((unavailable("call sharedInstance instead")));\
//+(instancetype) new __attribute__((unavailable("call sharedInstance instead")));\
//-(instancetype) copy __attribute__((unavailable("call sharedInstance instead")));\
//-(instancetype) mutableCopy __attribute__((unavailable("call sharedInstance instead")));\

NS_ASSUME_NONNULL_BEGIN



typedef void (^restartCallback)(BOOL restartState);

@interface DHGlobeManager : NSObject
///业务回调(重置环境后续操作:清空数据、缓存等)
@property (nonatomic, copy) restartCallback restartCallback;

//获取当前环境标识
@property (nonatomic, copy,   class) NSString *envstring;
//对应环境
@property (nonatomic, copy,   class) NSString *HostDomain;
@property (nonatomic, copy,   class) NSString *HostURL;
@property (nonatomic, copy,   class) NSString *HtmlHomeURL;
@property (nonatomic, copy,   class) NSString *HtmlCommunityURL;
@property (nonatomic, copy,   class) NSString *HtmlMineURL;
@property (nonatomic, strong, class) NSDictionary *envMap;

+ (DHGlobeManager *)sharedInstance;
- (void)setEnvironmentMap:(NSDictionary *)environmentMap currectEnvironment:(NSString *)environment;

@end

NS_ASSUME_NONNULL_END
