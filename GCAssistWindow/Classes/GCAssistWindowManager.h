//
//  GCAssistWindowManager.h
//  FBSnapshotTestCase
//
//  Created by yons on 2020/8/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GCAssistWindowManager : NSObject
/// window
@property (nonatomic, strong) NSMutableDictionary *assistWindows;
/// 单例
+ (instancetype)manager;
/// 创建window
/// @param identifier 标识
- (UIWindow *)makeWindowWithIdentifier:(NSString *)identifier;
/// 创建新视图
/// @param rootViewController 跟视图
/// @param identifier 标识
- (void)makeKeyWindowWithRootViewController:(UIViewController *)rootViewController identifier:(NSString *)identifier;
/// 获取widnow
/// @param identifier 标识
- (UIWindow *)getWindowWithIdentifier:(NSString *)identifier;
/// 移除window
/// @param identifier 标识
- (void)deallocAssistWindowWithIdentifier:(NSString *)identifier;
/// 是否是协助window
/// @param window window
- (BOOL)isAssistWindow:(UIWindow *)window;
/// 移除所有协助window
/*
Tips:keyWindow.rootViewController设置值时需要确认不是协助window

无法确定就调用此方法。

不执行可能会造成设置rootViewController设置不到默认window
*/
- (void)removeAllAssistWindows;
@end

NS_ASSUME_NONNULL_END
