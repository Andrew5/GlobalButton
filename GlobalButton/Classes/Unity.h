//
//  Unity.h
//  testSingature
//
//  Created by jabraknight on 2021/7/26.
//  Copyright © 2021 zk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Unity : NSObject

+ (Unity *)sharedInstance;
- (UIView *)topView;
- (UIViewController *)getCurrentVC;

@end


