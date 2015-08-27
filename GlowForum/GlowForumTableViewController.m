//
//  GlowForumTableViewController.m
//  GlowForum
//
//  Created by zwj on 15/8/24.
//  Copyright (c) 2015年 SJTU. All rights reserved.
//

#import "GlowForumTableViewController.h"
#import "GlowForumTableViewCell.h"
#import "AppDelegate.h"

@interface GlowForumTableViewController ()

@end

@implementation GlowForumTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 解析JSON文件
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *jsonPath = [bundle pathForResource:@"glowdata" ofType:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:jsonPath];
    self.jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:NULL];
    //  add a refreshControl
    UIRefreshControl *refreshController = [[UIRefreshControl alloc] init];
    refreshController.attributedTitle = [[NSAttributedString alloc] initWithString:@"pull to refresh"];
    [refreshController addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshController;
}

// pull to refresh
- (void) refreshTableView {
    if (self.refreshControl.refreshing) {
        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"loading..."];
        
        [self.refreshControl endRefreshing];
        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"pull to refresh"];
        [self.tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return [self.jsonArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GlowForumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"simpleTableIdentifier" forIndexPath:indexPath];
    NSDictionary *jsonDict = [self.jsonArray objectAtIndex:indexPath.row];
    [cell setupCellWithData:jsonDict];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}

// 纪录点击的行数，传递到下一视图
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    delegate.select = indexPath.row;
}

@end
