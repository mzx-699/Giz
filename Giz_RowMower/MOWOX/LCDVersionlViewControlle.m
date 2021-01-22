//
//  LCDModelViewControlle.m
//  Giz_Mower
//
//  Created by 安建伟 on 2020/8/26.
//  Copyright © 2020 yusz. All rights reserved.
//

#import "LCDVersionlViewControlle.h"
#import "LCDVersionHelplViewController.h"
#import "OneLCDModelViewController.h"
#import "TwoLCDModelViewController.h"

@interface LCDVersionlViewControlle ()

@property (nonatomic, strong) UIButton *lcdBtn_1;
@property (nonatomic, strong) UIButton *lcdBtn_2;

@property (strong, nonatomic) UIButton * bgViewBtn;

@property (strong, nonatomic) UIImageView *lcdModelImage;
@property (strong, nonatomic) UIImageView *leftImage;
@property (strong, nonatomic) UIImageView *rightImage;

@end

@implementation LCDVersionlViewControlle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavItem];
    UIImage *backImage = [UIImage imageNamed:@"loginView"];
    self.view.layer.contents = (id)backImage.CGImage;
    _lcdModelImage = [self lcdModelImage];
    _leftImage = [self leftImage];
    _rightImage = [self rightImage];
    _lcdBtn_1 = [self lcdBtn_1];
    _lcdBtn_2 = [self lcdBtn_2];
    _bgViewBtn = [self bgViewBtn];
    
}

- (void)setNavItem{
    self.navigationItem.title = LocalString(@"LCD Version");
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = LocalString(@"Back");
    self.navigationItem.backBarButtonItem = backItem;
    
}

- (UIImageView *)lcdModelImage{
    if (!_lcdModelImage) {
        _lcdModelImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_device_LCDhelp"]];
        [self.view addSubview:_lcdModelImage];
        
        [_lcdModelImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(300),yAutoFit(180)));
            make.top.equalTo(self.view.mas_top).offset(yAutoFit(80));
            make.centerX.equalTo(self.view.mas_centerX);
        }];
    }
    return _lcdModelImage;
}

- (UIImageView *)leftImage{
    if (!_leftImage) {
        _leftImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_arrow"]];
        [self.view addSubview:_leftImage];
        
        [_leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(50),yAutoFit(70)));
            make.top.equalTo(self.lcdModelImage.mas_bottom).offset(yAutoFit(30));
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
            make.top.equalTo(self.lcdModelImage.mas_bottom).offset(yAutoFit(30));
            make.left.equalTo(self.view.mas_centerX).offset(yAutoFit(40));
        }];
    }
    return _rightImage;
}

- (UIButton *)lcdBtn_1{
    if (!_lcdBtn_1) {
        
        _lcdBtn_1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_lcdBtn_1 setBackgroundImage:[UIImage imageNamed:@"img_LCDmodel1_btn"] forState:UIControlStateNormal];
        [_lcdBtn_1 addTarget:self action:@selector(nextLCDOne) forControlEvents:UIControlEventTouchUpInside];
        _lcdBtn_1.enabled = YES;
        [self.view addSubview:_lcdBtn_1];
        [_lcdBtn_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(80), yAutoFit(80.f)));
            make.top.equalTo(self.leftImage.mas_bottom).offset(yAutoFit(30.f));
            make.right.mas_equalTo(self.view.mas_centerX).offset(yAutoFit(-20));
        }];
        
    }
    return _lcdBtn_1;
}

- (UIButton *)lcdBtn_2{
    if (!_lcdBtn_2) {
        
        _lcdBtn_2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_lcdBtn_2 setBackgroundImage:[UIImage imageNamed:@"img_LCDmodel2_btn"] forState:UIControlStateNormal];
        [_lcdBtn_2 addTarget:self action:@selector(nextLCDTwo) forControlEvents:UIControlEventTouchUpInside];
        _lcdBtn_2.enabled = YES;
        [self.view addSubview:_lcdBtn_2];
        [_lcdBtn_2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(80), yAutoFit(80.f)));
            make.top.equalTo(self.leftImage.mas_bottom).offset(yAutoFit(30.f));
            make.left.mas_equalTo(self.view.mas_centerX).offset(yAutoFit(20));
        }];
   
    }
    return _lcdBtn_2;
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
            make.top.equalTo(self.lcdBtn_2.mas_bottom).offset(yAutoFit(50));
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

-(void)nextLCDOne{
    OneLCDModelViewController *OneVC = [[OneLCDModelViewController alloc] init];
    [self.navigationController pushViewController:OneVC animated:YES];
    
}

- (void)nextLCDTwo{
    
    TwoLCDModelViewController *TwoVC = [[TwoLCDModelViewController alloc]  init];
    [self.navigationController pushViewController:TwoVC animated:YES];
    
}


- (void)goHelp{
    
    LCDVersionHelplViewController *HelpVC = [[LCDVersionHelplViewController alloc] init];
    [self.navigationController pushViewController:HelpVC animated:YES];
    
}


@end
