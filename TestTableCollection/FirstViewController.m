//
//  FirstViewController.m
//  TestTableCollection
//
//  Created by Yongliang Wang on 3/3/16.
//  Copyright © 2016 Yongliang Wang. All rights reserved.
//

#import "FirstViewController.h"
#import "TabHeaderView.h"
#import "CollectionViewCell.h"

@interface FirstViewController ()<TabHeaderViewDelegate>

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
    
    [self.tableView registerClass:[CollectionViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.tableView registerClass:[TabHeaderView class] forHeaderFooterViewReuseIdentifier:@"Header"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return floor(11/2);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = (CollectionViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
//    cell.textLabel.text = [NSString stringWithFormat:@"Cell %ld", (long)indexPath.row];
    NSInteger index = indexPath.row * 2;
    cell.itemCell1.textLabel.text = [NSString stringWithFormat:@"Cell %ld", (long)index];
    cell.itemCell2.textLabel.text = [NSString stringWithFormat:@"Cell %ld", (long)(index+1)];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{    
    if(section==0)
        return nil;
    else{
     
        TabHeaderView *view = (TabHeaderView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Header"];
        view.titleView.titleLabel.text = @"不推荐这个啦";
        view.delegate = self;
        [view setTabTitles:@[@"发工资", @"不要脸", @"滚犊子", @"无语", @"你怎么想", @"泡面都吃不起了"]];
        return view;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section==0 ? 0 : 80.f;
}


- (void)tabButtonClicked:(TabHeaderView *)headerView index:(NSInteger)index
{
    NSLog(@"button %ld clicked", (long)index);
}

@end
