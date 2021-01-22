//
//  GWLanguage.h
//  Giz_Mower
//
//  Created by apple on 2020/12/23.
//  Copyright © 2020 yusz. All rights reserved.
//

#import <Foundation/Foundation.h>


static NSString * const AppLanguage = @"appLanguage";

@interface GWLanguage : NSObject
+ (GWLanguage *)sharedInstance;

//初始化多语言功能
- (void)initLanguage;

//当前语言
- (NSString *)currentLanguage;

//设置要转换的语言
- (void)setLanguage:(NSString *)language;

//设置为系统语言
- (void)systemLanguage;

@end
