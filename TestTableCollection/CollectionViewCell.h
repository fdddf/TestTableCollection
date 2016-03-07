//
//  CollectionViewCell.h
//  TestTableCollection
//
//  Created by Yongliang Wang on 3/4/16.
//  Copyright © 2016 Yongliang Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemCell.h"

@interface CollectionViewCell : UITableViewCell
@property(nonatomic, strong) ItemCell *itemCell1;
@property(nonatomic, strong) ItemCell *itemCell2;
@end
