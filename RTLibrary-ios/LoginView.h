//
//  LoginView.h
//  RTLibrary-ios
//
//  Created by Ryan on 14-8-3.
//  Copyright (c) 2014年 zlycare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UIView<UITextFieldDelegate>

@property(strong,nonatomic)UITextField *userNameField;
@property(strong,nonatomic)UITextField *passwordField;
@property(strong,nonatomic)NSNumber *isConnected;
@property(strong,nonatomic)UIButton *loginButton;

@property(copy,nonatomic) void(^loginClick)(NSString* username ,NSString* password,LoginView *loginView);

@end
