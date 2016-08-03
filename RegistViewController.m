//
//  RegistViewController.m
//  EaseMob
//
//  Created by TestSmirk on 16/8/3.
//  Copyright © 2016年 TestSmirk. All rights reserved.
//

#import "RegistViewController.h"
#import "EMSDK.h"
@interface RegistViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *passwd;

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:true completion:^{
        
    }];
}
- (IBAction)regist:(id)sender {
    if (self.username.text.length<1) {
        return;
    }
    if (self.passwd.text.length<1) {
        return;
    }
    if([[EMClient sharedClient] registerWithUsername:self.username.text password:self.passwd.text]==nil){
        NSLog(@"regist succ");
        [self back:nil];
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
