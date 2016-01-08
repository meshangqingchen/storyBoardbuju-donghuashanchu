//
//  CustomTableViewCell.h
//  写叶孤城的按删除tableView的cell
//
//  Created by li on 15/12/27.
//  Copyright © 2015年 li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UIView *containeView;
@property (nonatomic,strong) NSIndexPath *cellIndexpath;
@property(nonatomic,copy) void(^cellBlock)(BOOL isDelete ,NSIndexPath *path);


@end
