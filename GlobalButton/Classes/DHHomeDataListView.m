//
//  DHHomeWindow.m
//  DHTabBar_Example
//
//  Created by jabraknight on 2021/9/7.
//  Copyright © 2021 Mr. Zhao. All rights reserved.
//

#import "DHHomeDataListView.h"
//#import "DHYViewController.h"
#import "DHGlobeManager.h"
#import <objc/runtime.h>
static char ActionTag;

@class  DHGlobalBlockAction;
@interface DHGlobalBlockAction : UIButton
typedef void (^ButtonWillAndDidBlock) (DHGlobalBlockAction *sender);
typedef void (^ButtonBlock)(UIButton* sender);

@property (nonatomic, copy) ButtonWillAndDidBlock willBlock;

- (void)setButtonShouldBlock:(ButtonWillAndDidBlock)block;
- (void)addAction:(ButtonBlock)block forControlEvents:(UIControlEvents)controlEvents;

@end

@implementation DHGlobalBlockAction

- (void)setButtonShouldBlock: (ButtonWillAndDidBlock) block{
    self.willBlock = block;
}
- (void)addAction:(ButtonBlock)block forControlEvents:(UIControlEvents)controlEvents {
    objc_setAssociatedObject(self, &ActionTag, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(action:) forControlEvents:controlEvents];
}
- (void)action:(id)sender {
    ButtonBlock blockAction = (ButtonBlock)objc_getAssociatedObject(self, &ActionTag);
    if (blockAction) {
        blockAction(self);
    }
}

@end

@interface DHHomeDataListView()

@end

@implementation DHHomeDataListView

+ (DHHomeDataListView *)shareInstance{
    static dispatch_once_t once;
    static DHHomeDataListView *instance;
    dispatch_once(&once, ^{
        instance = [[DHHomeDataListView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    });
    return instance;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.windowLevel = UIWindowLevelStatusBar - 1.f;
        self.backgroundColor = [UIColor clearColor];
        self.hidden = YES;
    }
    return self;
}

///设置环境变量
- (void)changeEnvironmentWithTag:(NSString *)title {

    NSArray *envKeys = DHGlobeManager.envMap.allKeys;
    if (!envKeys || envKeys.count <= 0) {
        return;
    }
    NSInteger currentIndex = 0;
    if ([envKeys containsObject:title]) {
        currentIndex = [envKeys indexOfObject:title];
    }
    NSInteger nextEnvIndex = (currentIndex ) % envKeys.count;

    NSString *currentEnv = envKeys[nextEnvIndex];

    DHGlobeManager.HostDomain =  DHGlobeManager.envMap[title][@"HostDomain"];
    DHGlobeManager.HostURL =  DHGlobeManager.envMap[title][@"HostURL"];
    DHGlobeManager.HtmlURL =  DHGlobeManager.envMap[title][@"HtmlURL"];
    DHGlobeManager.envstring = currentEnv;
    NSLog(@"%s 1、%@",__FUNCTION__,DHGlobeManager.HostURL);
    NSLog(@"%s 2、%@",__FUNCTION__,DHGlobeManager.HostDomain);
    NSLog(@"%s 3、%@",__FUNCTION__,DHGlobeManager.HtmlURL);
    NSLog(@"%s 4、%@",__FUNCTION__,DHGlobeManager.envstring);
}

///上一个
- (void)show:(showTitleCB) showTitleCB{
    //背景容器
    UIView *listView= [[UIView alloc]init];
    [self addSubview:listView];
    CGFloat H =  200;
    listView.frame = CGRectMake(20, self.center.y-H/2,self.frame.size.width-20*2, H);
    listView.backgroundColor = [UIColor orangeColor];
    listView.layer.cornerRadius = 10;
    //数据
    for (int i = 0; i<DHGlobeManager.envMap.count; i++) {
        DHGlobalBlockAction *chooseEnvironment = [[DHGlobalBlockAction alloc]initWithFrame:CGRectMake(10, 10+30*i, 100, 25)];
        chooseEnvironment.backgroundColor = [UIColor whiteColor];
        [chooseEnvironment setTitle:DHGlobeManager.envMap.allKeys[i]/*[@"选择" stringByAppendingString:DHGlobeM.envMap.allKeys[i]]*/ forState:(UIControlStateNormal)];
        [chooseEnvironment setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
        [chooseEnvironment addAction:^(UIButton *sender) {
            NSLog(@"我是Blcok: Did方法\n\n");
            NSLog(@"xxx Blco前 1、%@",DHGlobeManager.HostURL);
            NSLog(@"xxx Blco前 2、%@",DHGlobeManager.HostDomain);
            NSLog(@"xxx Blco前 3、%@",DHGlobeManager.HtmlURL);
            NSLog(@"xxx Blco前 4、%@",DHGlobeManager.envstring);
            [self changeEnvironmentWithTag:sender.currentTitle];
            NSLog(@"xxx Block后 1、%@",DHGlobeManager.HostURL);
            NSLog(@"xxx Block后 2、%@",DHGlobeManager.HostDomain);
            NSLog(@"xxx Block后 3、%@",DHGlobeManager.HtmlURL);
            NSLog(@"xxx Block后 4、%@",DHGlobeManager.envstring);
            [self hide];
            showTitleCB(DHGlobeManager.envstring);
        } forControlEvents:UIControlEventTouchUpInside];
        [listView addSubview: chooseEnvironment];
    }
    self.hidden = NO;
}

- (void)hide{
    NSLog(@"hide 1、%@",DHGlobeManager.HostURL);
    NSLog(@"hide 2、%@",DHGlobeManager.HostDomain);
    NSLog(@"hide 3、%@",DHGlobeManager.HtmlURL);
    NSLog(@"hide 4、%@",DHGlobeManager.envstring);
    if (self.rootViewController.presentedViewController) {
        [self.rootViewController.presentedViewController dismissViewControllerAnimated:NO completion:nil];
    }
    self.hidden = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
