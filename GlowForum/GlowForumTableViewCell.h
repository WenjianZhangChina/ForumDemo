//
//  GFTableViewCell.h
//  GlowForum
//
//  Created by zwj on 15/8/24.
//  Copyright (c) 2015年 SJTU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GlowForumTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UILabel *whoRespondedLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberRespondedLabel;

@property (weak, nonatomic) IBOutlet UIImageView *profile;

- (void)setupCellWithData:(NSDictionary *)data;

@end
