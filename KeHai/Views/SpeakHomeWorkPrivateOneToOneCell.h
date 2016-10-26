//
//  SpeakHomeWorkPrivateOneToOneCell.h
//  KeHai
//
//  Created by 三海 on 16/10/25.
//  Copyright © 2016年 陈高健. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpeakHomeWorkPrivateOneToOneCell : UITableViewCell

// 私人课程照片
@property (nonatomic, strong) UIImageView *privateOneToOneImageView;
// 一对一课程标题
@property (nonatomic, strong) UILabel *privateOneToOneCourseTitle;
// 一对一课程类型
@property (nonatomic, strong) UILabel *privateOneToOneGradeLab;
// 一对一课程时长
@property (nonatomic, strong) UILabel *privateCourseTimeLab;
// 一对一价格
@property (nonatomic, strong) UILabel *privateOneToOnePriceLab;

//- (void)configHomeCellWithHomeModel:(NSArray *)dataArr;

@end
