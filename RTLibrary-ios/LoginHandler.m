//
//  LoginHandler.m
//  RTLibrary-ios
//
//  Created by Ryan on 14-8-3.
//  Copyright (c) 2014年 zlycare. All rights reserved.
//

#import "LoginHandler.h"
#import "RTHttpClient.h"
#import "APIConfig.h"
#import "AppUtils.h"
#import "UserEntity.h"
#import "LoginView.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface LoginHandler ()<MBProgressHUDDelegate>{
    MBProgressHUD *_hud;
}

@end


@implementation LoginHandler

/**
 *  用户登录业务逻辑处理
 *
 *  @param username 手机号
 *  @param password  密码
 *  @param view
 *  @param success
 *  @param failed
 */
- (void)executeLoginTaskWithUserName:(NSString*)username password:(NSString*)password inView:(LoginView*)view  success:(SuccessBlock)success failed:(FailedBlock)failed{
    RTHttpClient *rtHttpClient = [RTHttpClient new];
    [rtHttpClient requestWithPath:[BaseHandler requestUrlWithPath:API_LOGIN]
                           method:RTHttpRequestPost
                       parameters:[LoginHandler jsonWithUserName:username password:password]
                   prepareExecute:^(void){
                       [self showHUD:@"登录中..." inView:view];
                   }
                          success:^(NSURLSessionDataTask *task, id responseObject){
                              [self hudWasHidden];
                              BaseEntity *baseEntity = [[BaseEntity alloc] initWithDictionary:[responseObject objectForKey:@"query"] error:nil];
                              if (0 == baseEntity.code) {
                                  UserEntity *loginModel = [[UserEntity alloc] initWithDictionary:[responseObject objectForKey:@"data"] error:nil];
                                  success(loginModel);
                              }else{
                                  [LoginHandler showError:baseEntity.msg toView:(UIView*)view];
                              }
                          }
                          failure:^(NSURLSessionDataTask *task, NSError *error){
                              [self hudWasHidden];
                              [self showExceptionDialog];
                              
                          }];

}
//弹出网络错误提示框
- (void)showExceptionDialog
{
    [[[UIAlertView alloc] initWithTitle:@"提示"
                                message:@"网络异常，请检查网络连接"
                               delegate:self
                      cancelButtonTitle:@"好的"
                      otherButtonTitles:nil, nil] show];
}
#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = error;
    
    hud.mode = MBProgressHUDModeText;
    hud.margin = 10.f;
    
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:2];
    
}
//登录
+(NSDictionary*)jsonWithUserName:(NSString*)username password:(NSString*)password{
    return [NSDictionary dictionaryWithObjectsAndKeys:username,@"phone",password,@"password", nil];
}

- (void)showHUD:(NSString*)title inView:(LoginView*)view{
    
   // UIWindow *window =  [UIApplication sharedApplication].keyWindow;
    
    _hud = [[MBProgressHUD alloc] initWithView:view];
    _hud.color = [[UIColor alloc]initWithRed:0 green:0 blue:0 alpha:0.7];
    _hud.labelText = title;
    [view addSubview:_hud];
    _hud.delegate = self;
    _hud.margin = 10;
    [_hud show:YES];
    
}
- (void)hudWasHidden{
    if (_hud != nil) {
        [_hud removeFromSuperview];
        _hud = nil;
    }
}
@end
