//
//  SimpleModelViewController.m
//  Giz_Mower
//
//  Created by 安建伟 on 2020/8/26.
//  Copyright © 2020 yusz. All rights reserved.
//

#import "SimpleVersionViewController.h"
#import "SimpleModeHelplViewController.h"
#import "OneSimpleModelViewController.h"
#import "TwoSimpleModelViewController.h"

@interface SimpleVersionViewController ()

@property (nonatomic, strong) UIButton *simpleBtn_1;
@property (nonatomic, strong) UIButton *simpleBtn_2;

@property (strong, nonatomic) UIButton * bgViewBtn;

@property (strong, nonatomic) UIImageView *simpleModelImage;
@property (strong, nonatomic) UIImageView *leftImage;
@property (strong, nonatomic) UIImageView *rightImage;

@end

@implementation SimpleVersionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavItem];
    UIImage *backImage = [UIImage imageNamed:@"loginView"];
    self.view.layer.contents = (id)backImage.CGImage;
    _simpleModelImage = [self simpleModelImage];
    _leftImage = [self leftImage];
    _rightImage = [self rightImage];
    _simpleBtn_1 = [self simpleBtn_1];
    _simpleBtn_2 = [self simpleBtn_2];
    _bgViewBtn = [self bgViewBtn];
    
}

- (void)setNavItem{
    self.navigationItem.title = LocalString(@"Simple Version");
    
}

- (UIImageView *)simpleModelImage{
    if (!_simpleModelImage) {
        _simpleModelImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_device_Simplehelp"]];
        [self.view addSubview:_simpleModelImage];
        
        [_simpleModelImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(300),yAutoFit(180)));
            make.top.equalTo(self.view.mas_top).offset(yAutoFit(80));
            make.centerX.equalTo(self.view.mas_centerX);
        }];
    }
    return _simpleModelImage;
}

- (UIImageView *)leftImage{
    if (!_leftImage) {
        _leftImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_arrow"]];
        [self.view addSubview:_leftImage];
        
        [_leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(50),yAutoFit(70)));
            make.top.equalTo(self.simpleModelImage.mas_bottom).offset(yAutoFit(30));
            make.right.equalTo(self.view.mas_centerX).offset(yAutoFit(-40));
        }];
    }
    return _leftImage;
}

- (UIImageView *)rightImage{
    if (!_rightImage) {
        _rightImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_arrow"]];
        [self.view addSubview:_rightImage];
        
        [_rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(50),yAutoFit(70)));
            make.top.equalTo(self.simpleModelImage.mas_bottom).offset(yAutoFit(30));
            make.left.equalTo(self.view.mas_centerX).offset(yAutoFit(40));
        }];
    }
    return _rightImage;
}

- (UIButton *)simpleBtn_1{
    if (!_simpleBtn_1) {
        
        _simpleBtn_1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_simpleBtn_1 setBackgroundImage:[UIImage imageNamed:@"img_model1_btn"] forState:UIControlStateNormal];
        [_simpleBtn_1 addTarget:self action:@selector(nextSimpleOne) forControlEvents:UIControlEventTouchUpInside];
        _simpleBtn_1.enabled = YES;
        [self.view addSubview:_simpleBtn_1];
        [_simpleBtn_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(80), yAutoFit(80.f)));
            make.top.equalTo(self.leftImage.mas_bottom).offset(yAutoFit(30.f));
            make.right.mas_equalTo(self.view.mas_centerX).offset(yAutoFit(-20));
        }];
        
    }
    return _simpleBtn_1;
}

- (UIButton *)simpleBtn_2{
    if (!_simpleBtn_2) {
        
        _simpleBtn_2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_simpleBtn_2 setBackgroundImage:[UIImage imageNamed:@"img_model2_btn"] forState:UIControlStateNormal];
        [_simpleBtn_2 addTarget:self action:@selector(nextSimpleTwo) forControlEvents:UIControlEventTouchUpInside];
        _simpleBtn_2.enabled = YES;
        [self.view addSubview:_simpleBtn_2];
        [_simpleBtn_2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(80), yAutoFit(80.f)));
            make.top.equalTo(self.leftImage.mas_bottom).offset(yAutoFit(30.f));
            make.left.mas_equalTo(self.view.mas_centerX).offset(yAutoFit(20));
        }];
   
    }
    return _simpleBtn_2;
}

- (UIButton *)bgViewBtn{
    if (!_bgViewBtn) {
        _bgViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _bgViewBtn.backgroundColor = [UIColor clearColor];
        [_bgViewBtn addTarget:self action:@selector(goHelp) forControlEvents:UIControlEventTouchUpInside];
        _bgViewBtn.enabled = YES;
        [self.view addSubview:_bgViewBtn];
        [_bgViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(120), yAutoFit(50)));
            make.left.equalTo(self.view.mas_centerX).offset(yAutoFit(50.f));
            make.top.equalTo(self.simpleBtn_2.mas_bottom).offset(yAutoFit(50));
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

-(void)nextSimpleOne{
    OneSimpleModelViewController *OneVC = [[OneSimpleModelViewController alloc] init];
    [self.navigationController pushViewController:OneVC animated:YES];
    
}

- (void)nextSimpleTwo{
    
    TwoSimpleModelViewController *TwoVC = [[TwoSimpleModelViewController alloc]  init];
    [self.navigationController pushViewController:TwoVC animated:YES];
    
}


- (void)goHelp{
    
    SimpleModeHelplViewController *HelpVC = [[SimpleModeHelplViewController alloc] init];
    [self.navigationController pushViewController:HelpVC animated:YES];
    
}

@end
