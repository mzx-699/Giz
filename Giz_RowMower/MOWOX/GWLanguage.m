//
//  GWLanguage.m
//  Giz_Mower
//
//  Created by apple on 2020/12/23.
//  Copyright © 2020 yusz. All rights reserved.
//

#import "GWLanguage.h"
#import "NSBundle+language.h"

@implementation GWLanguage
+ (GWLanguage *)sharedInstance {
    static GWLanguage *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[GWLanguage alloc] init];
    });
    return instance;
}

- (void)initLanguage{
    NSString *language=[self currentLanguage];
    if (language.length>0) {
        NSLog(@"自设置语言:%@",language);
    }else{
        [self systemLanguage];
    }
}
- (NSString *)currentLanguage{
    NSString *language=[[NSUserDefaults standardUserDefaults]objectForKey:AppLanguage];
    return language;
}
- (void)setLanguage:(NSString *)language{
    [NSBundle setLanguage:language];
    
    [[NSUserDefaults standardUserDefaults] setObject:language forKey:AppLanguage];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)systemLanguage{
    NSString *languageCode = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"][0];
    NSLog(@"系统语言:%@",languageCode);
    if([languageCode hasPrefix:@"zh-Hans"]){
        languageCode = @"zh-Hans";//简体中文
    }else if([languageCode hasPrefix:@"en"]){
        languageCode = @"en";//英语
    }
    [self setLanguage:languageCode];
}

@end
