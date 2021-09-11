//
//  DHGlobalWindows.m
//  DHTabBar_Example
//
//  Created by jabraknight on 2021/9/6.
//  Copyright © 2021 Mr. Zhao. All rights reserved.
//

#import "DHGlobalView.h"
#import "DHHomeDataListView.h"

CGFloat screenW = 0;
CGFloat screenH = 0;
CGFloat buttonW = 40;
CGFloat NavBar_H = 44+44;
CGFloat BottomBar_H = 49+34;

@interface DHGlobalView ()

@end

@implementation DHGlobalView

- (instancetype)initWithStartPoint:(CGPoint)startingPosition {
    CGFloat y = startingPosition.y;
    self = [super initWithFrame:CGRectMake(0, y, buttonW, buttonW)];
    if (self) {
        screenW = [UIScreen mainScreen].bounds.size.width;
        screenH = [UIScreen mainScreen].bounds.size.height;

        self.backgroundColor = [UIColor clearColor];//可选
        self.windowLevel = UIWindowLevelStatusBar + 100.f;
        self.layer.masksToBounds = YES;
        
        self.rootViewController = [[UIViewController alloc]init];
        [self.rootViewController.view addSubview:self.globalButton];

        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
        [self addGestureRecognizer:pan];
        
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagAddAlert)];
//        [self addGestureRecognizer:ges];
    }
    return  self;
}

- (UIButton *)globalButton {
    if (_globalButton == nil) {
        _globalButton = [[UIButton alloc]initWithFrame:self.bounds];
        _globalButton.backgroundColor = [UIColor orangeColor];
        _globalButton.layer.cornerRadius = buttonW/2;
        [_globalButton addTarget:self action:@selector(tagAddAlert) forControlEvents:UIControlEventTouchUpInside];
    }
    return _globalButton;
}

- (void)tagAddAlert {
    NSLog(@"%s",__FUNCTION__);
    __weak __typeof(self)weakSelf = self;
    if ([DHHomeDataListView shareInstance].hidden) {
        [[DHHomeDataListView shareInstance] show:^(NSString * _Nonnull title) {
            [weakSelf.globalButton setTitle:title forState:(UIControlStateNormal)];
        }];
    }else{
        [[DHHomeDataListView shareInstance] hide];
    }
}

#pragma mark  拖拽手势方法
- (void)panAction:(UIPanGestureRecognizer *)gestureRecognizer {
    ///  获取通过的点
    CGPoint p = [gestureRecognizer translationInView:self];
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) { // 开始滑动
    
    } else if ([gestureRecognizer state] == UIGestureRecognizerStateChanged) { // 坐标改变中
        if (self.frame.origin.x + p.x <= 0 || self.frame.origin.x + p.x >= screenW - self.frame.size.width) {
            if (self.frame.origin.y + p.y <= NavBar_H || self.frame.origin.y + p.y >= screenH - BottomBar_H - self.frame.size.height - 44) {
                [self setTransform:CGAffineTransformTranslate([self transform], 0, 0)];
            }
            else {
                [self setTransform:CGAffineTransformTranslate([self transform], 0, p.y)];
                [gestureRecognizer setTranslation:CGPointZero inView:self];
            }
        } else if (self.frame.origin.y + p.y <= NavBar_H || self.frame.origin.y + p.y >= screenH - BottomBar_H - self.frame.size.height - 44) {
            if (self.frame.origin.x + p.x <= 0 || self.frame.origin.x + p.x >= screenW - self.frame.size.width) {
                [self setTransform:CGAffineTransformTranslate([self transform], 0, 0)];
            } else {
                [self setTransform:CGAffineTransformTranslate([self transform], p.x, 0)];
                [gestureRecognizer setTranslation:CGPointZero inView:self];
            }
        } else {
            [self setTransform:CGAffineTransformTranslate([self transform], p.x, p.y)];
            [gestureRecognizer setTranslation:CGPointZero inView:self];
        }
    } else { // 手离开屏幕
        if (self.frame.origin.x >= screenW / 2.0 - self.frame.size.width / 2) {
            [UIView animateWithDuration:.3f animations:^{
                self.frame = CGRectMake(screenW - self.frame.size.width, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
            }];
        } else {
            [UIView animateWithDuration:.3f animations:^{
                self.frame = CGRectMake(0, self.frame.origin.y,self.frame.size.width,self.frame.size.height);
            }];
        }
    }
}

