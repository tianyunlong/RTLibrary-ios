//
//  LoginViewController.m
//  RTLibrary-ios
//
//  Created by Ryan on 14-8-3.
//  Copyright (c) 2014年 zlycare. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "AppUtils.h"
#import "Color.h"
#import "LoginHandler.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初始化LoginView，设置LoginViewDelegate处理登录视图的事件
    
    //在视图代理方法里通过调用LoginHandler处理登录业务逻辑，发起网络请求和结果处理均在LoginHandler中完成
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    self.title = @"登录";
    self.view.backgroundColor = [AppUtils colorWithHexString:k_COLOR_LOGIN_BACKGROUND];
    
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
    LoginView *loginView = [[LoginView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:loginView];
    
    loginView.loginClick = ^(NSString *username,NSString *password,LoginView *loginView){
        if ([AppUtils checkPhoneNumber:username]) {
            LoginHandler *loginHandle = [[LoginHandler alloc] init];
            [loginHandle executeLoginTaskWithUserName:username
                                             password:password
                                               inView:loginView
                                              success:^(id obj){
                                                  NSLog(@"登录");
                                              }
                                               failed:^(id obj){
                                                   
                                               }];
        }else{
           // [MBProgressHUD showError:@"请输入正确的手机号码" toView:self.view];
        }
    };
    
}

@end
