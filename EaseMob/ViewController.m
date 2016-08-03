//
//  ViewController.m
//  EaseMob
//
//  Created by TestSmirk on 16/8/3.
//  Copyright © 2016年 TestSmirk. All rights reserved.
//

#import "ViewController.h"
#import "EMSDK.h"
#import "MainViewController.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *passwd;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UINavigationController *nav = [[UINavigationController alloc]init];
    self.view.window.rootViewController = nav;
}
- (IBAction)regist:(id)sender {
   UIViewController *viewController =  [UIStoryboard storyboardWithName:@"regist" bundle:nil].instantiateInitialViewController;
//    [self.navigationController pushViewController:viewController animated:true];
    NSLog(@"%@",viewController);
    [self presentViewController:viewController animated:YES completion:^{NSLog(@"call back");}];
}
- (IBAction)loginEaseMob:(id)sender {
    
    if (self.username.text.length < 1 ){
        return;
    }
    if (self.passwd.text.length < 1 ){
        return;
    }
    if([[EMClient sharedClient] loginWithUsername:self.username.text password:self.passwd.text]==nil){
        [self presentViewController:[[MainViewController alloc]init] animated:true completion:^{
        }];
        
         
        NSLog(@"login succ");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