- (void)autoDocking:(UIPanGestureRecognizer *)panGestureRecognizer {
    
    UIView *panView = panGestureRecognizer.view;
    switch (panGestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged: {
            CGPoint translation = [panGestureRecognizer translationInView:panView];
            [panGestureRecognizer setTranslation:CGPointZero inView:panView];
            panView.center = CGPointMake(panView.center.x + translation.x, panView.center.y + translation.y);
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            CGPoint location = panView.center;
            CGFloat centerX;
            CGFloat safeBottom = 0;
            if (@available(iOS 11.0, *)) {
               safeBottom = self.safeAreaInsets.bottom;
            }
            CGFloat centerY = MAX(MIN(location.y, CGRectGetMaxY([UIScreen mainScreen].bounds)-safeBottom), [UIApplication sharedApplication].statusBarFrame.size.height);
            if(location.x > CGRectGetWidth([UIScreen mainScreen].bounds)/2.f) {
                centerX = CGRectGetWidth([UIScreen mainScreen].bounds)-buttonW/2;
            }
            else {
                centerX = buttonW/2;
            }
            [[NSUserDefaults standardUserDefaults] setObject:@{
                                                               @"x":[NSNumber numberWithFloat:centerX],
                                                               @"y":[NSNumber numberWithFloat:centerY]
                                                               } forKey:@"FloatViewCenterLocation"];
            [UIView animateWithDuration:0.3 animations:^{
                panView.center = CGPointMake(centerX, centerY);
            }];
        }

        default:
            break;
    }
}

- (void)normalMode: (UIPanGestureRecognizer *)panGestureRecognizer {
    //1、获得拖动位移
    CGPoint offsetPoint = [panGestureRecognizer translationInView:panGestureRecognizer.view];
    //2、清空拖动位移
    [panGestureRecognizer setTranslation:CGPointZero inView:panGestureRecognizer.view];
    //3、重新设置控件位置
    UIView *panView = panGestureRecognizer.view;
    CGFloat newX = panView.center.x+offsetPoint.x;
    CGFloat newY = panView.center.y+offsetPoint.y;
    if (newX < buttonW/2) {
        newX = buttonW/2;
    }
    if (newX > screenW - buttonW/2) {
        newX = screenW - buttonW/2;
    }
    if (newY < buttonW/2) {
        newY = buttonW/2;
    }
    if (newY > screenH - buttonW/2) {
        newY = screenH - buttonW/2;
    }
    panView.center = CGPointMake(newX, newY);
}

//hitTest 的调用顺序
//touch -> UIApplication -> UIWindow -> UIViewController.view -> subViews -> ....-> 合适的view
//事件的传递顺序
//view -> superView ...- > UIViewController.view -> UIViewController -> UIWindow -> UIApplication -> 事件丢弃
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    // 如果交互未打开，或者透明度小于0.05 或者 视图被隐藏
        if (self.userInteractionEnabled == NO || self.alpha < 0.05 || self.hidden == YES)  {
            return nil;
        }
        // 如果 touch 的point 在 self 的bounds 内
        if ([self pointInside:point withEvent:event]) {
            for (UIView *subView in self.subviews) {
                //进行坐标转化
                CGPoint coverPoint = [subView convertPoint:point fromView:self];
                NSLog(@"-%f-%f",coverPoint.x,coverPoint.y);
//                return self;
               // 调用子视图的 hitTest 重复上面的步骤。找到了，返回hitTest view ,没找到返回有自身处理
                UIView *hitTestView = [subView hitTest:coverPoint withEvent:event];
                if (hitTestView) {
                    return hitTestView;
                }
            }

            return self;

        }

        return nil;

}
//- (BOOL)touchPointInsideCircle:(CGPoint)center radius:(CGFloat)radius targetPoint:(CGPoint)point
// {
//     CGFloat dist = sqrtf((point.x - center.x) * (point.x - center.x) +
//                          (point.y - center.y) * (point.y - center.y));
//     return (dist <= radius);
// }
//
//
// - (void)onBtnPressed:(id)sender
// {
//     UIButton *btn = (UIButton *)sender;
//     NSLog(@"btn tag:%d", btn.tag);
// }
 
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
