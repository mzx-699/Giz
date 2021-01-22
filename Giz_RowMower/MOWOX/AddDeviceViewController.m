//
//  addLandroidDeviceViewController.m
//  MOWOX
//
//  Created by 安建伟 on 2018/12/17.
//  Copyright © 2018 yusz. All rights reserved.
//

#import "AddDeviceViewController.h"
#import "APFinishViewController.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import <CoreLocation/CoreLocation.h>
#import <objc/runtime.h>
#import "AddDeviceHelpViewController.h"
#import "SelectModelViewController.h"

@interface AddDeviceViewController () <UITextFieldDelegate,CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;

@property (nonatomic, strong) UILabel *Label_1;
@property (nonatomic, strong) UILabel *Label_2;

@property (nonatomic, strong) UITextField *wifiNameTF;
@property (nonatomic, strong) UITextField *passwordTF;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) UIButton *eyespasswordBtn;
@property (strong, nonatomic) UIButton * bgViewBtn;

@property (strong, nonatomic)  UIImageView *deviceImage;


@end

@implementation AddDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavItem];
    UIImage *backImage = [UIImage imageNamed:@"loginView"];
    self.view.layer.contents = (id)backImage.CGImage;
    _deviceImage = [self deviceImage];
    _Label_1 = [self Label_1];
    //_Label_2 = [self Label_2];
    _wifiNameTF = [self wifiNameTF];
    _passwordTF = [self passwordTF];
    _nextBtn = [self nextBtn];
    _bgViewBtn = [self bgViewBtn];
    _eyespasswordBtn = [self eyespasswordBtn];
    [_eyespasswordBtn setImage:[UIImage imageNamed:@"ic_eyesclosed"] forState:UIControlStateNormal];
    if(@available(iOS 13.0, *)){
        [self getUserLocation];
    }
    
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
            make.size.mas_equalTo(CGSizeMake(yAutoFit(300), yAutoFit(200)));
            make.top.equalTo(self.view.mas_top).offset(yAutoFit(80));
            make.centerX.equalTo(self.view.mas_centerX);
        }];
    }
    return _deviceImage;
}

- (UILabel *)Label_1{
    if (!_Label_1) {
        _Label_1 = [[UILabel alloc] init];
        _Label_1.font = [UIFont systemFontOfSize:17.f];
        _Label_1.backgroundColor = [UIColor clearColor];
        _Label_1.textColor = [UIColor whiteColor];
        _Label_1.text = LocalString(@"Input the correct name and password of your WIFI network\nThen press “Next”");
        //自动折行设置
        [_Label_1 setLineBreakMode:NSLineBreakByWordWrapping];
        _Label_1.numberOfLines = 0;
        _Label_1.textAlignment = NSTextAlignmentLeft;
        _Label_1.adjustsFontSizeToFitWidth = YES;
        [self.view addSubview:_Label_1];
        [_Label_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(280), yAutoFit(60)));
            make.top.equalTo(self.view.mas_top).offset(yAutoFit(300));
            make.centerX.mas_equalTo(self.view.mas_centerX);
        }];

    }
    return _Label_1;
}


- (UILabel *)Label_2{
    if (!_Label_2) {
        _Label_2 = [[UILabel alloc] init];
        _Label_2.font = [UIFont systemFontOfSize:14.f];
        _Label_2.backgroundColor = [UIColor clearColor];
        _Label_2.textColor = [UIColor whiteColor];
        _Label_2.textAlignment = NSTextAlignmentLeft;
        _Label_2.text = LocalString(@"Make sure to use 2.4GHz Wi-Fi network.");
        //自动折行设置
        [_Label_2 setLineBreakMode:NSLineBreakByWordWrapping];
        _Label_2.numberOfLines = 0;
        _Label_2.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:_Label_2];
        [_Label_2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(280), yAutoFit(40)));
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.top.equalTo(self.Label_1.mas_bottom).offset(yAutoFit(20));
        }];
    }
    return _Label_2;
}

