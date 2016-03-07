//
//  TabHeaderView.m
//  TestTableCollection
//
//  Created by Yongliang Wang on 3/4/16.
//  Copyright © 2016 Yongliang Wang. All rights reserved.
//

#import "TabHeaderView.h"

@class TitleView;
@interface TabHeaderView ()
@property(nonatomic, strong) UIScrollView *tabContainerView;
@property(nonatomic, strong) NSMutableArray *titleButtons;
@property(nonatomic, strong) UIView *indicatorView;
@end

#define kTabIndicatorHeight 3.f

@implementation TitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
        self.lineView = [[UIView alloc] init];
        self.lineView.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1];
        [self addSubview:self.lineView];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = [UIColor colorWithRed:0.58 green:0.58 blue:0.58 alpha:1];
        self.titleLabel.font = [UIFont systemFontOfSize:14.f];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.backgroundColor = self.backgroundColor;
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.lineView.frame = CGRectMake(30.f, (CGRectGetHeight(self.frame)-1)/2, CGRectGetWidth(self.frame)-30*2, 1);
    
    [self.titleLabel sizeToFit];
    CGRect frame = self.titleLabel.frame;
    frame.size.width += 20;
    frame.origin.y = (CGRectGetHeight(self.frame)-frame.size.height)/2;
    frame.origin.x = (CGRectGetWidth(self.frame)-frame.size.width)/2;
    self.titleLabel.frame = frame;
}

@end

@implementation TabHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if(self){
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        // Default
        self.titleColor = [UIColor colorWithRed:0.17 green:0.17 blue:0.17 alpha:1];
        self.highlightedTitleColor = [UIColor colorWithRed:0.95 green:0.3 blue:0.29 alpha:1];
        self.indicatorColor = [UIColor colorWithRed:0.94 green:0.15 blue:0.02 alpha:1];
        
        // Subview
        self.titleView = [[TitleView alloc] init];
        self.titleView.titleLabel.text = @"热销推荐";
        [self.contentView addSubview:self.titleView];
        
        self.tabContainerView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        self.tabContainerView.contentSize = CGSizeMake(320, 30);
        self.tabContainerView.bounces = NO;
        self.tabContainerView.showsHorizontalScrollIndicator = NO;
        self.tabContainerView.showsVerticalScrollIndicator = NO;
//        self.tabContainerView.pagingEnabled = YES;
        self.tabContainerView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.tabContainerView];
        
        self.indicatorView = [[UIView alloc] init];
        self.indicatorView.backgroundColor = self.indicatorColor;
        [self.tabContainerView addSubview:self.indicatorView];
        
        self.titleButtons = [NSMutableArray new];
        
        _currentSelectedIndex = 0;
    }
    return self;
}

- (void)setTabTitles:(NSArray *)tabTitles
{
    if(_tabTitles != tabTitles){
        _tabTitles = tabTitles;
        
        [self.titleButtons removeAllObjects];
        for (NSString *title in tabTitles) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:title forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont boldSystemFontOfSize:16.f]];
            [button setTitleColor:self.titleColor forState:UIControlStateNormal];
            [button setTitleColor:self.highlightedTitleColor forState:UIControlStateSelected];
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.tabContainerView addSubview:button];
            [self.titleButtons addObject:button];
        }
        
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 30);
    self.tabContainerView.frame = CGRectMake(0, CGRectGetHeight(self.titleView.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-CGRectGetHeight(self.titleView.frame));
    self.indicatorView.backgroundColor = self.indicatorColor;
    
    UIButton *lastButton = nil;
    CGFloat width = 0.f;
    for (UIButton *button in self.titleButtons) {
        [button setTitleColor:self.titleColor forState:UIControlStateNormal];
        [button setTitleColor:self.highlightedTitleColor forState:UIControlStateSelected];
        
        [button sizeToFit];
        CGRect frame = button.frame;
        frame.size.height = CGRectGetHeight(self.frame);
        frame.size.width = MAX(100, frame.size.width + 20);
        frame.origin.x = lastButton ? CGRectGetMaxX(lastButton.frame) : 0;
        frame.origin.y = (CGRectGetHeight(self.tabContainerView.frame)-CGRectGetHeight(frame))/2;
        button.frame = frame;
        
        width += CGRectGetWidth(frame);
        lastButton = button;
        
        button.selected = NO;
        if([button isEqual:self.titleButtons[_currentSelectedIndex]]){
            button.selected = YES;
            self.indicatorView.frame = CGRectMake(CGRectGetMinX(button.frame), CGRectGetHeight(self.tabContainerView.frame)-kTabIndicatorHeight, CGRectGetWidth(button.frame), kTabIndicatorHeight);
        }
    }
    
    [self.tabContainerView setContentSize:CGSizeMake(MAX(CGRectGetWidth(self.frame), width), CGRectGetHeight(self.frame)-CGRectGetHeight(self.titleView.frame))];
}

- (void)buttonClicked:(id)sender
{
    NSInteger index = [self.titleButtons indexOfObject:sender];
//    NSLog(@"%ld clicked", index);
    [self setSelected:index animated:YES];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(tabButtonClicked:index:)]){
        [self.delegate tabButtonClicked:self index:index];
    }
}

- (void)setSelected:(NSInteger)index animated:(BOOL)animated
{
    _currentSelectedIndex = index;
    if(animated){
        UIButton *button = self.titleButtons[index];
        [UIView animateWithDuration:0.3f animations:^{
            self.indicatorView.frame = CGRectMake(CGRectGetMinX(button.frame), CGRectGetHeight(self.tabContainerView.frame)-kTabIndicatorHeight, CGRectGetWidth(button.frame), kTabIndicatorHeight);
        } completion:^(BOOL finished) {
            [self setNeedsLayout];
        }];
    }else{
        [self setNeedsLayout];
    }
}

@end
