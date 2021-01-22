//
//  OneSimpleModelViewController.m
//  Giz_Mower
//
//  Created by 安建伟 on 2020/8/26.
//  Copyright © 2020 yusz. All rights reserved.
//

#import "OneSimpleModelViewController.h"
#import "OneSimpleModelHelpViewController.h"
#import "AirLinkViewController.h"

@interface OneSimpleModelViewController ()
@property (strong, nonatomic) UIImageView *oneModelImage;
@property (nonatomic, strong) UIButton *connectBtn;
@property (strong, nonatomic) UIButton * bgViewBtn;

@end

@implementation OneSimpleModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavItem];
    UIImage *backImage = [UIImage imageNamed:@"loginView"];
    self.view.layer.contents = (id)backImage.CGImage;
    
    _oneModelImage = [self oneModelImage];
    _connectBtn = [self connectBtn];
    _bgViewBtn = [self bgViewBtn];
}

- (void)setNavItem{
    self.navigationItem.title = LocalString(@"Model 1");
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = LocalString(@"Back");
    self.navigationItem.backBarButtonItem = backItem;
}


- (UIImageView *)oneModelImage{
    if (!_oneModelImage) {
        _oneModelImage = [[UIImageView alloc] init];
        [self.view addSubview:_oneModelImage];
        [_oneModelImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(300),yAutoFit(350)));
            make.top.equalTo(self.view.mas_top).offset(yAutoFit(80.f));
            make.centerX.equalTo(self.view.mas_centerX);
        }];
        
        UIImageView *upImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_model1_help_up"]];
        [_oneModelImage addSubview:upImage];
        [upImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(280),yAutoFit(200)));
            make.top.equalTo(self.oneModelImage.mas_top).offset(yAutoFit(5.f));
            make.centerX.equalTo(self.oneModelImage.mas_centerX);
        }];
        
        UITextView *upText = [[UITextView alloc] init];
        upText.font = [UIFont systemFontOfSize:17.f];
        upText.backgroundColor = [UIColor clearColor];
        upText.textColor = [UIColor whiteColor];
        upText.textAlignment = NSTextAlignmentLeft;
        upText.text = LocalString(@"1.Turn on your Robot\n2.Unlock the keyboard;\n3.Press the button “Wi-Fi” for 5seconds,till the LED light flashing(fast)\n4.Press the “CONNECT” button");
        [_oneModelImage addSubview:upText];
        [upText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(280), yAutoFit(100)));
            make.centerX.equalTo(self.oneModelImage.mas_centerX);
            make.top.mas_equalTo(upImage.mas_bottom).offset(yAutoFit(10));
        }];
        
        _oneModelImage.layer.borderWidth = 1.0;
        _oneModelImage.layer.borderColor = [UIColor whiteColor].CGColor;
        _oneModelImage.layer.cornerRadius = 10.f/HScale;
        
    }
    return _oneModelImage;
}

- (UIButton *)connectBtn{
    if (!_connectBtn) {
        _connectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_connectBtn setBackgroundImage:[UIImage imageNamed:@"img_connect_Btn"] forState:UIControlStateNormal];
        //[_connectBtn setTitle:LocalString(@"Next") forState:UIControlStateNormal];
        //[_connectBtn.titleLabel setFont:[UIFont systemFontOfSize:18.f]];
        //[_connectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_connectBtn setBackgroundColor:[UIColor clearColor]];
        [_connectBtn addTarget:self action:@selector(goConnect) forControlEvents:UIControlEventTouchUpInside];
        _connectBtn.enabled = YES;
        [self.view addSubview:_connectBtn];
        [_connectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(280), yAutoFit(50)));
            make.top.equalTo(self.oneModelImage.mas_bottom).offset(yAutoFit(30));
            make.centerX.mas_equalTo(self.view.mas_centerX);
        }];
        
    }
    return _connectBtn;
}

- (UIButton *)bgViewBtn{
    if (!_bgViewBtn) {
        _bgViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _bgViewBtn.backgroundColor = [UIColor clearColor];
        [_bgViewBtn addTarget:self action:@selector(goOneHelp) forControlEvents:UIControlEventTouchUpInside];
        _bgViewBtn.enabled = YES;
        [self.view addSubview:_bgViewBtn];
        [_bgViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(120), yAutoFit(50)));
            make.left.equalTo(self.view.mas_centerX).offset(yAutoFit(50.f));
            make.top.equalTo(self.connectBtn.mas_bottom).offset(yAutoFit(20));
        }];
        
        UIImageView *helpImg = [[UIImageView alloc] init];
        [helpImg setImage:[UIImage imageNamed:@"img_help"]];
        [_bgViewBtn addSubview:helpImg];
        [helpImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(20), yAutoFit(20)));
            make.left.equalTo(self.bgViewBtn.mas_left).offset(yAutoFit(10));
            make.centerY.equalTo(self.bgViewBtn.mas_centerY);
        }];

        UILabel *helplabel = [[UILabel alloc] init];
        helplabel.text = LocalString(@"Help");
        helplabel.font = [UIFont systemFontOfSize:20.f];
        helplabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        helplabel.textAlignment = NSTextAlignmentCenter;
        helplabel.adjustsFontSizeToFitWidth = YES;
        [_bgViewBtn addSubview:helplabel];
        [helplabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(30), yAutoFit(20)));
            make.centerY.equalTo(self.bgViewBtn.mas_centerY);
            make.left.equalTo(helpImg.mas_right).offset(yAutoFit(10));
        }];
        
    }
    return _bgViewBtn;
}

-(void)goConnect{
    
    AirLinkViewController *VC = [[AirLinkViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)goOneHelp{
    
    OneSimpleModelHelpViewController *HelpVC = [[OneSimpleModelHelpViewController alloc] init];
    [self.navigationController pushViewController:HelpVC animated:YES];
}

@end
