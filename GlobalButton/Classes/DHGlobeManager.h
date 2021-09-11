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

@interface DHGlobeManager : NSObject
//获取当前环境标识
@property (nonatomic, copy, class) NSString *envstring;
//对应环境
@property (nonatomic, copy, class ) NSString *HostDomain;
@property (nonatomic, copy, class ) NSString *HostURL;
@property (nonatomic, copy, class ) NSString *HtmlURL;
@property (nonatomic, strong, class) NSDictionary *envMap;

+ (DHGlobeManager *)sharedInstance;

- (void)install;

- (void)setEnvironmentMap:(NSDictionary *)environmentMap;
@end

NS_ASSUME_NONNULL_END
