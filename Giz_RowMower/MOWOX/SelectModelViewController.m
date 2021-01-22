//
//  SelectModelViewController.m
//  Giz_Mower
//
//  Created by 安建伟 on 2020/8/26.
//  Copyright © 2020 yusz. All rights reserved.
//

#import "SelectModelViewController.h"
#import "AddDeviceHelpViewController.h"
#import "SimpleVersionViewController.h"
#import "LCDVersionlViewControlle.h"


@interface SelectModelViewController ()

@property (nonatomic, strong) UILabel *tipLabel;

@property (nonatomic, strong) UIButton *simpleBtn;
@property (nonatomic, strong) UIButton *lcdBtn;
//@property (nonatomic, strong) UIButton *nextBtn;
@property (strong, nonatomic) UIButton * bgViewBtn;

@property (strong, nonatomic)  UIImageView *deviceImage;

@end

@implementation SelectModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavItem];
    UIImage *backImage = [UIImage imageNamed:@"loginView"];
    self.view.layer.contents = (id)backImage.CGImage;
    _deviceImage = [self deviceImage];
    _tipLabel = [self tipLabel];
    //_Label_2 = [self Label_2];
    
    //_nextBtn = [self nextBtn];
    _simpleBtn = [self simpleBtn];
    _lcdBtn = [self lcdBtn];
    _bgViewBtn = [self bgViewBtn];
    
}

- (void)setNavItem{
    self.navigationItem.title = LocalString(@"Add Robot");
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = LocalString(@"Back");
    self.navigationItem.backBarButtonItem = backItem;
    
}

- (UIImageView *)deviceImage{
    if (!_deviceImage) {
        _deviceImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_device"]];
        [self.view addSubview:_deviceImage];
        
        [_deviceImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(300),yAutoFit(180)));
            make.top.equalTo(self.view.mas_top).offset(yAutoFit(80));
            make.centerX.equalTo(self.view.mas_centerX);
        }];
    }
    return _deviceImage;
}

- (UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.font = [UIFont systemFontOfSize:17.f];
        _tipLabel.backgroundColor = [UIColor clearColor];
        _tipLabel.textColor = [UIColor whiteColor];
        _tipLabel.text = LocalString(@"Choose the correct model of your robotic mower.");
        //自动折行设置
        [_tipLabel setLineBreakMode:NSLineBreakByWordWrapping];
        _tipLabel.numberOfLines = 0;
        _tipLabel.textAlignment = NSTextAlignmentLeft;
        _tipLabel.adjustsFontSizeToFitWidth = YES;
        [self.view addSubview:_tipLabel];
        [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(280/WScale,60/HScale));
            make.top.equalTo(self.view.mas_top).offset(300/HScale);
            make.centerX.mas_equalTo(self.view.mas_centerX);
        }];

    }
    return _tipLabel;
}

- (UIButton *)simpleBtn{
    if (!_simpleBtn) {
        
        _simpleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_simpleBtn setBackgroundImage:[UIImage imageNamed:@"img_simple_Btn"] forState:UIControlStateNormal];
        [_simpleBtn addTarget:self action:@selector(nextSimple) forControlEvents:UIControlEventTouchUpInside];
        _simpleBtn.enabled = YES;
        [self.view addSubview:_simpleBtn];
        [_simpleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(80), yAutoFit(80.f)));
            make.top.equalTo(self.tipLabel.mas_bottom).offset(yAutoFit(30.f));
            make.right.mas_equalTo(self.view.mas_centerX).offset(yAutoFit(-20));
        }];
        
        UILabel *simplelabel = [[UILabel alloc] init];
        simplelabel.text = LocalString(@"Simple Version");
        simplelabel.font = [UIFont systemFontOfSize:20.f];
        simplelabel.textColor = [UIColor whiteColor];
        simplelabel.textAlignment = NSTextAlignmentCenter;
        simplelabel.adjustsFontSizeToFitWidth = YES;
        [self.view addSubview:simplelabel];

        [simplelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(80), yAutoFit(20)));
            make.top.equalTo(self.simpleBtn.mas_bottom).offset(yAutoFit(20));
            make.right.mas_equalTo(self.view.mas_centerX).offset(yAutoFit(-20));
        }];
        
    }
    return _simpleBtn;
}

- (UIButton *)lcdBtn{
    if (!_lcdBtn) {
        
        _lcdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_lcdBtn setBackgroundImage:[UIImage imageNamed:@"img_lcd_Btn"] forState:UIControlStateNormal];
        [_lcdBtn addTarget:self action:@selector(nextLcd) forControlEvents:UIControlEventTouchUpInside];
        _lcdBtn.enabled = YES;
        [self.view addSubview:_lcdBtn];
        [_lcdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(80), yAutoFit(80.f)));
            make.top.equalTo(self.tipLabel.mas_bottom).offset(yAutoFit(30.f));
            make.left.mas_equalTo(self.view.mas_centerX).offset(yAutoFit(20));
        }];
   
        UILabel *lcdlabel = [[UILabel alloc] init];
        lcdlabel.text = LocalString(@"LCD Version");
        lcdlabel.font = [UIFont systemFontOfSize:20.f];
        lcdlabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.7];
        lcdlabel.textAlignment = NSTextAlignmentCenter;
        lcdlabel.adjustsFontSizeToFitWidth = YES;
        [self.view addSubview:lcdlabel];

        [lcdlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(80), yAutoFit(20)));
            make.top.equalTo(self.lcdBtn.mas_bottom).offset(yAutoFit(20));
            make.left.mas_equalTo(self.view.mas_centerX).offset(yAutoFit(20));
        }];
    }
    return _lcdBtn;
}

//- (UIButton *)nextBtn{
//    if (!_nextBtn) {
//        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_nextBtn setBackgroundImage:[UIImage imageNamed:@"img_addDevice_NextBtn"] forState:UIControlStateNormal];
//        [_nextBtn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
//        _nextBtn.enabled = NO;
//        [self.view addSubview:_nextBtn];
//        [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.size.mas_equalTo(CGSizeMake(yAutoFit(280), yAutoFit(40)));
//            make.top.equalTo(self.lcdBtn.mas_bottom).offset(yAutoFit(50));
//            make.centerX.mas_equalTo(self.view.mas_centerX);
//        }];
//
//    }
//    return _nextBtn;
//}

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
            make.top.equalTo(self.lcdBtn.mas_bottom).offset(yAutoFit(90+20));
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

-(void)nextSimple{
    
    SimpleVersionViewController *SimpleVC = [[SimpleVersionViewController alloc] init];
    [self.navigationController pushViewController:SimpleVC animated:YES];
}

- (void)nextLcd{
    
    LCDVersionlViewControlle *LcdVC = [[LCDVersionlViewControlle alloc] init];
    [self.navigationController pushViewController:LcdVC animated:YES];
    
}

-(void)next{
    
}

- (void)goHelp{
    
    AddDeviceHelpViewController *HelpVC = [[AddDeviceHelpViewController alloc] init];
    [self.navigationController pushViewController:HelpVC animated:YES];
    
}

@end
