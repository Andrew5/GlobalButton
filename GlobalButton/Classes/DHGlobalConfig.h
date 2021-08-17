//
//  GlobalConfig.h
//  testSingature
//
//  Created by jabraknight on 2021/7/26.
//  Copyright ©https://github.com/miniLV/MNFloatBtn All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DHGlobalConfig : UIWindow

//获取环境
@property (nonatomic, copy, class,readonly) NSString *envstring;
//设置环境
+ (void)setEnvironmentMap:(NSDictionary *)environmentMap
               currentEnv:(NSString *)currentEnv;


@end

NS_ASSUME_NONNULL_END
