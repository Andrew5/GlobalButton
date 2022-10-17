//
//  DHGlobalWindows.h
//  DHTabBar_Example
//
//  Created by jabraknight on 2021/9/6.
//  Copyright © 2021 Mr. Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DHGlobalView : UIWindow
@property (nonatomic, strong) NSString *envstring;
@property (nonatomic, strong) UIButton *globalButton;

- (instancetype)initWithStartPoint:(CGPoint)startingPosition;

@end

NS_ASSUME_NONNULL_END
