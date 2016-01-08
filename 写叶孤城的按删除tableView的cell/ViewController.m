//
//  ViewController.m
//  写叶孤城的按删除tableView的cell
//
//  Created by li on 15/12/27.
//  Copyright © 2015年 li. All rights reserved.
//

#import "ViewController.h"
#import "CustomTableViewCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{

    NSInteger rowCount;
}

@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    rowCount = 20;
    // Do any additional setup after loading the view, typically from a nib.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return rowCount;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.cellIndexpath = indexPath;
    
    cell.cellBlock = ^void(BOOL isdelete,NSIndexPath *index){
        
        if (isdelete) {
            //????
            [_mTableView beginUpdates];
            
            rowCount--;
            [_mTableView deleteRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationRight];
            
            [_mTableView endUpdates];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_mTableView reloadData];
        });
        }
    };
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 200;
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
