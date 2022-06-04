//
//  DHHomeWindow.m
//  DHTabBar_Example
//
//  Created by jabraknight on 2021/9/7.
//  Copyright © 2021 Mr. Zhao. All rights reserved.
//

#import "DHHomeDataListView.h"
#import "DHGlobeManager.h"
#import <objc/runtime.h>

static char ActionTag;

@class  DHGlobalBlockAction;
@interface DHGlobalBlockAction : UIButton

typedef void (^ButtonBlock)(UIButton* sender);

- (void)addAction:(ButtonBlock)block forControlEvents:(UIControlEvents)controlEvents;

@end

@implementation DHGlobalBlockAction

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
    ///FIXME: 数据过于限制，需要动态赋值
    DHGlobeManager.HostDomain   =  DHGlobeManager.envMap[title][@"HostDomain"];
    DHGlobeManager.HostURL      =  DHGlobeManager.envMap[title][@"HostURL"];
    DHGlobeManager.HtmlHomeURL  =  DHGlobeManager.envMap[title][@"HtmlHomeURL"];
    DHGlobeManager.HtmlCommunityURL =  DHGlobeManager.envMap[title][@"HtmlCommunityURL"];
    DHGlobeManager.HtmlMineURL  =  DHGlobeManager.envMap[title][@"HtmlMineURL"];

    DHGlobeManager.envstring = currentEnv;
    //为解决主动退出后保存数据
    [[NSUserDefaults standardUserDefaults]  setObject:currentEnv forKey:@"TAG"];
    NSLog(@"%s 1、%@",__FUNCTION__,DHGlobeManager.HostURL);
    NSLog(@"%s 2、%@",__FUNCTION__,DHGlobeManager.HostDomain);
    NSLog(@"%s 3、%@",__FUNCTION__,DHGlobeManager.HtmlHomeURL);
    NSLog(@"%s 3、%@",__FUNCTION__,DHGlobeManager.HtmlCommunityURL);
    NSLog(@"%s 3、%@",__FUNCTION__,DHGlobeManager.HtmlMineURL);
    NSLog(@"%s 4、%@",__FUNCTION__,DHGlobeManager.envstring);
}

///上一个
- (void)show:(showTitleCB) showTitleCB{
    //视图容器
    UIView *listView= [[UIView alloc]init];
    [self addSubview:listView];
    CGFloat H =  200;
    listView.frame = CGRectMake(20, self.center.y - H/2, self.frame.size.width - 20*2, H);
    listView.backgroundColor = [UIColor orangeColor];
    listView.layer.cornerRadius = 10;

    CGFloat subviewHeight =  30;//子视图每个按钮的高度
    CGFloat subviewX =  10;//子视图每个按钮左边距
    CGFloat subviewY =  10;//子视图按钮上边距
    CGFloat subviewSpace =  10;//子视图每个按钮的间隔
    for (int i = 0; i<DHGlobeManager.envMap.count; i++) {
        DHGlobalBlockAction *chooseEnvironment = [[DHGlobalBlockAction alloc]initWithFrame:CGRectMake(subviewX, subviewY + (subviewSpace + subviewHeight) * i, listView.frame.size.width - subviewX * 2, subviewHeight)];
        chooseEnvironment.backgroundColor = [UIColor whiteColor];
        [chooseEnvironment setTitle:DHGlobeManager.envMap.allKeys[i]/*[@"选择" stringByAppendingString:DHGlobeM.envMap.allKeys[i]]*/ forState:(UIControlStateNormal)];
        [chooseEnvironment setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
        [chooseEnvironment addAction:^(UIButton *sender) {
            NSLog(@"我是Blcok: Did方法\n\n");
            NSLog(@"xxx Blco前 1、%@",DHGlobeManager.HostURL);
            NSLog(@"xxx Blco前 2、%@",DHGlobeManager.HostDomain);
            NSLog(@"xxx Blco前 3、%@",DHGlobeManager.HtmlHomeURL);
            NSLog(@"xxx Blco前 3、%@",DHGlobeManager.HtmlCommunityURL);
            NSLog(@"xxx Blco前 3、%@",DHGlobeManager.HtmlMineURL);
            NSLog(@"xxx Blco前 4、%@",DHGlobeManager.envstring);
            [self changeEnvironmentWithTag:sender.currentTitle];
            NSLog(@"xxx Block后 1、%@",DHGlobeManager.HostURL);
            NSLog(@"xxx Block后 2、%@",DHGlobeManager.HostDomain);
            NSLog(@"xxx Block后 3、%@",DHGlobeManager.HtmlHomeURL);
            NSLog(@"xxx Block后 3、%@",DHGlobeManager.HtmlCommunityURL);
            NSLog(@"xxx Block后 3、%@",DHGlobeManager.HtmlMineURL);
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
    NSLog(@"xxx Block后 3、%@",DHGlobeManager.HtmlHomeURL);
    NSLog(@"xxx Block后 3、%@",DHGlobeManager.HtmlCommunityURL);
    NSLog(@"xxx Block后 3、%@",DHGlobeManager.HtmlMineURL);
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
