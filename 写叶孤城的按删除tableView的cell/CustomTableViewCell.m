//
//  CustomTableViewCell.m
//  写叶孤城的按删除tableView的cell
//
//  Created by li on 15/12/27.
//  Copyright © 2015年 li. All rights reserved.
//

#import "CustomTableViewCell.h"

@interface  CustomTableViewCell()
{
    UIView *snapView;
    
}
@end

@implementation CustomTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _containeView.layer.cornerRadius = 4;
    _shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    _shadowView.layer.shadowOffset = CGSizeMake(2, 2);
    
    _shadowView.layer.shadowOpacity = 0.5;
    _shadowView.layer.shadowRadius = 5;
    
    UILongPressGestureRecognizer *longParess = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongpressGetture:)];
    [self.contentView addGestureRecognizer:longParess];
    
}

-(void)handleLongpressGetture:(UILongPressGestureRecognizer*)gesture{
    CGPoint startPoint = CGPointZero;
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:{
            //_containerView no代表被渲染之后生成一个快照
            snapView = [_containeView snapshotViewAfterScreenUpdates:NO];
            
            
            //重新定义锚点 因为我们稍微移动一毫米手势就变成changed状态snapView.layer.position 点就是我们点击屏幕的点这个点会从锚点开始我们想达到目的是我们点击屏幕的点就是锚点，这样snapView才不会唰的动。
            
            startPoint = [gesture locationInView:self.contentView];
            snapView.layer.anchorPoint = CGPointMake((startPoint.x-20)/snapView.layer.frame.size.width, (startPoint.y-10)/snapView.layer.frame.size.height);
           // snapView.layer.anchorPoint = CGPointMake(0, 0);
            snapView.frame = _containeView.frame;
            snapView.transform = CGAffineTransformMakeRotation(M_PI/30);
            [self.contentView addSubview:snapView];
            self.containeView.hidden = YES;
            _shadowView.hidden = YES;
            
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            CGPoint changePoint = [gesture locationInView:self.contentView];
            
            NSLog(@"%@",NSStringFromCGPoint(changePoint));
            
            
            [UIView animateWithDuration:0.05 animations:^{
                snapView.layer.position = changePoint;
                
            }];
            
            break;
        }
        case UIGestureRecognizerStateEnded:
        {
            CGPoint endPoint = [gesture locationInView:self.contentView];
            
            if (endPoint.x > self.contentView.frame.size.width-50) {
                
                if (self.cellBlock) {
                    
                    self.cellBlock(YES,_cellIndexpath);
                }
            }
            else{
            //endPoint.x <= self.contentView.frame.size.width-50
                if (self.cellBlock) {
                    self.cellBlock(NO,_cellIndexpath);
                }
                
            }
            [snapView removeFromSuperview];
            self.containeView.hidden = NO;
            self.shadowView.hidden  = NO;
            break;
        }
            
        default:
            break;
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
