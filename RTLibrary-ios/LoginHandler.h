//
//  LoginHandler.h
//  RTLibrary-ios
//
//  Created by Ryan on 14-8-3.
//  Copyright (c) 2014年 zlycare. All rights reserved.
//

#import "BaseHandler.h"
#import "UserEntity.h"

@class LoginView;

@interface LoginHandler : BaseHandler

/**
 *  用户登录业务逻辑处理
 *
 *  @param username 手机号
 *  @param password  密码
 *  @param view
 *  @param success
 *  @param failed
 */
- (void)executeLoginTaskWithUserName:(NSString*)username password:(NSString*)password inView:(LoginView*)view  success:(SuccessBlock)success failed:(FailedBlock)failed;

@end
