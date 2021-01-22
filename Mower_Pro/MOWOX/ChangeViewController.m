//
//  ChangeViewController.m
//  MOWOX
//
//  Created by 安建伟 on 2018/12/20.
//  Copyright © 2018 yusz. All rights reserved.
//

#import "ChangeViewController.h"
#import "LoginViewController.h"
#import "Masonry.h"
#import "AppDelegate.h"
#import "RDVViewController.h"
#import "ChangePasswordViewController.h"
#import "BlueTableViewController.h"
#import "LMPopInputPasswordView.h"

@interface ChangeViewController () <UITextFieldDelegate,LMPopInputPassViewDelegate>

@property (strong, nonatomic)  UITextField *passwordTextfield;
@property (strong, nonatomic)  UIButton *connButton;
@property (strong, nonatomic)  UILabel *passwordLimitLabel;
@property (strong, nonatomic)  UIButton *LoginButton;
@property (strong, nonatomic)  UIButton *changeButton;

@property (strong, nonatomic)  UILabel *resultLabel;
@property (strong, nonatomic)  LMPopInputPasswordView *popView;

@property (strong, nonatomic)  UILabel *bluetoothNameLabel;
@property (strong, nonatomic)  BluetoothDataManage *bluetoothDataManage;

@property (strong, nonatomic)  AppDelegate *appDelegate;

@end

@implementation ChangeViewController
{
    NSTimeInterval time;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //背景图
    UIImage *backImage = [UIImage imageNamed:@"loginView"];
    self.view.layer.contents = (id)backImage.CGImage;
    
    self.bluetoothDataManage = [BluetoothDataManage shareInstance];
    self.appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    [self viewLayoutSet];
    //self.passwordTextfield.delegate = self;
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deviceOrientationDidChange:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
    time = 0.0;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    
    [self.LoginButton addTarget:self action:@selector(connectMower) forControlEvents:UIControlEventTouchUpInside];
    [self.connButton addTarget:self action:@selector(showConnView) forControlEvents:UIControlEventTouchUpInside];
    [self.changeButton addTarget:self action:@selector(changeConnWay) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController setNavigationBarHidden:YES animated:YES];

}

-(void)dealloc{
    [[UIDevice currentDevice]endGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];

}

- (void)viewLayoutSet{
    _bluetoothNameLabel = [UILabel labelWithFont:[UIFont systemFontOfSize:20.0f] textColor:[UIColor whiteColor] text:LocalString(@"Connect bluetooth")];
    _passwordTextfield = [UITextField textFieldWithPlaceholderText:LocalString(@"")];
    _passwordTextfield.textAlignment = NSTextAlignmentCenter;
    UIColor *color = [UIColor whiteColor];
    _passwordTextfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Input password" attributes:@{NSForegroundColorAttributeName: color}];
    _passwordTextfield.textColor = [UIColor whiteColor];
    _passwordLimitLabel = [UILabel labelWithFont:[UIFont systemFontOfSize:10.f] textColor:[UIColor whiteColor] text:@"6-12 characters or numbers"];
    [_passwordLimitLabel setFont:[UIFont systemFontOfSize:10.0]];
    _connButton = [UIButton buttonWithType:UIButtonTypeCustom];
    if (_appDelegate.status == 1) {
        [_connButton setBackgroundImage:[UIImage imageNamed:@"蓝牙图标"] forState:UIControlStateNormal];
        _changeButton = [UIButton buttonWithTitle:LocalString(@"Change to Wi-Fi") titleColor:[UIColor whiteColor]];
        _bluetoothNameLabel.text = LocalString(@"Connect bluetooth");
    }else{
        [_connButton setBackgroundImage:[UIImage imageNamed:@"img_wifi"] forState:UIControlStateNormal];
        _changeButton = [UIButton buttonWithTitle:LocalString(@"Change to Bluetooth") titleColor:[UIColor whiteColor]];
        _bluetoothNameLabel.text = LocalString(@"Connect Wi-Fi");
    }
    _LoginButton = [UIButton buttonWithTitle:LocalString(@"Control the robot") titleColor:[UIColor whiteColor]];
    
    [_passwordTextfield setTextFieldStyle1];
    [_LoginButton setButtonStyle1];
    [_changeButton setButtonStyle1];
    
    [self.view addSubview:_bluetoothNameLabel];
    [self.view addSubview:_passwordTextfield];
    [self.view addSubview:_passwordLimitLabel];
    [self.view addSubview:_LoginButton];
    [self.view addSubview:_connButton];
    [self.view addSubview:_changeButton];
    
    [_bluetoothNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ScreenWidth * 0.6, ScreenHeight * 0.04));
        make.top.equalTo(self.view.mas_top).offset(ScreenHeight * 0.15);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    [_connButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(84, 84));
        make.top.equalTo(self.bluetoothNameLabel.mas_bottom).offset(ScreenHeight * 0.08);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    [self.LoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ScreenWidth * 0.82, ScreenHeight * 0.066));
        make.top.equalTo(self.connButton.mas_bottom).offset(ScreenHeight * 0.4);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    [self.changeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ScreenWidth * 0.82, ScreenHeight * 0.066));
        make.bottom.equalTo(self.LoginButton.mas_top).offset(- ScreenHeight * 0.05);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
}