- (UITextField *)wifiNameTF{
    if (!_wifiNameTF) {
        _wifiNameTF = [[UITextField alloc] init];
        _wifiNameTF.backgroundColor = [UIColor clearColor];
        _wifiNameTF.font = [UIFont systemFontOfSize:15.f];
        _wifiNameTF.textColor = [UIColor whiteColor];
        _wifiNameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _wifiNameTF.delegate = self;
        
        [_wifiNameTF addTarget:self action:@selector(textFieldTextChange) forControlEvents:UIControlEventEditingChanged];
        [self.view addSubview:_wifiNameTF];
        [_wifiNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(280), yAutoFit(40)));
            make.top.equalTo(self.Label_1.mas_bottom).offset(yAutoFit(30));
            make.centerX.mas_equalTo(self.view.mas_centerX);
        }];
        _wifiNameTF.layer.borderWidth = 1.0;
        _wifiNameTF.layer.borderColor = [UIColor whiteColor].CGColor;
        _wifiNameTF.layer.cornerRadius = 10.f/HScale;
        
        Ivar ivar =  class_getInstanceVariable([UITextField class], "_placeholderLabel");
        UILabel *placeholderLabel = object_getIvar(_wifiNameTF, ivar);
        placeholderLabel.textColor = [UIColor whiteColor];
        placeholderLabel.font = [UIFont boldSystemFontOfSize:16];
        
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        _wifiNameTF.text = [defaults objectForKey:@"wifiname"];
        _wifiNameTF.text = [self getDeviceSSID];
        
        
    }
    return _wifiNameTF;
}

- (UIButton *)eyespasswordBtn{
    if (!_eyespasswordBtn) {
        _eyespasswordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_eyespasswordBtn addTarget:self action:@selector(eyespassword) forControlEvents:UIControlEventTouchUpInside];
        [_eyespasswordBtn.widthAnchor constraintEqualToConstant:30].active = YES;
        [_eyespasswordBtn.heightAnchor constraintEqualToConstant:30].active = YES;
        [self.view addSubview:_eyespasswordBtn];
        [_eyespasswordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(30), yAutoFit(30)));
            make.right.equalTo(self.view.mas_right).offset(-50);
            make.centerY.equalTo(self.passwordTF.mas_centerY);
        }];
    }
    return _eyespasswordBtn;
}

- (UITextField *)passwordTF{
    if (!_passwordTF) {
        _passwordTF = [[UITextField alloc] init];
        _passwordTF.backgroundColor = [UIColor clearColor];
        _passwordTF.font = [UIFont systemFontOfSize:15.f];
        _passwordTF.textColor = [UIColor whiteColor];
        _passwordTF.delegate = self;
        _passwordTF.secureTextEntry = YES;
        
        [_passwordTF addTarget:self action:@selector(textFieldTextChange) forControlEvents:UIControlEventEditingChanged];
        [self.view addSubview:_passwordTF];
        [_passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(280), yAutoFit(40)));
            make.top.equalTo(self.wifiNameTF.mas_bottom).offset(30);
            make.centerX.mas_equalTo(self.view.mas_centerX);
        }];
        _passwordTF.layer.borderWidth = 1.0;
        _passwordTF.layer.borderColor = [UIColor whiteColor].CGColor;
        _passwordTF.layer.cornerRadius = 10.f/HScale;
        _passwordTF.placeholder = LocalString(@"Wi-Fi Password");
        Ivar ivar =  class_getInstanceVariable([UITextField class], "_placeholderLabel");
        UILabel *placeholderLabel = object_getIvar(_passwordTF, ivar);
        placeholderLabel.textColor = [UIColor whiteColor];
        placeholderLabel.font = [UIFont boldSystemFontOfSize:16];
        
    }
    return _passwordTF;
}

- (UIButton *)nextBtn{
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextBtn setBackgroundImage:[UIImage imageNamed:@"img_addDevice_NextBtn"] forState:UIControlStateNormal];
        //[_nextBtn setTitle:LocalString(@"Next") forState:UIControlStateNormal];
        //[_nextBtn.titleLabel setFont:[UIFont systemFontOfSize:18.f]];
        //[_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //[_nextBtn setBackgroundColor:[UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:0.6]];
        [_nextBtn addTarget:self action:@selector(goNext) forControlEvents:UIControlEventTouchUpInside];
        _nextBtn.enabled = YES;
        [self.view addSubview:_nextBtn];
        [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(280), yAutoFit(40)));
            make.top.equalTo(self.passwordTF.mas_bottom).offset(yAutoFit(30));
            make.centerX.mas_equalTo(self.view.mas_centerX);
        }];
        
    }
    return _nextBtn;
}

