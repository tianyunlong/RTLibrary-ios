//
//  UserEntity.h
//  RTLibrary-ios
//
//  Created by Ryan on 14-8-3.
//  Copyright (c) 2014年 zlycare. All rights reserved.
//

#import "BaseEntity.h"

@interface UserEntity : BaseEntity

@property (nonatomic,copy) NSString *phone;//手机号
@property (nonatomic,copy) NSString *sessionToken;//token

@end