#pragma mark - ViewController push and back
- (void)connectMower
{
    //测试用直接进入APP
    //    RDVViewController *rdvView = [[RDVViewController alloc] init];
    //    rdvView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    //    [self presentViewController:rdvView animated:YES completion:nil];
    //    return;
    NSTimeInterval currentTime = [NSDate date].timeIntervalSince1970;//防止暴力点击
    if (currentTime - time > 1) {//限制用户点击按钮的时间间隔大于1秒钟
        
        if (_appDelegate.currentPeripheral == nil) {
            
        }else{
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            if ([defaults integerForKey:@"pincode"]) {
                [BluetoothDataManage shareInstance].pincode = (int)[defaults integerForKey:@"pincode"];
                
                //解决如果机器不发请求 默认之前保存密码 进入页面。
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                NSString *password = [userDefaults objectForKey:@"password"];
                if ([password integerValue] == [userDefaults integerForKey:@"pincode"]) {
                    
                    RDVViewController *rdvView = [[RDVViewController alloc] init];
                    rdvView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
                    rdvView.modalPresentationStyle = UIModalPresentationFullScreen;
                    [self presentViewController:rdvView animated:YES completion:nil];
                    return;
                }
                
            }
        }
        //更新点击时间
        time = currentTime;
        //子线程延时1s
        double delayInSeconds = 1.0;
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW,delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, mainQueue, ^{
            NSLog(@"延时执行的1秒");
            [self getPINData];
        });
        
        //密码不对 应该输入最新密码
        _resultLabel = [[UILabel alloc] init];
        _popView = [[LMPopInputPasswordView alloc]init];
        _popView.frame = CGRectMake((self.view.frame.size.width - 250)*0.5, 50, 250, 150);
        _popView.delegate = self;
        [_popView pop];
        
    }
    
}

//蓝牙版自动登录不能获取分区显示了
- (void)getPINData{
    
    NSMutableArray *dataContent = [[NSMutableArray alloc] init];
    [dataContent addObject:[NSNumber numberWithUnsignedInteger:0x00]];
    [dataContent addObject:[NSNumber numberWithUnsignedInteger:0x00]];
    [dataContent addObject:[NSNumber numberWithUnsignedInteger:0x00]];
    [dataContent addObject:[NSNumber numberWithUnsignedInteger:0x00]];
    [dataContent addObject:[NSNumber numberWithUnsignedInteger:0x00]];
    [dataContent addObject:[NSNumber numberWithUnsignedInteger:0x00]];
    [dataContent addObject:[NSNumber numberWithUnsignedInteger:0x00]];
    [dataContent addObject:[NSNumber numberWithUnsignedInteger:0x00]];
    
    [self.bluetoothDataManage setDataType:0x0c];
    [self.bluetoothDataManage setDataContent: dataContent];
    [self.bluetoothDataManage sendBluetoothFrame];
}

- (void)changeView{
    ChangePasswordViewController *changeVC = [[ChangePasswordViewController alloc] init];
    [self.navigationController pushViewController:changeVC animated:YES];
}

- (void)showConnView{
    
    if (_appDelegate.status == 1) {
        BlueTableViewController *detailVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"BlueTableViewController"];
        NSLog(@"%@", self.storyboard);
        [self.navigationController pushViewController:detailVC animated:YES];
    }else{
        LoginViewController *wifiVC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:wifiVC animated:YES];
    }
}

