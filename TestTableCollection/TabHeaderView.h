//
//  TabHeaderView.h
//  TestTableCollection
//
//  Created by Yongliang Wang on 3/4/16.
//  Copyright © 2016 Yongliang Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TabHeaderView;
@protocol TabHeaderViewDelegate <NSObject>

@optional
- (void)tabButtonClicked:(TabHeaderView *)headerView index:(NSInteger)index;

@end

@class TitleView;
@interface TabHeaderView : UITableViewHeaderFooterView
@property(nonatomic, strong) NSArray *tabTitles;
@property(nonatomic, assign, readonly) NSInteger currentSelectedIndex;
@property(nonatomic, assign) id<TabHeaderViewDelegate> delegate;
@property(nonatomic, strong) UIColor *titleColor;
@property(nonatomic, strong) UIColor *highlightedTitleColor;
@property(nonatomic, strong) UIColor *indicatorColor;
@property(nonatomic, strong) TitleView *titleView;

- (void)setSelected:(NSInteger)index animated:(BOOL)animated;
@end


@interface TitleView : UIView
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIView *lineView;
@end