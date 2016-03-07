//
//  CollectionViewCell.m
//  TestTableCollection
//
//  Created by Yongliang Wang on 3/4/16.
//  Copyright © 2016 Yongliang Wang. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.itemCell1 = [[ItemCell alloc] initWithFrame:CGRectZero];
        self.itemCell1.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:self.itemCell1];
        
        self.itemCell2 = [[ItemCell alloc] initWithFrame:CGRectZero];
        self.itemCell2.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.itemCell2];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews
{
    self.itemCell1.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame));
    self.itemCell2.frame = CGRectMake(CGRectGetMaxX(self.itemCell1.frame), 0, CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame));
    
    [super layoutSubviews];
}

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
