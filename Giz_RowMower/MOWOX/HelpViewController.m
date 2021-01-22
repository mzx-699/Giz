//
//  HelpViewController.m
//  Giz_Mower
//
//  Created by 安建伟 on 2020/8/26.
//  Copyright © 2020 yusz. All rights reserved.
//

#import "AddDeviceHelpViewController.h"

@interface AddDeviceHelpViewController ()

@property (nonatomic, strong) UILabel *simpleModelLabel;
@property (nonatomic, strong) UILabel *lcdModelLabel;
@property (strong, nonatomic) UIImageView *simpleModelImage;
@property (strong, nonatomic) UIImageView *lcdModelImage;

@end

@implementation AddDeviceHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavItem];
    UIImage *backImage = [UIImage imageNamed:@"loginView"];
    self.view.layer.contents = (id)backImage.CGImage;
    
    _simpleModelLabel = [self simpleModelLabel];
    _simpleModelImage = [self simpleModelImage];
    _lcdModelLabel = [self lcdModelLabel];
    _lcdModelImage = [self lcdModelImage];
}

- (void)setNavItem{
    self.navigationItem.title = LocalString(@"Help");
}

- (UILabel *)simpleModelLabel{
    if (!_simpleModelLabel) {
        _simpleModelLabel = [[UILabel alloc] init];
        _simpleModelLabel.font = [UIFont systemFontOfSize:20.f];
        _simpleModelLabel.backgroundColor = [UIColor clearColor];
        _simpleModelLabel.textColor = [UIColor whiteColor];
        _simpleModelLabel.textAlignment = NSTextAlignmentCenter;
        _simpleModelLabel.text = LocalString(@"Simple model:");
        _simpleModelLabel.adjustsFontSizeToFitWidth = YES;
        [self.view addSubview:_simpleModelLabel];
        [_simpleModelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(300), yAutoFit(40)));
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.top.mas_equalTo(self.view.mas_top).offset(yAutoFit(getRectNavAndStatusHight + 30));
        }];
    }
    return _simpleModelLabel;
}

- (UIImageView *)simpleModelImage{
    if (!_simpleModelImage) {
        _simpleModelImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_device_Simplehelp"]];
        [self.view addSubview:_simpleModelImage];
        
        [_simpleModelImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(300),yAutoFit(180)));
            make.top.equalTo(self.simpleModelLabel.mas_bottom).offset(yAutoFit(5.f));
            make.centerX.equalTo(self.view.mas_centerX);
        }];
    }
    return _simpleModelImage;
}

- (UILabel *)lcdModelLabel{
    if (!_lcdModelLabel) {
        _lcdModelLabel = [[UILabel alloc] init];
        _lcdModelLabel.font = [UIFont systemFontOfSize:20.f];
        _lcdModelLabel.backgroundColor = [UIColor clearColor];
        _lcdModelLabel.textColor = [UIColor whiteColor];
        _lcdModelLabel.textAlignment = NSTextAlignmentCenter;
        _lcdModelLabel.text = LocalString(@"LCD Model:");
        _lcdModelLabel.adjustsFontSizeToFitWidth = YES;
        [self.view addSubview:_lcdModelLabel];
        [_lcdModelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(300), yAutoFit(40)));
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.top.mas_equalTo(self.simpleModelImage.mas_bottom).offset(yAutoFit(30.f));
        }];
    }
    return _lcdModelLabel;
}

- (UIImageView *)lcdModelImage{
    if (!_lcdModelImage) {
        _lcdModelImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_device_LCDhelp"]];
        [self.view addSubview:_lcdModelImage];
        
        [_lcdModelImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(300),yAutoFit(220)));
            make.top.equalTo(self.lcdModelLabel.mas_bottom).offset(yAutoFit(5));
            make.centerX.equalTo(self.view.mas_centerX);
        }];
    }
    return _lcdModelImage;
}

@end
