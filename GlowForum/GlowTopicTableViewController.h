//
//  GlowTopicTableViewController.h
//  GlowForum
//
//  Created by zwj on 15/8/25.
//  Copyright (c) 2015年 SJTU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlowTopicTableViewCell.h"
#import "GlowCommentsTableViewCell.h"
#import "GlowResizingProtocol.h"
#import "AppDelegate.h"

@interface GlowTopicTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *jsonArray;
@property (strong, nonatomic) NSDictionary *jsonDict;
@property (strong, nonatomic) NSArray *sortedCommentsArray;

@end
