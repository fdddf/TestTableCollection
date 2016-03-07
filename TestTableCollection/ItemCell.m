//
//  ItemCell.m
//  TestTableCollection
//
//  Created by Yongliang Wang on 3/4/16.
//  Copyright © 2016 Yongliang Wang. All rights reserved.
//

#import "ItemCell.h"

@implementation ItemCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.textLabel.font = [UIFont boldSystemFontOfSize:20];
        self.textLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.textLabel];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)layoutSubviews
{
    self.textLabel.frame = CGRectMake(0, CGRectGetHeight(self.frame)/2-15, CGRectGetWidth(self.frame), 30);
    
    [super layoutSubviews];
}

@end
