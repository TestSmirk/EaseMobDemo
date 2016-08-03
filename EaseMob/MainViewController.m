//
//  MainViewController.m
//  EaseMob
//
//  Created by TestSmirk on 16/8/3.
//  Copyright © 2016年 TestSmirk. All rights reserved.
//

#import "MainViewController.h"
#import "EMSDK.h"
#import "ChatListActivityViewController.h"
@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *list;
@property(nonatomic,strong)UITableView *listView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"MainViewController");
    self.view.backgroundColor  = [UIColor redColor];
    // Do any additional setup after loading the view.
    [self initView];
    EMError *err = [[EMError alloc]init];
    
    [[EMClient sharedClient].contactManager asyncGetContactsFromServer:^(NSArray *aList) {
        NSLog(@"Smirk%@",aList);
        [_list addObjectsFromArray:aList ];
         [self.listView reloadData];
    } failure:^(EMError *aError) {
        NSLog(@"SmirkErr%@",aError);
    }];
    NSLog(@"%f",SCREEN_WIDTH);
   
}
-(void)initView{
    self.list = [[NSMutableArray alloc]init];
    self.listView = [[UITableView alloc]initWithFrame:self.view.frame];
    self.listView.delegate = self;
    self.listView.dataSource = self;
    [self.view addSubview:self.listView];
    

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.list count];

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",self.list[indexPath.row]);
    [self presentViewController:[[ChatListActivityViewController alloc]init] animated:true completion:^{
        NSLog(@"ChatListActivityViewController");
    }];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    NSLog(self.list[indexPath.row]);
    cell.textLabel.text = self.list[indexPath.row];
    cell.backgroundColor = [UIColor purpleColor];
    return cell;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
