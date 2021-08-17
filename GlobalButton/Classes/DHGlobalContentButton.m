//
//  DHGlobalContentButton.m
//  testSingature
//
//  Created by jabraknight on 2021/7/26.
//  Copyright ©https://github.com/miniLV/MNFloatBtn All rights reserved.
//

#import "DHGlobalContentButton.h"

static NSString * _evnstring = nil;

@interface DHGlobalContentButton()

//当前展示的环境
@property (nonatomic, copy)NSString *environmentStr;

@property (nonatomic, copy)NSDictionary *environmentMap;

@property (nonatomic, strong) NSUserDefaults *defaults;

@end
@implementation DHGlobalContentButton

//系统默认version
#define SystemVersionFloat [[[NSBundle mainBundle]infoDictionary]valueForKey:@"CFBundleShortVersionString"]

+ (DHGlobalContentButton *)sharedInstance{
    static dispatch_once_t once;
    static DHGlobalContentButton *instance;
    dispatch_once(&once, ^{
        instance = [[DHGlobalContentButton alloc] init];
    });
    return instance;
}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        NSString *title = [NSString stringWithFormat:@"Ver:%@ %@\n",SystemVersionFloat,self.environmentStr];
        [self setTitle:title forState:UIControlStateNormal];
//        [self.layer addSublayer:[self setGradualChangingColor:self fromColor:[UIColor colorWithRed:0/255.0f green:197/255.0f blue:205/255.0f alpha:0.6] toColor:[UIColor colorWithRed:0/255.0f green:229/255.0f blue:238/255.0f alpha:0.8] threeColor:[UIColor colorWithRed:0/255.0f green:245/255.0f blue:255/255.0f alpha:1]]];
        self.backgroundColor = [UIColor colorWithRed:0/255.0f green:197/255.0f blue:205/255.0f alpha:1];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 10;
    }
    return self;
}

//设置环境变量
- (void)changeEnvironment{
    
    NSArray *envKeys = self.environmentMap.allKeys;
    if (!envKeys || envKeys.count <= 0) {
        NSLog(@"请设置环境变量");
        return;
    }
    NSInteger currentIndex = 0;
    if ([envKeys containsObject:self.environmentStr]) {
        currentIndex = [envKeys indexOfObject:self.environmentStr];
    }
    NSInteger nextEnvIndex = (currentIndex + 1) % envKeys.count;
    
    self.environmentStr = envKeys[nextEnvIndex];
    //更新当前环境按钮状态
    [self p_updateBtnTitle];
    
    NSString *envBaseUrl = self.environmentMap[self.environmentStr];
    //更新环境状态
    NSString *saveBaseUrlKey = @"DHGlobalConfigURL";
    [[NSUserDefaults standardUserDefaults]setObject:envBaseUrl forKey:saveBaseUrlKey];
    DHGlobalContentButton.evnstring = envBaseUrl;
    
}

+ (NSString *)evnstring{
    return _evnstring;
}

+ (void)setEvnstring:(NSString *)evnstring{
    _evnstring = evnstring;
}

//设置环境变量
- (void)setEnvironmentMap:(NSDictionary *)environmentMap
             currentEnvir:(NSString *)currentEnvir{
    __block NSString *envStr = @"测试";
    [environmentMap enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([currentEnvir isEqualToString:obj]) {
            envStr = key;
            *stop = YES;
        }
    }];
    self.environmentStr = envStr;
    self.environmentMap = environmentMap;
    [self p_updateBtnTitle];
}

- (void)p_updateBtnTitle{
    NSString *title = [NSString stringWithFormat:@"Ver:%@ %@\n",SystemVersionFloat,self.environmentStr];
    //如果createBtn的时候直接改title，可能会出现title无法更新问题，所以加个0.01s的延迟函数
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setTitle:title forState:UIControlStateNormal];
    });
}
//绘制渐变色颜色的方法
- (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(UIColor *)fromHexColor toColor:(UIColor *)toHexColor threeColor:(UIColor *)threeHexColor{
    
    //    CAGradientLayer类对其绘制渐变背景颜色、填充层的形状(包括圆角)
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = view.bounds;
    
    //  创建渐变色数组，需要转换为CGColor颜色 （因为这个按钮有三段变色，所以有三个元素）
    gradientLayer.colors = @[(__bridge id)fromHexColor.CGColor,(__bridge id)toHexColor.CGColor,
                             (__bridge id)threeHexColor.CGColor];
    
    
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    gradientLayer.startPoint = CGPointMake(0, 0.5);
    gradientLayer.endPoint = CGPointMake(1, 0.5);
    
    //  设置颜色变化点，取值范围 0.0~1.0 （所以变化点有三个）
    gradientLayer.locations = @[@0,@0.5,@1];
    
    return gradientLayer;
}

- (NSString *)environmentStr{
    if (!_environmentStr) {
        _environmentStr = @"环境";
    }
    return _environmentStr;
}

@end