- (IBAction)LoginViewControllerUnwindSegue:(UIStoryboardSegue *)unwindSegue {
    
}

#pragma mark ---LMPopInputPassViewDelegate
-(void)buttonClickedAtIndex:(NSUInteger)index withText:(NSString *)text
{
    NSLog(@"buttonIndex = %li password=%@",(long)index,text);
    if(index == 1){
        if(text.length == 0){
            NSLog(@"密码长度不正确Incorrect password length");
            [NSObject showHudTipStr:LocalString(@"Incorrect PIN code length")];
        }else if(text.length < 4){
            NSLog(@"密码长度不正确");
            [NSObject showHudTipStr:LocalString(@"Incorrect PIN code length")];
        }else{
            _resultLabel.text = text;
            if ([text intValue] == [BluetoothDataManage shareInstance].pincode) {
                //记录账号密码
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:_resultLabel.text forKey:@"password"];
                [userDefaults synchronize];
                
                RDVViewController *rdvView = [[RDVViewController alloc] init];
                rdvView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
                rdvView.modalPresentationStyle = UIModalPresentationFullScreen;
                [self presentViewController:rdvView animated:YES completion:nil];
            }else{
                NSMutableArray *dataContent = [[NSMutableArray alloc] init];
                [dataContent addObject:[NSNumber numberWithUnsignedInteger:0x00]];
                [dataContent addObject:[NSNumber numberWithUnsignedInteger:0x00]];
                [dataContent addObject:[NSNumber numberWithUnsignedInteger:0x00]];
                [dataContent addObject:[NSNumber numberWithUnsignedInteger:0x00]];
                [dataContent addObject:[NSNumber numberWithUnsignedInteger:0x00]];
                [dataContent addObject:[NSNumber numberWithUnsignedInteger:0x00]];
                [dataContent addObject:[NSNumber numberWithUnsignedInteger:0x00]];
                [dataContent addObject:[NSNumber numberWithUnsignedInteger:0x00]];
                
                [self.bluetoothDataManage setDataType:0x0c];
                [self.bluetoothDataManage setDataContent: dataContent];
                [self.bluetoothDataManage sendBluetoothFrame];
                
                [NSObject showHudTipStr:LocalString(@"Incorrect PIN code")];
            }
            /*if ([_resultLabel.text isEqualToString:@"1234"]) {
             RDVViewController *rdvView = [[RDVViewController alloc] init];
             rdvView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
             [self presentViewController:rdvView animated:YES completion:nil];
             }*/
        }
    }
}

-(void)deviceOrientationDidChange:(NSObject*)sender{
    UIDevice* device = [sender valueForKey:@"object"];
    if(device.orientation==UIInterfaceOrientationLandscapeLeft||device.orientation==UIInterfaceOrientationLandscapeRight)
    {
        _popView.frame = CGRectMake((self.view.frame.size.width - 250)*0.5, 50, 250, 150);
    }
    else if(device.orientation==UIInterfaceOrientationPortrait||device.orientation==UIInterfaceOrientationPortraitUpsideDown)
    {
        _popView.frame = CGRectMake((self.view.frame.size.width - 250)*0.5, 50, 250, 150);
    }
}

#pragma mark - change rootvc
- (void)changeConnWay{
    if (_appDelegate.status == 0) {
        _appDelegate.status = 1;
        [_connButton setBackgroundImage:[UIImage imageNamed:@"蓝牙图标"] forState:UIControlStateNormal];
        [_changeButton setTitle:LocalString(@"Change to Wi-Fi") forState:UIControlStateNormal];
        _bluetoothNameLabel.text = LocalString(@"Connect bluetooth");
        _LoginButton.hidden = NO;
    }else{
        _appDelegate.status = 0;
        [_connButton setBackgroundImage:[UIImage imageNamed:@"img_wifi"] forState:UIControlStateNormal];
        [_changeButton setTitle:LocalString(@"Change to Bluetooth") forState:UIControlStateNormal];
        _LoginButton.hidden = YES;
        _bluetoothNameLabel.text = LocalString(@"Connect Wi-Fi");
    }
}

@end
