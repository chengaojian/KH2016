//
//  SpeakHomeWorkPrivateOneToOneCell.m
//  KeHai
//
//  Created by 三海 on 16/10/25.
//  Copyright © 2016年 陈高健. All rights reserved.
//

#import "SpeakHomeWorkPrivateOneToOneCell.h"

@implementation SpeakHomeWorkPrivateOneToOneCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    // 一对一图
    _privateOneToOneImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0 + 12, 150, 90)];
    _privateOneToOneImageView.image = [UIImage imageNamed:@"default_image.png"];
    [self.contentView addSubview:_privateOneToOneImageView];
    
    // 一对一标题
    _privateOneToOneCourseTitle = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_privateOneToOneImageView.frame) + 10, 0+12, SCREEN_WIDTH - _privateOneToOneImageView.frame.size.width - 20 - 10, 50)];
    _privateOneToOneCourseTitle.font = [UIFont systemFontOfSize:13];
    _privateOneToOneCourseTitle.numberOfLines = 3;
    _privateOneToOneCourseTitle.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    _privateOneToOneCourseTitle.text = [NSString stringWithFormat:@"这是第1个标题,标题内容是这是今日将作业第几张图,看一下需要多个数字才能把页面给撑起来,哒啦哒啦"];
    [self.contentView addSubview:_privateOneToOneCourseTitle];
    
    // 一对一课程类型
    _privateOneToOneGradeLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_privateOneToOneImageView.frame) + 10, CGRectGetMaxY(_privateOneToOneCourseTitle.frame)+5 , _privateOneToOneCourseTitle.frame.size.width /3, 22)];
    _privateOneToOneGradeLab.text = @"高二  数学";
    _privateOneToOneGradeLab.textColor = [UIColor colorWithRed:34/255.0 green:196/255.0 blue:252/255.0 alpha:1];
    _privateOneToOneGradeLab.textAlignment = NSTextAlignmentLeft;
    _privateOneToOneGradeLab.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_privateOneToOneGradeLab];
    
    // 一对一课时
    _privateCourseTimeLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_privateOneToOneImageView.frame) + 10,  CGRectGetMaxY(_privateOneToOneImageView.frame)-17 , 55, 22)];
    _privateCourseTimeLab.text = @"共20课时";
    _privateCourseTimeLab.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    _privateCourseTimeLab.font = [UIFont systemFontOfSize:12];
    _privateCourseTimeLab.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_privateCourseTimeLab];
    
    // 一对一价格
    _privateOneToOnePriceLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_privateCourseTimeLab.frame)+5, CGRectGetMaxY(_privateOneToOneImageView.frame)-17 , SCREEN_WIDTH - CGRectGetMaxX(_privateCourseTimeLab.frame)- 15, 22)];
    _privateOneToOnePriceLab.textAlignment = NSTextAlignmentRight;
    _privateOneToOnePriceLab.text = @"¥ 2000";
    _privateOneToOnePriceLab.textColor = [UIColor colorWithRed:253/255.0 green:127/255.0 blue:35/255.0 alpha:1];
    _privateOneToOnePriceLab.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_privateOneToOnePriceLab];
    
    // 一对一分割线
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10, 115 - 0.5, SCREEN_WIDTH - 10, 0.5)];
    lineView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self.contentView addSubview:lineView];
    
}

//- (void)configHomeCellWithHomeModel:(NewHomeCellModel *)model{
//    
//    // 图片
//    [SHImageTools setImage:_privateOneToOneImageView withKehaiPpresIdString:model.advertiseResId type:courseImage];
//    // 标题
//    _privateOneToOneCourseTitle.text = model.courseTitle;
//    [_privateOneToOneCourseTitle sizeToFit];
//    _privateOneToOneCourseTitle.width = SCREEN_WIDTH - _privateOneToOneImageView.frame.size.width - 30 - 10;
//    // 类型
//    _privateOneToOneGradeLab.text = model.subject;
//    // 一对一课时
//    _privateCourseTimeLab.text = [NSString stringWithFormat:@"共%@课时",model.duration] ;
//    // 一对一价格
//    _privateOneToOnePriceLab.text = [NSString stringWithFormat:@"¥ %0.2f", [model.price doubleValue] / 100];
//    
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
