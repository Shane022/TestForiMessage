//
//  MessagesViewController.m
//  MessagesExtension
//
//  Created by dvt04 on 16/9/29.
//  Copyright © 2016年 new. All rights reserved.
//

#import "MessagesViewController.h"
#import "StickerBrowserViewController.h"

@interface MessagesViewController ()

@end

@implementation MessagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    // 展开或折叠页面
//    [self requestPresentationStyle:MSMessagesAppPresentationStyleExpanded];
    [self setupLayoutAndInitData];
}

- (void)setupLayoutAndInitData {
    NSArray *arrBtnTitles = @[@"caption",@"sticker",@"attachment"];
    NSArray *arrBtnColors = @[[UIColor orangeColor],[UIColor greenColor],[UIColor blueColor]];
    NSInteger btnNumber = 3;
    CGFloat margion = 20;
//    CGFloat btnWidth = (self.view.frame.size.width-(btnNumber+1)*margion)/btnNumber;
    for (int i = 0; i < btnNumber; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(60*i+margion*(i+1), 10, 60, 60);
        btn.layer.masksToBounds = NO;
        btn.layer.cornerRadius = 30;
        [btn setTitle:[arrBtnTitles objectAtIndex:i] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:10]];
        [btn setBackgroundColor:[arrBtnColors objectAtIndex:i]];
        [btn setTag:1000+i];
        [btn addTarget:self action:@selector(onHitBtnTest:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

- (void)onHitBtnTest:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == 1000) {
        MSMessage *message = [[MSMessage alloc] init];
        message.URL = [NSURL URLWithString:@"www.baidu.com"];
        
        MSMessageTemplateLayout *layout = [[MSMessageTemplateLayout alloc] init];
        layout.imageTitle = @"title";
        layout.imageSubtitle = @"subtitle";
        layout.caption = @"caption";
        layout.subcaption =  @"subcaption";
        layout.trailingCaption = @"trailingCaption";
        layout.trailingSubcaption = @"trailingSubcaption";
        layout.mediaFileURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"002" ofType:@"png"]];
        message.layout = layout;
        [self.activeConversation insertMessage:message completionHandler:^(NSError * _Nullable error) {
            
        }];
    } else if (btn.tag == 1001) {
        NSURL *fileURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"002" ofType:@"png"]];
        MSSticker *sticker = [[MSSticker alloc] initWithContentsOfFileURL:fileURL localizedDescription:@"wenben " error:nil];
        [self.activeConversation insertSticker:sticker completionHandler:^(NSError * _Nullable error) {
            
        }];
    } else if (btn.tag == 1002) {
        [self.activeConversation insertAttachment:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"video incoming call rev" ofType:@"mp3"]] withAlternateFilename:@"test" completionHandler:^(NSError * _Nullable error) {
            
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Conversation Handling

-(void)didBecomeActiveWithConversation:(MSConversation *)conversation {
    // 释放共有的资源、存储用户数据、注销timer和存贮足够的状态信息来当它崩溃时可以来恢复你的拓展的状态.
    // Called when the extension is about to move from the inactive to active state.
    // This will happen when the extension is about to present UI.
    
    // Use this method to configure the extension and restore previously stored state.
}

-(void)willResignActiveWithConversation:(MSConversation *)conversation {
    // Called when the extension is about to move from the active to inactive state.
    // This will happen when the user dissmises the extension, changes to a different
    // conversation or quits Messages.
    
    // Use this method to release shared resources, save user data, invalidate timers,
    // and store enough state information to restore your extension to its current state
    // in case it is terminated later.
}

-(void)didReceiveMessage:(MSMessage *)message conversation:(MSConversation *)conversation {
    // Called when a message arrives that was generated by another instance of this
    // extension on a remote device.
    
    // Use this method to trigger UI updates in response to the message.
}

-(void)didStartSendingMessage:(MSMessage *)message conversation:(MSConversation *)conversation {
    // Called when the user taps the send button.
}

-(void)didCancelSendingMessage:(MSMessage *)message conversation:(MSConversation *)conversation {
    // Called when the user deletes the message without sending it.
    
    // Use this to clean up state related to the deleted message.
}

-(void)willTransitionToPresentationStyle:(MSMessagesAppPresentationStyle)presentationStyle {
    NSLog(@"willTransitionToPresentationStyle:%lu",(unsigned long)presentationStyle);
    if (presentationStyle == MSMessagesAppPresentationStyleExpanded) {
        [UIView animateWithDuration:1.0 animations:^{
            CGRect newFrame = self.view.frame;
            newFrame.origin.y += 86;
            [self.view setFrame:newFrame];
        }];
    } else {
        [UIView animateWithDuration:1.0 animations:^{
            CGRect newFrame = self.view.frame;
            newFrame.origin.y -= 86;
            [self.view setFrame:newFrame];
        }];
    }
}

-(void)didTransitionToPresentationStyle:(MSMessagesAppPresentationStyle)presentationStyle {
    NSLog(@"didTransitionToPresentationStyle:%lu",(unsigned long)presentationStyle);
}

@end