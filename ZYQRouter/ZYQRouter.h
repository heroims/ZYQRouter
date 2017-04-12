//
//  ZYQRouter.h
//  ZYQRouter
//
//  Created by Zhao Yiqi on 2016/11/25.
//  Copyright © 2016年 Zhao Yiqi. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const ZYQRouterParameterURL;
extern NSString *const ZYQRouterParameterCompletion;
extern NSString *const ZYQRouterParameterUserInfo;

typedef enum ZYQNotFoundHandlerError:NSInteger{
    ZYQNotFoundHandlerError_NotFoundTarget=0,
    ZYQNotFoundHandlerError_NotFoundAction
}ZYQNotFoundHandlerError;

/**
 *  routerParameters 里内置的几个参数会用到上面定义的 string
 */
typedef void (^ZYQRouterHandler)(NSDictionary *routerParameters);

/**
 *  需要返回一个 object，配合 objectForURL: 使用
 */
typedef id (^ZYQRouterObjectHandler)(NSDictionary *routerParameters);

/**
 *  没有找到对应方法的回调
 */
typedef id (^ZYQNotFoundTargetActionHandler)(ZYQNotFoundHandlerError error,NSArray *objectsArr);

@interface ZYQRouter : NSObject

#pragma mark - URL Router -
/**
 重定向 URLPattern 到对应的 newURLPattern 

 @param URLPattern 原scheme
 @param newURLPattern 新scheme
 */
+ (void)redirectURLPattern:(NSString *)URLPattern toURLPattern:(NSString*)newURLPattern;

/**
 *  注册 URLPattern 对应的 Handler，在 handler 中可以初始化 VC，然后对 VC 做各种操作
 *
 *  @param URLPattern 带上 scheme，如 applink://beauty/:id
 *  @param handler    该 block 会传一个字典，包含了注册的 URL 中对应的变量。
 *                    假如注册的 URL 为 applink://beauty/:id 那么，就会传一个 @{@"id": 4} 这样的字典过来
 */
+ (void)registerURLPattern:(NSString *)URLPattern toHandler:(ZYQRouterHandler)handler;

/**
 *  注册 URLPattern 对应的 ObjectHandler，需要返回一个 object 给调用方
 *
 *  @param URLPattern 带上 scheme，如 applink://beauty/:id
 *  @param handler    该 block 会传一个字典，包含了注册的 URL 中对应的变量。
 *                    假如注册的 URL 为 applink://beauty/:id 那么，就会传一个 @{@"id": 4} 这样的字典过来
 *                    自带的 key 为 @"url" 和 @"completion" (如果有的话)
 */
+ (void)registerURLPattern:(NSString *)URLPattern toObjectHandler:(ZYQRouterObjectHandler)handler;

/**
 *  取消注册某个 URL Pattern
 *
 *  @param URLPattern
 */
+ (void)deregisterURLPattern:(NSString *)URLPattern;

/**
 注册未找到处理Url的处理
 
 @param handle  该 block 会传一个字典，包含了注册的 URL 中对应的变量。
 假如注册的 URL 为 applink://beauty/:id 那么，就会传一个 @{@"id": 4} 这样的字典过来
 */
+ (void)registerUnFoundURLPatternToObjectHandler:(ZYQRouterObjectHandler)handle;

/**
 注册未找到处理Url的处理
 
 @param handle  该 block 会传一个字典，包含了注册的 URL 中对应的变量。
 假如注册的 URL 为 applink://beauty/:id 那么，就会传一个 @{@"id": 4} 这样的字典过来
 自带的 key 为 @"url" 和 @"completion" (如果有的话)
 */
+ (void)registerUnFoundURLPatternToHandler:(ZYQRouterHandler)handler;

/**
 取消未找到处理Url的处理
 */
+ (void)deregisterUnFoundURLPatternToHandler;

/**
 *  打开此 URL
 *  会在已注册的 URL -> Handler 中寻找，如果找到，则执行 Handler
 *
 *  @param URL 带 Scheme，如 applink://beauty/3
 */
+ (void)openURL:(NSString *)URL;

/**
 *  打开此 URL，同时当操作完成时，执行额外的代码
 *
 *  @param URL        带 Scheme 的 URL，如 applink://beauty/4
 *  @param completion URL 处理完成后的 callback，完成的判定跟具体的业务相关
 */
+ (void)openURL:(NSString *)URL completion:(void (^)(id result))completion;

/**
 *  打开此 URL，带上附加信息，同时当操作完成时，执行额外的代码
 *
 *  @param URL        带 Scheme 的 URL，如 applink://beauty/4
 *  @param parameters 附加参数
 *  @param completion URL 处理完成后的 callback，完成的判定跟具体的业务相关
 */
+ (void)openURL:(NSString *)URL withUserInfo:(NSDictionary *)userInfo completion:(void (^)(id result))completion;

/**
 * 查找谁对某个 URL 感兴趣，如果有的话，返回一个 object
 *
 *  @param URL
 */
