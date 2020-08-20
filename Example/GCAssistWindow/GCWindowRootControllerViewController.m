//
//  GCWindowRootControllerViewController.m
//  GCAssistWindow_Example
//
//  Created by yons on 2020/8/18.
//  Copyright © 2020 guochaoliu. All rights reserved.
//

#import "GCWindowRootControllerViewController.h"
#import <GCAssistWindow/GCAssistWindowManager.h>

@interface GCWindowRootControllerViewController ()
/// 注销当前
@property (nonatomic, strong) UIButton *cancelButton;
/// 注销全部
@property (nonatomic, strong) UIButton *cancelMoreButton;
@end

@implementation GCWindowRootControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cancelButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.cancelButton setBackgroundColor:[UIColor blueColor]];
    [self.cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.cancelButton setTitle:@"注销window" forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cancelButton];
    self.cancelMoreButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.cancelMoreButton setBackgroundColor:[UIColor redColor]];
    [self.cancelMoreButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.cancelMoreButton setTitle:@"注销全部window" forState:UIControlStateNormal];
    [self.cancelMoreButton addTarget:self action:@selector(cancelMoreButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cancelMoreButton];
}
- (void)viewWillLayoutSubviews{
    CGFloat width = (self.view.bounds.size.width - 100) / 2;
    self.cancelButton.frame = CGRectMake(50, 200, width, 44);
    self.cancelMoreButton.frame = CGRectMake(50 + width, 200, width, 44);
}
- (void)cancelButtonAction{
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:^{
            [[GCAssistWindowManager manager] deallocWindowWithIdentifier:self.identifier];
        }];
        return;
    }
    [[GCAssistWindowManager manager] deallocWindowWithIdentifier:self.identifier];
}
- (void)cancelMoreButtonAction{
    [[GCAssistWindowManager manager] removeAllWindows];
}
- (void)setIdentifier:(NSString *)identifier{
    _identifier = identifier;
    self.title = identifier;
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
