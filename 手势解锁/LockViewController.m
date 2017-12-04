//
//  LockViewController.m
//  手势解锁
//
//  Created by qyhc on 17/8/17.
//  Copyright © 2017年 com.qykj. All rights reserved.
//

#import "LockViewController.h"

#import "LockView.h"
#import "PrefixHeader.pch"


@interface LockViewController ()

<
 LockViewDelegate
>

//标记是否是重置密码
@property (nonatomic, assign) BOOL resetpassword;

//判断是否是两次确认密码
@property (nonatomic, assign) BOOL twopassword;

@property (nonatomic, strong) UILabel *unlocklabel;

@property (nonatomic, strong) UILabel *setpassword;

@property (nonatomic, strong) LockView *lockview;

@end

@implementation LockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"HomeButtomBG"]];
    
    self.resetpassword = NO;
    self.twopassword = NO;
    
    [self.view addSubview:self.lockview];
    
    [self judgeMentLocalPassWord];
    
}


#pragma mark lockViewDelegate
- (BOOL)unlockView:(LockView *)unlockView withPassword:(NSString *)password{
    
    NSString *localpasswordone = [[NSUserDefaults standardUserDefaults]objectForKey:@"passwordone"];
    NSString *localpasswordtwo = [[NSUserDefaults standardUserDefaults]objectForKey:@"passwordtwo"];
    
    if(self.twopassword){
        
        if([localpasswordone isEqualToString:localpasswordtwo]){
            [Tool showAlertControllerWithViewController:self alertStyle:UIAlertControllerStyleAlert title:@"密码设置成功" message:@"请输入密码解锁" alertAction:@[@{actionTitle:@"确定",
                                                                                                                                                 actionStyle:@(UIAlertActionStyleDefault),
                                                                                                                                                 actionBlock:^(UIAlertAction *action) {
                
                            [self dismissViewControllerAnimated:YES completion:nil];
            }}] isCancel:NO cancelBlock:nil];
            
            [self setLocklabel:@"手势解锁"];
            
            self.twopassword = NO;
            
            return YES;

        }else{
            [Tool showAlertControllerWithViewController:self alertStyle:UIAlertControllerStyleAlert title:@"与上次密码不对应" message:@"请重新设置密码" alertAction:@[@{actionTitle:@"确定",
                                                                                                                                                       actionStyle:@(UIAlertActionStyleDefault),
                                                                                                                                                       actionBlock:^(UIAlertAction *action) {}}] isCancel:NO cancelBlock:nil];
            
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"passwordone"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"passwordtwo"];
            
            [self setLocklabel:@"设置密码"];
            
            return NO;
        }
        
        
    }else{
        if([password isEqualToString:localpasswordone]){
            if(self.resetpassword){
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"passwordone"];
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"passwordtwo"];
                
                [self setLocklabel:@"设置新密码"];
                
                [Tool showAlertControllerWithViewController:self alertStyle:UIAlertControllerStyleAlert title:@"密码确认成功" message:@"请重新设置密码" alertAction:@[@{actionTitle:@"确定",
                                                                                                                                                             actionStyle:@(UIAlertActionStyleDefault),
                                                                                                                                                             actionBlock:^(UIAlertAction *action) {}}] isCancel:NO cancelBlock:nil];
                self.resetpassword = NO;
                
            }else{
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            
            return YES;

        }else{
           return NO;
        }
    }
    
    return NO;
}



- (void)setPassWordSuccess:(NSString *)tabelname{
   
    NSString *localpasswordone = [[NSUserDefaults standardUserDefaults]objectForKey:@"passwordone"];
    NSString *localpasswordtwo = [[NSUserDefaults standardUserDefaults]objectForKey:@"passwordywo"];
    
    if (!localpasswordtwo||!localpasswordone ) {
        self.twopassword = YES;
    }
    self.setpassword.text = tabelname;
    self.unlocklabel.text = tabelname;
    
    [self.unlocklabel sizeToFit];
    [self.setpassword sizeToFit];
    
    self.setpassword.x = (KSCREENW - self.setpassword.width) * 0.5;
    self.setpassword.y = CGRectGetMinY(self.lockview.frame) - 40;
    
    self.unlocklabel.x = (KSCREENW - self.unlocklabel.width) * 0.5;
    self.unlocklabel.y = CGRectGetMinY(self.lockview.frame) - 40;
}