+ (id)objectForURL:(NSString *)URL;

/**
 * 查找谁对某个 URL 感兴趣，如果有的话，返回一个 object
 *
 *  @param URL
 *  @param userInfo
 */
+ (id)objectForURL:(NSString *)URL withUserInfo:(NSDictionary *)userInfo;

/**
 *  是否可以打开URL
 *
 *  @param URL
 *
 *  @return
 */
+ (BOOL)canOpenURL:(NSString *)URL;

/**
 *  调用此方法来拼接 urlpattern 和 parameters
 *
 *  #define ROUTE_BEAUTY @"beauty/:id"
 *  [ZYQRouter generateURLWithPattern:ROUTE_BEAUTY, @[@13]];
 *
 *
 *  @param pattern    url pattern 比如 @"beauty/:id"
 *  @param parameters 一个数组，数量要跟 pattern 里的变量一致
 *
 *  @return
 */
+ (NSString *)generateURLWithPattern:(NSString *)pattern parameters:(NSArray *)parameters;

#pragma mark - Target Action 安全调度 -

/**
 *
 *  调度工程内的组件方法
 *  [ZYQRouter performTarget:@"xxxClass" action:@"xxxxActionWithObj1:obj2:obj3" objects:obj1,obj2,obj3,nil]
 *  内部自动 alloc init 初始化对象
 *
 *  @param targetName    执行方法的类
 *  @param actionName    方法名
 *  @param object1,... 不定参数 不支持C基本类型
 *
 *  @return 方法回参
 */
+ (id)performTarget:(NSString*)targetName action:(NSString*)actionName objects:(id)object1,...;

/**
 *
 *  调度工程内的组件方法
 *  [ZYQRouter performTarget:@"xxxClass" action:@"xxxxActionWithObj1:obj2:obj3" shouldCacheTaget:YES objects:obj1,obj2,obj3,nil]
 *  内部自动 alloc init 初始化对象
 *
 *  @param targetName    执行方法的类
 *  @param actionName    方法名
 *  @param shouldCacheTaget   设置target缓存
 *  @param object1,... 不定参数 不支持C基本类型
 *
 *  @return 方法回参
 */
+ (id)performTarget:(NSString*)targetName action:(NSString*)actionName shouldCacheTaget:(BOOL)shouldCacheTaget objects:(id)object1,...;

/**
 *
 *  调度工程内的组件方法
 *  [ZYQRouter performTarget:@"xxxClass" action:@"xxxxActionWithObj1:obj2:obj3" shouldCacheTaget:YES objects:obj1,obj2,obj3,nil]
 *  内部自动 alloc init 初始化对象
 *
 *  @param targetName    执行方法的类
 *  @param actionName    方法名
 *  @param shouldCacheTaget   设置target缓存
 *  @param objectsArr   参数数组 不支持C基本类型
 *
 *  @return 方法回参
 */
+ (id)performTarget:(NSString*)targetName action:(NSString*)actionName shouldCacheTaget:(BOOL)shouldCacheTaget objectsArr:(NSArray*)objectsArr;

/**
 *
 *  添加未找到Target 或 Action 逻辑
 *
 *  @param notFoundHandler    未找到方法回调
 *  @param targetName    类名
 *
 *  @return
 */
+ (void)addNotFoundHandler:(ZYQNotFoundTargetActionHandler)notFoundHandler targetName:(NSString*)targetName;

/**
 *  删除Target缓存
 *
 *  @return
 */
+ (void)removeTargetsCacheWithTargetName:(NSString*)targetName;
+ (void)removeTargetsCacheWithTargetNames:(NSArray*)targetNames;
+ (void)removeAllTargetsCache;
@end

/**
 不定参静态方法调用 （最多支持7个，原因不定参方法传给不定参方法实在没啥好办法。。。。暂时如此）
 id result=(__bridge_transfer id)invokeSelectorObjects(@"Class", @"actionWithObj1:obj2:obj3",obj1,obj2,obj3,nil);
 
 c类型转换配合__bridge_transfer __bridge_retained
 利用IMP返回值只是指针，不支持C基本类型
 
 @param className 类名
 @param selectorName,... 方法名，不定参数
 @return 返回值
 */
void * invokeSelectorObjects(NSString *className,NSString* selectorName,...);

@interface NSObject (ZYQRouter)

/**
 不定参方法调用
 [self performSelector:@selector(actionWithObj1:obj2:obj3:) withObjects:obj1,obj2,obj3,nil]
 
 @param selector 方法名
 @param object1,... 不定参数 不支持C基本类型
 @return 返回值
 */
-(id)performSelector:(SEL)selector withObjects:(id)object1,... ;


/**
 不定参方法调用

 @param selector 方法名
 @param objects 参数数组 不支持C基本类型
 @return 返回值
 */
-(id)performSelector:(SEL)selector withObjectsArray:(NSArray *)objects ;

@end
