//
//  TwoLCDModelHelpViewController.m
//  Giz_Mower
//
//  Created by 安建伟 on 2020/8/27.
//  Copyright © 2020 yusz. All rights reserved.
//

#import "TwoLCDModelHelpViewController.h"

@interface TwoLCDModelHelpViewController ()

@property (nonatomic, strong) UILabel *modelLabel_1;
@property (nonatomic, strong) UILabel *modelLabel_2;

@end

@implementation TwoLCDModelHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavItem];
    UIImage *backImage = [UIImage imageNamed:@"loginView"];
    self.view.layer.contents = (id)backImage.CGImage;
    
    _modelLabel_1 = [self modelLabel_1];
    _modelLabel_2 = [self modelLabel_2];
}

- (void)setNavItem{
    self.navigationItem.title = LocalString(@"Help");
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = LocalString(@"Back");
    self.navigationItem.backBarButtonItem = backItem;
}


- (UILabel *)modelLabel_1{
    if (!_modelLabel_1) {
        _modelLabel_1 = [[UILabel alloc] init];
        _modelLabel_1.font = [UIFont systemFontOfSize:20.f];
        _modelLabel_1.backgroundColor = [UIColor clearColor];
        _modelLabel_1.textColor = [UIColor whiteColor];
        _modelLabel_1.textAlignment = NSTextAlignmentLeft;
        _modelLabel_1.text = LocalString(@"Model2:");
        _modelLabel_1.adjustsFontSizeToFitWidth = YES;
        [self.view addSubview:_modelLabel_1];
        [_modelLabel_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(300), yAutoFit(20)));
            make.left.mas_equalTo(self.view.mas_left).offset(yAutoFit(60));
            make.bottom.equalTo(self.view.mas_centerY).offset(yAutoFit(-60.f));
        }];
        
        UIImageView *simpleModelImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_check"]];
        [self.view addSubview:simpleModelImage];
        
        [simpleModelImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(10),yAutoFit(10)));
            make.right.equalTo(self.modelLabel_1.mas_left).offset(yAutoFit(-10.f));
            make.centerY.equalTo(self.modelLabel_1.mas_centerY);
        }];
    }
    return _modelLabel_1;
}

- (UILabel *)modelLabel_2{
    if (!_modelLabel_2) {
        _modelLabel_2 = [[UILabel alloc] init];
        _modelLabel_2.font = [UIFont systemFontOfSize:17.f];
        _modelLabel_2.backgroundColor = [UIColor clearColor];
        _modelLabel_2.textColor = [UIColor whiteColor];
        _modelLabel_2.textAlignment = NSTextAlignmentLeft;
        _modelLabel_2.text = LocalString(@"more compatible to 2.4GHZ/5Ghz Wifi network");
        //_modelLabel_2.adjustsFontSizeToFitWidth = YES;
        _modelLabel_2.numberOfLines = 0;
        [self.view addSubview:_modelLabel_2];
        [_modelLabel_2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(300), yAutoFit(40)));
            make.left.mas_equalTo(self.view.mas_left).offset(yAutoFit(40));
            make.top.mas_equalTo(self.modelLabel_1.mas_bottom).offset(yAutoFit(10.f));
        }];
    }
    return _modelLabel_2;
}

@end
