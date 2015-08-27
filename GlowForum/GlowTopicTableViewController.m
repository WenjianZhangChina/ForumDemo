//
//  GlowTopicTableViewController.m
//  GlowForum
//
//  Created by zwj on 15/8/25.
//  Copyright (c) 2015年 SJTU. All rights reserved.
//

#import "GlowTopicTableViewController.h"

static NSString *GlowTopicTableViewCellIdentifier = @"topicCellIdentifer";
static NSString *GlowCommentsTableViewCellIdentifier = @"commentsCellIdentifer";

@interface GlowTopicTableViewController ()

@end

@implementation GlowTopicTableViewController

- (void)setupData {
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *jsonPath = [bundle pathForResource:@"glowdata" ofType:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:jsonPath];
    
    self.jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:NULL];
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    self.jsonDict = [self.jsonArray objectAtIndex:delegate.select];
    // sort by time_created
    NSArray *commentsArray = [self.jsonDict objectForKey:@"comments"];
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"time_created" ascending:NO]];
    [commentsArray sortedArrayUsingDescriptors:sortDescriptors];
    self.sortedCommentsArray = [commentsArray sortedArrayUsingDescriptors:sortDescriptors];
}

- (void)loadView {
    // Setup our TableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    // Register our cell
    [self.tableView registerClass:[GlowTopicTableViewCell class] forCellReuseIdentifier:GlowTopicTableViewCellIdentifier];
    [self.tableView registerClass:[GlowCommentsTableViewCell class] forCellReuseIdentifier:GlowCommentsTableViewCellIdentifier];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sortedCommentsArray count]+1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // first line is the topic theme
    if (indexPath.row == 0) {
        GlowTopicTableViewCell *topicCell = (GlowTopicTableViewCell *)[tableView dequeueReusableCellWithIdentifier:GlowTopicTableViewCellIdentifier forIndexPath:indexPath];
        // Load data
        [topicCell setupCellWithData:self.jsonDict];
        //NSLog(@"%@", self.jsonDict);
        return topicCell;
    }else{
        GlowCommentsTableViewCell *commentCell = (GlowCommentsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:GlowCommentsTableViewCellIdentifier forIndexPath:indexPath];
        
        NSDictionary *sortedDict = [self.sortedCommentsArray objectAtIndex:indexPath.row-1];
        [commentCell setupCellWithData:sortedDict];
        
        return commentCell;
    }
}

// tableView的Cell自适应高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf = self;
    CGSize defaultSize = DEFAULT_CELL_SIZE;
    if (indexPath.row == 0) {
        // Create our size
        CGSize topicCellSize = [GlowTopicTableViewCell sizeForCellWithDefaultSize:defaultSize setupCellBlock:^id(id<GlowResizingProtocol> cellToSetup)  {
          
           NSDictionary *dataDict = weakSelf.jsonDict;
            [((GlowTopicTableViewCell *)cellToSetup) setupCellWithData:dataDict];
            
            return cellToSetup;
        }];
        
        return topicCellSize.height;
    }else{
        
        // Create our size
        CGSize commentCellSize = [GlowCommentsTableViewCell sizeForCellWithDefaultSize:defaultSize setupCellBlock:^id(id<GlowResizingProtocol> cellToSetup)  {
            
            NSDictionary *sortedDict = [self.sortedCommentsArray objectAtIndex:indexPath.row-1];
            [((GlowCommentsTableViewCell *)cellToSetup) setupCellWithData:sortedDict];
            
            return cellToSetup;
        }];
        return commentCellSize.height+20;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
