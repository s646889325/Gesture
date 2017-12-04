//
//  Tool.h
//  手势解锁
//
//  Created by qyhc on 17/8/17.
//  Copyright © 2017年 com.qykj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static NSString *actionTitle = @"actionTitle";
static NSString *actionStyle = @"actiontStyle";
static NSString *actionBlock = @"actionBlock";

@interface Tool : NSObject


#pragma mark - 弹出Alert
/**
 *  弹出一个Alert
 *
 *  @param viewController   需要弹出的VC
 *  @param alertStyle       alertStyle
 *  @param title            alertTitle
 *  @param message          alertMessage
 *  @param alertActionArray alertActionArray : 数组里是字典 需要包含 actionTitle、actiontStyle、actionBlock
 *  @param isCancel         是否需要取消键
 *  @param handler      取消的 Block 回调 可为nil
 */

+ (void)showAlertControllerWithViewController:(UIViewController *)viewController
                                   alertStyle:(UIAlertControllerStyle)alertStyle
                                        title:(NSString *)title
                                      message:(NSString *)message
                                  alertAction:(NSArray *)alertActionArray
                                     isCancel:(BOOL)isCancel
                                  cancelBlock:(void(^)(UIAlertAction *action))handler;

@end
