//
//  ChatListActivityViewController.m
//  EaseMob
//
//  Created by TestSmirk on 16/8/3.
//  Copyright © 2016年 TestSmirk. All rights reserved.
//

#import "ChatListActivityViewController.h"
#import "InputView.h"
#import "EMSDK.h"
@interface ChatListActivityViewController ()<UITableViewDelegate,UITableViewDataSource,EMChatManagerDelegate>
@property (nonatomic,strong) UITableView *tabview;
@property (nonatomic,strong) InputView *inputView;
@property (nonatomic,strong) NSMutableArray *list;
@end

@implementation ChatListActivityViewController

- (void)viewDidLoad {
    //图片
    
   self.inputView =  [[InputView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
    [super viewDidLoad];
    self.tabview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-50)];
    self.tabview.delegate = self;
    self.tabview.dataSource = self;
    __weak typeof(self) weakSelf = self;
    self.inputView.buttonClicked =^(NSString * click) {
        [weakSelf clickedSendMessage:click];
    };
    self.tabview.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.tabview];
    [self.view addSubview:self.inputView];
    // Do any additional setup after loading the view.
    
    self.list = [[NSMutableArray alloc]init];
    [self registReciveMessage];
}
-(void)registReciveMessage{
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.list.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.textLabel.text = self.list[indexPath.row];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)clickedSendMessage:(NSString *)message{
    if(message.length<=0)return;
    NSLog(@"clickedSendMessage %@",message);
    [self.list addObject:message];
    
    //发送消息
    EMTextMessageBody *body = [[EMTextMessageBody alloc]initWithText:message];
    NSString *from = [[EMClient sharedClient]currentUsername];
  
    
    [[EMClient sharedClient].chatManager asyncSendMessage:[[EMMessage alloc]initWithConversationID:@"" from:@"" to:@"test" body:body ext:nil] progress:nil completion:^(EMMessage *message, EMError *error) {
        NSLog(@"send message complate EMMessage: %u , EMError",message.status,error.errorDescription);
        if (message.status ==2) {
            [self.tabview reloadData];
        }
    }];
    
}


#pragma mark 收到消息callback
- (void)didReceiveMessages:(NSArray *)aMessages{
    for (EMMessage *message in aMessages) {
        EMMessageBody *msgBody = message.body;
        switch (msgBody.type) {
            case EMMessageBodyTypeText:
            {
                // 收到的文字消息
                EMTextMessageBody *textBody = (EMTextMessageBody *)msgBody;
                NSString *txt = textBody.text;
                NSLog(@"收到的文字是 txt -- %@",txt);
                [self.list addObject:txt];
                
            }
                break;
            case EMMessageBodyTypeImage:
            {
                // 得到一个图片消息body
                EMImageMessageBody *body = ((EMImageMessageBody *)msgBody);
                NSLog(@"大图remote路径 -- %@"   ,body.remotePath);
                NSLog(@"大图local路径 -- %@"    ,body.localPath); // // 需要使用sdk提供的下载方法后才会存在
                NSLog(@"大图的secret -- %@"    ,body.secretKey);
                NSLog(@"大图的W -- %f ,大图的H -- %f",body.size.width,body.size.height);
                NSLog(@"大图的下载状态 -- %u",body.downloadStatus);
                
                
                // 缩略图sdk会自动下载
                NSLog(@"小图remote路径 -- %@"   ,body.thumbnailRemotePath);
                NSLog(@"小图local路径 -- %@"    ,body.thumbnailLocalPath);
                NSLog(@"小图的secret -- %@"    ,body.thumbnailSecretKey);
                NSLog(@"小图的W -- %f ,大图的H -- %f",body.thumbnailSize.width,body.thumbnailSize.height);
                NSLog(@"小图的下载状态 -- %u",body.thumbnailDownloadStatus);
            }
                break;
            case EMMessageBodyTypeLocation:
            {
                EMLocationMessageBody *body = (EMLocationMessageBody *)msgBody;
                NSLog(@"纬度-- %f",body.latitude);
                NSLog(@"经度-- %f",body.longitude);
                NSLog(@"地址-- %@",body.address);
            }
                break;
            case EMMessageBodyTypeVoice:
            {
                // 音频sdk会自动下载
                EMVoiceMessageBody *body = (EMVoiceMessageBody *)msgBody;
                NSLog(@"音频remote路径 -- %@"      ,body.remotePath);
                NSLog(@"音频local路径 -- %@"       ,body.localPath); // 需要使用sdk提供的下载方法后才会存在（音频会自动调用）
                NSLog(@"音频的secret -- %@"        ,body.secretKey);
                NSLog(@"音频文件大小 -- %lld"       ,body.fileLength);
                NSLog(@"音频文件的下载状态 -- %u"   ,body.downloadStatus);
                NSLog(@"音频的时间长度 -- %u"      ,body.duration);
            }
                break;
            case EMMessageBodyTypeVideo:
            {
                EMVideoMessageBody *body = (EMVideoMessageBody *)msgBody;
                
                NSLog(@"视频remote路径 -- %@"      ,body.remotePath);
                NSLog(@"视频local路径 -- %@"       ,body.localPath); // 需要使用sdk提供的下载方法后才会存在
                NSLog(@"视频的secret -- %@"        ,body.secretKey);
                NSLog(@"视频文件大小 -- %lld"       ,body.fileLength);
                NSLog(@"视频文件的下载状态 -- %u"   ,body.downloadStatus);
                NSLog(@"视频的时间长度 -- %d"      ,body.duration);
                NSLog(@"视频的W -- %f ,视频的H -- %f", body.thumbnailSize.width, body.thumbnailSize.height);
                
                // 缩略图sdk会自动下载
                NSLog(@"缩略图的remote路径 -- %@"     ,body.thumbnailRemotePath);
                NSLog(@"缩略图的local路径 -- %@"      ,body.thumbnailLocalPath);
                NSLog(@"缩略图的secret -- %@"        ,body.thumbnailSecretKey);
                NSLog(@"缩略图的下载状态 -- %u"      ,body.thumbnailDownloadStatus);
            }
                break;
            case EMMessageBodyTypeFile:
            {
                EMFileMessageBody *body = (EMFileMessageBody *)msgBody;
                NSLog(@"文件remote路径 -- %@"      ,body.remotePath);
                NSLog(@"文件local路径 -- %@"       ,body.localPath); // 需要使用sdk提供的下载方法后才会存在
                NSLog(@"文件的secret -- %@"        ,body.secretKey);
                NSLog(@"文件文件大小 -- %lld"       ,body.fileLength);
                NSLog(@"文件文件的下载状态 -- %u"   ,body.downloadStatus);
            }
                break;
                
            default:
                break;
        }
    }
    [self.tabview reloadData];
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
