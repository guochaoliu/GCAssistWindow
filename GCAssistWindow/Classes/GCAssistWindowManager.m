//
//  GCAssistWindowManager.m
//  FBSnapshotTestCase
//
//  Created by yons on 2020/8/18.
//

#import "GCAssistWindowManager.h"

static GCAssistWindowManager *_manager;
@implementation GCAssistWindowManager
//单例
+ (instancetype)manager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[GCAssistWindowManager alloc] init];
        _manager.assistWindows = [NSMutableDictionary dictionary];
    });
    return _manager;
}
//初始化window 不设置rootController
- (UIWindow *)makeWindowWithIdentifier:(NSString *)identifier{
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.windowLevel = UIWindowLevelAlert - 1;
    [window makeKeyAndVisible];
    UIWindow *oldWindow = [self.assistWindows valueForKey:identifier];
    if (oldWindow) {
        [self removeWindowWithIdentifier:identifier];
    }
    [self.assistWindows setObject:window forKey:identifier];
    return window;
}
//初始化自定义rootController window
- (void)makeKeyWindowWithRootViewController:(UIViewController *)rootViewController identifier:(NSString *)identifier{
    UIWindow *window = [self makeWindowWithIdentifier:identifier];
    window.rootViewController = rootViewController;
}
//获取widnow
- (UIWindow *)getWindowWithIdentifier:(NSString *)identifier{
    return [self.assistWindows valueForKey:identifier];
}
//移除window
- (void)deallocWindowWithIdentifier:(NSString *)identifier{
    [self removeWindowWithIdentifier:identifier];
}
//移除window
- (void)removeWindowWithIdentifier:(NSString *)identifier{
    UIWindow *window = [self.assistWindows valueForKey:identifier];
    window.hidden = YES;
    window.windowLevel = -1000;
    [window resignKeyWindow];
    [window removeFromSuperview];
    [self.assistWindows removeObjectForKey:identifier];
}
//是否存在window
- (BOOL)isAssistWindow:(UIWindow *)window{
    return [self.assistWindows.allValues containsObject:window];
}
//容错 移除所有生成window
- (void)removeAllWindows{
    for (NSString *identifier in self.assistWindows.allKeys) {
        [self removeWindowWithIdentifier:identifier];
    }
}
@end
