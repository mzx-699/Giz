//
//  GeneralsettingLanguageViewController.m
//  MOWOX
//
//  Created by Mac on 2017/11/6.
//  Copyright © 2017年 yusz. All rights reserved.
//


#import "GeneralsettingLanguageViewController.h"
#import "BluetoothDataManage.h"
#import "AppDelegate.h"
#import "GWLanguage.h"
#import "YULanguageManager.h"
#import "RDVViewController.h"

@interface GeneralsettingLanguageViewController () <UIPickerViewDataSource,UIPickerViewDelegate>

///@brife 帧数据控制单例
@property (strong,nonatomic) BluetoothDataManage *bluetoothDataManage;

@property (strong, nonatomic) UIPickerView *languagePicker;
@property (strong, nonatomic) UIButton *OKButton;

@property (nonatomic, strong) NSMutableArray  *languageArray;


@end

@implementation GeneralsettingLanguageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
    self.navigationItem.title = LocalString(@"Language setting");
    
    self.bluetoothDataManage = [BluetoothDataManage shareInstance];
    
    [self viewLayoutSet];
    [self inquireLanguage];
    
    [self.OKButton addTarget:self action:@selector(setLanguage) forControlEvents:UIControlEventTouchUpInside];
    //[self.languagePicker selectRow:0 inComponent:0 animated:0];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recieveMowerLanguage:) name:@"recieveMowerLanguage" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"recieveMowerLanguage" object:nil];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewLayoutSet{
    UIImage *image = [UIImage imageNamed:@"返回1"];
    [self addLeftBarButtonWithImage:image action:@selector(backAction)];
    
    _languagePicker = [[UIPickerView alloc] init];
    //en de-DE da-DK cs-CZ sk pl-PL hu-HU ru-RU fr-FR bg-BG fi-FI nl-NL lt-LT ro-MD nb pt-PT sv es-ES it-IT
    self.languageArray = [NSMutableArray arrayWithArray:@[NSLocalizedString(@"English", nil),
    NSLocalizedString(@"German", nil),NSLocalizedString(@"Danish", nil),NSLocalizedString(@"Czech", nil),NSLocalizedString(@"Slovak", nil),NSLocalizedString(@"Polish", nil),NSLocalizedString(@"Hungarian", nil),NSLocalizedString(@"Russian", nil),NSLocalizedString(@"French", nil),NSLocalizedString(@"Bulgarian", nil),NSLocalizedString(@"Finnish", nil),NSLocalizedString(@"Dutch", nil),NSLocalizedString(@"Lithuanian", nil),NSLocalizedString(@"Romanian", nil),NSLocalizedString(@"Norwegian", nil),NSLocalizedString(@"Portuguese", nil),NSLocalizedString(@"Swedish", nil),NSLocalizedString(@"Spanish", nil),NSLocalizedString(@"Italian", nil)]];

    self.languagePicker.dataSource = self;
    self.languagePicker.delegate = self;
    [self.languagePicker selectRow:0 inComponent:0 animated:YES];
    
    _OKButton = [UIButton buttonWithTitle:LocalString(@"OK") titleColor:[UIColor blackColor]];
    [_OKButton setButtonStyle1];
    [self.view addSubview:_OKButton];
    [self.view addSubview:_languagePicker];
    
    NSString *deviceType = [UIDevice currentDevice].model;
    
    if([deviceType isEqualToString:@"iPhone"]) {
        //iPhone
        [self.languagePicker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(ScreenHeight * 0.6);
            make.width.mas_equalTo(ScreenWidth);
            make.centerX.equalTo(self.view.mas_centerX);
            make.top.equalTo(self.view.mas_top).offset(ScreenHeight * 0.05 + 44 + 64);
        }];
    }else if([deviceType isEqualToString:@"iPad"]) {
        //iPad
        [self.languagePicker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(ScreenHeight * 0.6);
            make.width.mas_equalTo(ScreenWidth);
            make.centerX.equalTo(self.view.mas_centerX);
            make.top.equalTo(self.view.mas_top).offset(ScreenHeight * 0.01 + 44 + 64);
        }];
    }
    
    
    [_OKButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ScreenWidth * 0.6, ScreenHeight * 0.066));
        make.top.equalTo(self.languagePicker.mas_bottom);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
}

#pragma mark - inquire Mower Language

- (void)inquireLanguage{
    
    NSMutableArray *dataContent = [[NSMutableArray alloc] init];
    [dataContent addObject:[NSNumber numberWithUnsignedInteger:0x00]];
    [dataContent addObject:[NSNumber numberWithUnsignedInteger:0x00]];
    [dataContent addObject:[NSNumber numberWithUnsignedInteger:0x00]];
    [dataContent addObject:[NSNumber numberWithUnsignedInteger:0x00]];
    [dataContent addObject:[NSNumber numberWithUnsignedInteger:0x00]];
    [dataContent addObject:[NSNumber numberWithUnsignedInteger:0x00]];
    [dataContent addObject:[NSNumber numberWithUnsignedInteger:0x00]];
    [dataContent addObject:[NSNumber numberWithUnsignedInteger:0x00]];
    
    [self.bluetoothDataManage setDataType:0x13];
    [self.bluetoothDataManage setDataContent: dataContent];
    [self.bluetoothDataManage sendBluetoothFrame];
}

