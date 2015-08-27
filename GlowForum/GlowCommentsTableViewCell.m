//
//  GlowCommentsTableViewCell.m
//  GlowForum
//
//  Created by zwj on 15/8/25.
//  Copyright (c) 2015年 SJTU. All rights reserved.
//

#import "GlowCommentsTableViewCell.h"

@interface GlowCommentsTableViewCell ()

@property (nonatomic, strong) UIImageView *profileImageView;
@property (nonatomic, strong) UILabel *first_nameLabel;
@property (nonatomic, strong) UILabel *commentLabel;

@end

@implementation GlowCommentsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void) setupView {
    
    self.backgroundColor = [UIColor whiteColor];
    self.accessoryType = UITableViewCellAccessoryNone;
    self.accessoryView = nil;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Fix for contentView constraint warning
    [self.contentView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    
    self.profileImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.profileImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.profileImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.profileImageView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.profileImageView];
    
    self.first_nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.first_nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.first_nameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
    self.first_nameLabel.textColor = [UIColor blueColor];
    self.first_nameLabel.numberOfLines = 1;
    self.first_nameLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [self.contentView addSubview:self.first_nameLabel];
    
    self.commentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.commentLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.commentLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:15];
    self.commentLabel.textColor = [UIColor blackColor];
    [self.commentLabel setNumberOfLines:0];
    self.commentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.commentLabel sizeToFit];
    [self.contentView addSubview:self.commentLabel];
    
    
    // constrain
    NSDictionary *viewDict = NSDictionaryOfVariableBindings(_profileImageView, _first_nameLabel, _commentLabel);
    NSDictionary *metricDict = @{@"sideBuffer" : @20, @"verticalBuffer" : @20, @"imageSize" : @50};
    
    // horizontally
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-sideBuffer-[_first_nameLabel]" options:0 metrics:metricDict views:viewDict]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_profileImageView]-sideBuffer-|" options:0 metrics:metricDict views:viewDict]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-sideBuffer-[_commentLabel]" options:0 metrics:metricDict views:viewDict]];
    // vertically
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-verticalBuffer-[_first_nameLabel]-verticalBuffer-[_commentLabel]-verticalBuffer-|" options:0 metrics:metricDict views:viewDict]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-verticalBuffer-[_profileImageView]" options:0 metrics:metricDict views:viewDict]];
    
    [self.first_nameLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.first_nameLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self.commentLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.commentLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    
    CGSize dafaultSize = DEFAULT_CELL_SIZE;
    self.commentLabel.preferredMaxLayoutWidth = dafaultSize.width - ([metricDict[@"sideBuffer"] floatValue] * 2);
}

- (void) setupCellWithData:(NSDictionary *)data {
    // 发帖
    NSDictionary *author = [data objectForKey:@"author"];
    NSString *firstname = [author objectForKey:@"first_name"];
    NSMutableString *first_name = [[NSMutableString alloc] initWithString:firstname];
    NSNumber *created_time = [data objectForKey:@"time_created"];
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    NSString *created = [numberFormatter stringFromNumber:created_time];
    NSString *timeAgo = [created calculateUpLoadTime];
    [first_name appendString:timeAgo];
    self.first_nameLabel.text = first_name;
    
    // 从URL加载头像，当没有头像的时候用Glow代替
    // 这里偷偷地把我头像加了进去，嘿嘿
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
    self.profileImageView.image = smallProfile;
    self.profileImageView.layer.cornerRadius = 25;
    self.profileImageView.layer.masksToBounds = true;
    
    NSString *content = [data objectForKey:@"content"];
    self.commentLabel.text = content;

}

@end
