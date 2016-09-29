//
//  StickerBrowserViewController.m
//  TestForiMessage
//
//  Created by dvt04 on 16/9/29.
//  Copyright © 2016年 new. All rights reserved.
//

#import "StickerBrowserViewController.h"

@interface StickerBrowserViewController ()

@end

@implementation StickerBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfStickersInStickerBrowserView:(MSStickerBrowserView *)stickerBrowserView {
    return 1;
}

-(MSSticker *)stickerBrowserView:(MSStickerBrowserView *)stickerBrowserView stickerAtIndex:(NSInteger)index
{
    
    NSURL *fileURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"002" ofType:@"png"]];
    MSSticker *ticker = [[MSSticker alloc] initWithContentsOfFileURL:fileURL localizedDescription:@"文本" error:nil];
    
    return ticker;
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