- (void)recieveMowerLanguage:(NSNotification *)notification{
    NSDictionary *dict = [notification userInfo];
    NSNumber *Language = dict[@"Language"];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.languagePicker selectRow:[Language intValue] inComponent:0 animated:YES];
    });}

#pragma mark - buttonAction
- (void)setLanguage
{
    NSInteger row = [self.languagePicker selectedRowInComponent:0];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:self.languageArray[row % _languageArray.count] forKey:@"language"];
    [userDefaults synchronize];
    
    NSMutableArray *dataContent = [[NSMutableArray alloc] init];
    [dataContent addObject:[NSNumber numberWithUnsignedInteger:row]];
    [dataContent addObject:[NSNumber numberWithUnsignedInteger:0x00]];
    [dataContent addObject:[NSNumber numberWithUnsignedInteger:0x00]];
    [dataContent addObject:[NSNumber numberWithUnsignedInteger:0x00]];
    [dataContent addObject:[NSNumber numberWithUnsignedInteger:0x00]];
    [dataContent addObject:[NSNumber numberWithUnsignedInteger:0x00]];
    [dataContent addObject:[NSNumber numberWithUnsignedInteger:0x00]];
    [dataContent addObject:[NSNumber numberWithUnsignedInteger:0x00]];
    
    [self.bluetoothDataManage setDataType:0x03];
    [self.bluetoothDataManage setDataContent: dataContent];
    [self.bluetoothDataManage sendBluetoothFrame];
    NSLog(@"语言%ld, %@",(long)row, self.languageArray[row]);
    
    switch (row % _languageArray.count) {
        //English
        case 0:
            [YULanguageManager setUserLanguage:@"en"];
            //[[GWLanguage sharedInstance] setLanguage:@"en"];
            break;
        //Danish
        //Portuguese
        case 1:
            [YULanguageManager setUserLanguage:@"de-DE"];
            //[[GWLanguage sharedInstance] setLanguage:@"de-DE"];
            break;
        //Dutch
        //Italian
        case 2:
            [YULanguageManager setUserLanguage:@"da-DK"];
            //[[GWLanguage sharedInstance] setLanguage:@"da-DK"];
            break;
        //French
        //Spanish
        case 3:
            //[[GWLanguage sharedInstance] setLanguage:@"cs-CZ"];
            break;
        //German
        //Polish
        case 4:
            //[[GWLanguage sharedInstance] setLanguage:@"sk"];
            break;
        //Italian
        //Slovenian
        case 5:
            //[[GWLanguage sharedInstance] setLanguage:@"pl-PL"];
            break;
        //Norwegian
        //Danish
        case 6:
            //[[GWLanguage sharedInstance] setLanguage:@"hu-HU"];
            break;
        //Russian
        //Noewegian
        case 7:
            //[[GWLanguage sharedInstance] setLanguage:@"ru-RU"];
            break;
        //Portuguese
        //Czech
        case 8:
            //[[GWLanguage sharedInstance] setLanguage:@"fr-FR"];
            break;
        //Spanish
        //Finnish
        case 9:
            //[[GWLanguage sharedInstance] setLanguage:@"bg-BG"];
            break;
        //Slovak
        case 10:
            //[[GWLanguage sharedInstance] setLanguage:@"fi-FI"];
        break;
        //Hungarian
        case 11:
            //[[GWLanguage sharedInstance] setLanguage:@"nl-NL"];
        break;
        //French
        case 12:
            //[[GWLanguage sharedInstance] setLanguage:@"lt-LT"];
        break;
        //German
        case 13:
            //[[GWLanguage sharedInstance] setLanguage:@"ro-MD"];
        break;
        //Swedish
        case 14:
            //[[GWLanguage sharedInstance] setLanguage:@"nb"];
        break;
        case 15:
            //[[GWLanguage sharedInstance] setLanguage:@"pt-PT" ];
        break;
        case 16:
            //[[GWLanguage sharedInstance] setLanguage:@"sv"];
        break;
        case 17:
            //[[GWLanguage sharedInstance] setLanguage:@"es-ES"];
        break;
        case 18:
            //[[GWLanguage sharedInstance] setLanguage:@"it-IT"];
        break;
        default:
            break;
    }

        //解决奇怪的动画bug。
    dispatch_async(dispatch_get_main_queue(), ^{
        AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
        RDVViewController *mainViewVc = [[RDVViewController alloc] init];
        appDelegate.navController = [[UINavigationController alloc] initWithRootViewController:mainViewVc];
        appDelegate.window.rootViewController= appDelegate.navController;

    });
    
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component __TVOS_PROHIBITED {
    
    return 40;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return self.languageArray.count;
    
}

#pragma mark - UIPickerViewDelegate 
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return self.languageArray[row];
    
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