#pragma mark  设置状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}


- (void)setLocklabel:(NSString *)str{
    
    self.setpassword.text = str;
    self.unlocklabel.text = str;
    
    [self.setpassword sizeToFit];
    [self.unlocklabel sizeToFit];
    
    self.setpassword.x = (KSCREENW - self.setpassword.width) * 0.5;
    self.setpassword.y = CGRectGetMinY(self.setpassword.frame) - 40;
    
    self.unlocklabel.x = (KSCREENW - self.unlocklabel.width) * 0.5;
    self.unlocklabel.y = CGRectGetMinY(self.lockview.frame) - 40;
    
    [self.view addSubview:self.setpassword];
    [self.view addSubview:self.unlocklabel];
    
}


#pragma mark  取消设置按钮
- (void)cancelButtonClick{
    
     [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark  重置按钮点击事件
- (void)resetPassWord{
    
    self.resetpassword = YES;
    
    [self setLocklabel:@"确认旧手势密码"];
    [self.unlocklabel sizeToFit];
    
    self.unlocklabel.x = (KSCREENW - self.unlocklabel.width) * 0.5;
    self.unlocklabel.y = CGRectGetMinY(self.lockview.frame) - 40;

}


#pragma mark  添加下次设置按钮
- (void)addCancelButton{
    
    UIButton *cancelbutt = [[UIButton alloc]init];
    
    [cancelbutt setTitle:@"下次设置" forState:UIControlStateNormal];
    [cancelbutt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelbutt sizeToFit];
    
    cancelbutt.y = CGRectGetMaxY(self.lockview.frame) + 50;
    cancelbutt.x = (KSCREENW - cancelbutt.width) * 0.5;
    
    [cancelbutt addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:cancelbutt];

}


#pragma mark  设置密码界面
- (void)setPassWordView:(NSString *)lockstr{
    
    UILabel *locklabel = [[UILabel alloc]init];
    
    locklabel.text = lockstr;
    locklabel.textAlignment = NSTextAlignmentCenter;
    locklabel.textColor = [UIColor whiteColor];
    [locklabel sizeToFit];
    
    locklabel.x = (KSCREENW - locklabel.width) * 0.5;
    locklabel.y = CGRectGetMinY(self.lockview.frame) - 40;
    
    self.setpassword = locklabel;
    
    [self.view addSubview:locklabel];
    
}


#pragma mark 添加重置密码按钮
- (void)addResetPassWordBuutton{
   
    UIButton *resetpassword = [[UIButton alloc]init];
    
    [resetpassword setTitle:@"重置密码" forState:UIControlStateNormal];
    [resetpassword setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [resetpassword sizeToFit];
    
    resetpassword.y = CGRectGetMaxY(self.lockview.frame) + 50;
    resetpassword.x = (KSCREENW - resetpassword.width) * 0.5;
    
    [resetpassword addTarget:self action:@selector(resetPassWord) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:resetpassword];
  
}

                                              
#pragma mark 手势解锁界面
- (void)unlockView :(NSString *)unlockstr{
    
    UILabel *locklabel = [[UILabel alloc]init];
    
    locklabel.text = unlockstr;
    locklabel.textColor = [UIColor whiteColor];
    [locklabel sizeToFit];
    
    locklabel.x = (KSCREENW - locklabel.width) * 0.5;
    locklabel.y = CGRectGetMinY(self.lockview.frame) - 40;
    
    self.unlocklabel = locklabel;
    
    [self.view addSubview:locklabel];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark
- (void)judgeMentLocalPassWord{
    
    NSString *password = [[NSUserDefaults standardUserDefaults]objectForKey:@"passwordone"];
    
    if (password == nil) {
        //添加下次设置按钮
        [self addCancelButton];
        [self setPassWordView:@"设置手势密码"];
        
    }else{
        //添加重置密码按钮
        [self addResetPassWordBuutton];
        [self unlockView:@"手势解锁"];
    }
}

- (LockView *)lockview{
    
    if(!_lockview){
        _lockview = [[LockView alloc]initWithFrame:CGRectMake((KSCREENW - 300) * 0.5, 150, 300, 300)];
        _lockview.backgroundColor = [UIColor clearColor];
        self.lockview.delegate = self;
  
    }
    return _lockview;
}




@end
