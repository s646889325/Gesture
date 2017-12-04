//
//  Tool.m
//  手势解锁
//
//  Created by qyhc on 17/8/17.
//  Copyright © 2017年 com.qykj. All rights reserved.
//

#import "Tool.h"

@implementation Tool

#pragma mark - 弹出Alert
+ (void)showAlertControllerWithViewController:(UIViewController *)viewController
                                   alertStyle:(UIAlertControllerStyle)alertStyle
                                        title:(NSString *)title
                                      message:(NSString *)message
                                  alertAction:(NSArray *)alertActionArray
                                     isCancel:(BOOL)isCancel
                                  cancelBlock:(void(^)(UIAlertAction *action))handler{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:alertStyle];
    for (NSInteger i = 0 ; i < alertActionArray.count; i ++ ) {
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:alertActionArray[i][actionTitle] style:[alertActionArray[i][actionStyle] integerValue] handler:alertActionArray[i][actionBlock]];
        [alert addAction:alertAction];
    }
    
    if (isCancel) {
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:handler];
        [alert addAction:cancel];
    }
    
    [viewController presentViewController:alert animated:YES completion:nil];
}

@end
