//
//  GCViewController.m
//  GCAssistWindow
//
//  Created by guochaoliu on 08/18/2020.
//  Copyright (c) 2020 guochaoliu. All rights reserved.
//

#import "GCViewController.h"
#import "GCWindowRootControllerViewController.h"
#import <GCAssistWindow/GCAssistWindowManager.h>

#define Random_Color [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0]
static NSString *cellID = @"cellID";
@interface GCViewController ()<UITableViewDelegate,UITableViewDataSource>
/// tableView
@property (nonatomic, strong) UITableView *tableView;
/// titleArray
@property (nonatomic, strong) NSArray *titleArray;
@end

@implementation GCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.titleArray = @[@"window展示",@"多window展示",@"present动画"];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    [self.view addSubview:self.tableView];
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}
#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            NSString *identifier = [NSString stringWithFormat:@"identifier%ld",(long)indexPath.row];
            UIWindow * window = [[GCAssistWindowManager manager] makeWindowWithIdentifier:identifier];
            GCWindowRootControllerViewController *vc = [[GCWindowRootControllerViewController alloc] init];
            vc.view.backgroundColor = Random_Color;
            vc.identifier = identifier;
            window.rootViewController = vc;
        }
            break;
        case 1:
        {
            for (int i = 0; i < 5; i ++) {
                NSString *identifier = [NSString stringWithFormat:@"identifier%d",i];
                GCWindowRootControllerViewController *vc = [[GCWindowRootControllerViewController alloc] init];
                vc.view.backgroundColor = Random_Color;
                vc.identifier = identifier;
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
                [[GCAssistWindowManager manager] makeKeyWindowWithRootViewController:nav identifier:identifier];
            }
        }
            break;
        case 2:
        {
            NSString *identifier = [NSString stringWithFormat:@"identifier%ld",(long)indexPath.row];
            UIViewController *vc = [[UIViewController alloc] init];
            vc.view.backgroundColor = Random_Color;
            [[GCAssistWindowManager manager] makeKeyWindowWithRootViewController:vc identifier:identifier];
            GCWindowRootControllerViewController *windowVC = [[GCWindowRootControllerViewController alloc] init];
            windowVC.view.backgroundColor = Random_Color;
            windowVC.identifier = identifier;
            [vc presentViewController:windowVC animated:YES completion:^{
                
            }];
        }
            break;
        default:
            break;
    }
}
#pragma mark -- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.textLabel.text = self.titleArray[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