- (UIButton *)bgViewBtn{
    if (!_bgViewBtn) {
        _bgViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _bgViewBtn.backgroundColor = [UIColor clearColor];
        [_bgViewBtn addTarget:self action:@selector(goHelp) forControlEvents:UIControlEventTouchUpInside];
        _bgViewBtn.enabled = NO;
        [self.view addSubview:_bgViewBtn];
        [_bgViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(120), yAutoFit(50)));
            make.left.equalTo(self.view.mas_centerX).offset(yAutoFit(50.f));
            make.top.equalTo(self.nextBtn.mas_bottom).offset(yAutoFit(20));
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

#pragma mark - 定位授权代理方法
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse ||
        status == kCLAuthorizationStatusAuthorizedAlways) {
        //再重新获取ssid
        _wifiNameTF.text = [self getDeviceSSID];
    }
}

- (void)getUserLocation{
    if (!self.locationManager) {
        self.locationManager = [[CLLocationManager alloc] init];
    }
    //如果用户第一次拒绝了，触发代理重新选择，要用户打开位置权限
    [self.locationManager requestAlwaysAuthorization];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 1.0f;
    [self.locationManager startUpdatingLocation];
    
}

#pragma 获取设备当前连接的WIFI的SSID
- (NSString *) getDeviceSSID
{
    NSArray *ifs = (__bridge id)CNCopySupportedInterfaces();
    id info = nil;
    for (NSString *ifnam in ifs)
    {
        info = (__bridge id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info && [info count])
        {
            break;
        }
    }
    NSDictionary *dctySSID = (NSDictionary *)info;
    NSString *ssid = [dctySSID objectForKey:@"SSID"];
    return ssid;
    
}

#pragma mark - UITextFieldDelegate
//导航栏bug
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    //设置动画的名字
    [UIView beginAnimations:@"Animation" context:nil];
    //设置动画的间隔时间
    [UIView setAnimationDuration:0.3];
    //使用当前正在运行的状态开始下一段动画
    [UIView setAnimationBeginsFromCurrentState:YES];
    //设置视图移动的位移
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - yAutoFit(200), self.view.frame.size.width, self.view.frame.size.height);
    //设置动画结束
    [UIView commitAnimations];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.wifiNameTF resignFirstResponder];
    [self.passwordTF resignFirstResponder];
    
    //设置动画的名字
    [UIView beginAnimations:@"Animation" context:nil];
    //设置动画的间隔时间
    [UIView setAnimationDuration:0.25];
    //使用当前正在运行的状态开始下一段动画
    [UIView setAnimationBeginsFromCurrentState:YES];
    //设置视图移动的位移
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + yAutoFit(200), self.view.frame.size.width, self.view.frame.size.height);
    //设置动画结束
    [UIView commitAnimations];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldTextChange{
    
}

#pragma mark - resign keyboard control
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.wifiNameTF resignFirstResponder];
    [self.passwordTF resignFirstResponder];
    
}

- (void)eyespassword{
    if (_passwordTF.secureTextEntry == YES) {
        [_eyespasswordBtn setImage:[UIImage imageNamed:@"ic_eyespassword"] forState:UIControlStateNormal];
        _passwordTF.secureTextEntry = NO;
    }else{
        _passwordTF.secureTextEntry = YES;
        [_eyespasswordBtn setImage:[UIImage imageNamed:@"ic_eyesclosed"] forState:UIControlStateNormal];
    }
    
}

-(void)goNext{
    GizManager *manager = [GizManager shareInstance];
    manager.ssid = _wifiNameTF.text;
    manager.key = _passwordTF.text;
    if (_passwordTF.text.length > 0) {
        SelectModelViewController *VC = [[SelectModelViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
}

- (void)goHelp{
    
    AddDeviceHelpViewController *HelpVC = [[AddDeviceHelpViewController alloc] init];
    [self.navigationController pushViewController:HelpVC animated:YES];
}

@end
