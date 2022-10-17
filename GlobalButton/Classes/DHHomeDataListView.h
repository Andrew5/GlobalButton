//
//  DHHomeWindow.h
//  DHTabBar_Example
//
//  Created by jabraknight on 2021/9/7.
//  Copyright © 2021 Mr. Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^showTitleCB)(NSString* title);

@interface DHHomeDataListView : UIWindow

+ (DHHomeDataListView *)shareInstance;

- (void)show:(showTitleCB) showTitleCB;
- (void)hide;

@end

NS_ASSUME_NONNULL_END
