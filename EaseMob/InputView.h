//
//  InputView.h
//  EaseMob
//
//  Created by TestSmirk on 16/8/3.
//  Copyright © 2016年 TestSmirk. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ButtonClicked) (NSString *draftText);
@interface InputView : UIView
@property (nonatomic,copy)ButtonClicked buttonClicked;
@end
