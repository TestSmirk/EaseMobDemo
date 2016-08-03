//
//  InputView.m
//  EaseMob
//
//  Created by TestSmirk on 16/8/3.
//  Copyright © 2016年 TestSmirk. All rights reserved.
//

#import "InputView.h"
@interface InputView()
@property (nonatomic,strong)UITextField * draftText;

@property (nonatomic,strong)UIButton * sendButton;
@end
@implementation InputView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}
-(void)initView{
    [self setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:1]];
    self.draftText = [[UITextField alloc]initWithFrame:CGRectMake(5, 5, SCREEN_WIDTH-50, 40)];
    self.draftText.backgroundColor = [UIColor brownColor];
    self.sendButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-45, 5, SCREEN_WIDTH-(SCREEN_WIDTH-50), 40)];
    self.sendButton.backgroundColor = [UIColor blackColor];
    [self.sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [self.sendButton addTarget:self action:@selector(sendButtonClick) forControlEvents:UIControlEventTouchDown];
    [self addSubview:self.draftText];
    [self addSubview:self.sendButton];
}
-(void)sendButtonClick{
    if(self.buttonClicked)
        self.buttonClicked(self.draftText.text);
    self.draftText.text = @"";
}
@end
