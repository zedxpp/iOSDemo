//
//  ViewController.m
//  指纹识别
//
//  Created by pengpeng on 2018/4/20.
//  Copyright © 2018年 swift520. All rights reserved.
//

#import "ViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self touchIDClick];
}

//evaluatedPolicyDomainState 每次指纹发生改变的时候，这个值就会改变，可以通过这个值的变化来判断是否有新的指纹录入

- (void)touchIDClick {
    LAContext *context = [[LAContext alloc] init];
    NSError *error = nil;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                localizedReason:@"伸出手指验证touchID"
                          reply:^(BOOL success, NSError *error) {
                              if (error) {
//                                  NSLog(@"操作失败");
                                  [self showHUDWithText:@"操作失败"];
                                  return;
                              }
                              if (success) {
//                                  NSLog(@"验证成功");
                                  [self showHUDWithText:@"验证成功"];
                              } else {
//                                  NSLog(@"验证失败");
                                  [self showHUDWithText:@"验证失败"];
                              }
                          }];
    } else {
//        NSLog(@"设备不支持");
        [self showHUDWithText:@"设备不支持"];
    }
    

}

- (void)showHUDWithText:(NSString *)text
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UILabel *label = [[UILabel alloc] init];
        label.text = text;
        [label sizeToFit];
        label.center = self.view.center;
        [self.view addSubview:label];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [label removeFromSuperview];
        });
    });
}


@end
