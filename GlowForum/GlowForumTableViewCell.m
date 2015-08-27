//
//  GFTableViewCell.m
//  GlowForum
//
//  Created by zwj on 15/8/24.
//  Copyright (c) 2015年 SJTU. All rights reserved.
//

#import "GlowForumTableViewCell.h"
#import "UIImage+ScaleToSize.h"

@implementation GlowForumTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupCellWithData:(NSDictionary *)data {
    // first line -- tag
    NSMutableString *tag = [[NSMutableString alloc] initWithString:[data objectForKeyedSubscript:@"tag"]];
    [tag appendString:@" >"];
    self.tagLabel.text = tag;
    
    // second line -- the last person who responded
    NSArray *commentsArray = [data objectForKey:@"comments"];
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"time_created" ascending:NO]];
    [commentsArray sortedArrayUsingDescriptors:sortDescriptors];
    NSArray *sortedCommentsArray = [commentsArray sortedArrayUsingDescriptors:sortDescriptors];
    self.whoRespondedLabel.numberOfLines = 0;
    NSDictionary *respondedDict = [sortedCommentsArray objectAtIndex:0];
    NSDictionary *commentsAuthorDict = [respondedDict objectForKey:@"author"];
    NSString *whoResponded = [commentsAuthorDict objectForKey:@"first_name"];
    NSMutableString *whoRespondedPlus = [[NSMutableString alloc]initWithString:whoResponded];
    [whoRespondedPlus appendString:@" responded: "];
    NSMutableAttributedString *whoRespondedResponded = [[NSMutableAttributedString alloc] initWithString:whoRespondedPlus];
    NSUInteger len = whoResponded.length;
    [whoRespondedResponded addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0,len)];
    [whoRespondedResponded addAttribute:NSForegroundColorAttributeName value:[[UIColor alloc] initWithRed:0.3 green:0.3 blue:0.3 alpha:0.5] range:NSMakeRange(len+1, 10)];
    self.whoRespondedLabel.attributedText = whoRespondedResponded;
    
    // third line -- the title
    self.titleLabel.text = [data objectForKey:@"title"];
    // fourth line -- content
    self.contentLabel.text = [data objectForKey:@"content"];
    
    // fifth line -- number of people responded
    NSUInteger count = commentsArray.count;
    NSMutableString *numberResponded = [[NSMutableString alloc] initWithFormat:@"%lul", (unsigned long)count];
    [numberResponded appendString:@" responses"];
    self.numberRespondedLabel.text = numberResponded;
    
    // profile of the author
    NSDictionary *author = [data objectForKey:@"author"];
    NSString *profileURL = [author objectForKey:@"profile_image"];
    UIImage *profileImage = [UIImage alloc];
    if (profileURL.length == 0) {
            profileImage = [UIImage imageNamed:@"glow"];
    }else if (profileURL.length == 1) {
        profileImage = [UIImage imageNamed:@"Wenjian"];
    }else{
            profileImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:profileURL]]];
    }
    CGSize reSize = CGSizeMake(50, 50);
    UIImage *smallProfile = [profileImage reSizeImage:profileImage toSize:reSize];
    self.profile.image = smallProfile;
    self.profile.layer.cornerRadius = 25;
    self.profile.layer.masksToBounds = true;
}

@end
