//
//  TodayCollectionViewCell.m
//  KeHai
//
//  Created by 三海 on 16/10/25.
//  Copyright © 2016年 陈高健. All rights reserved.
//

#import "TodayCollectionViewCell.h"

@implementation TodayCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    // 今日讲作业图片
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 145, 75)];
    _imageView.image = [UIImage imageNamed:@"default_image.png"];
    _imageView.userInteractionEnabled = YES;
    [self.contentView addSubview:_imageView];
    
    // 今日讲作业按钮
    _homeImageMark = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    _homeImageMark.center = _imageView.center;
    _homeImageMark.image = [UIImage imageNamed:@"live.png"];
    _homeImageMark.userInteractionEnabled = YES;
    [_imageView addSubview:_homeImageMark];
    
    // 今日讲作业时间
    _homeImageStartTime = [[UILabel alloc]initWithFrame:CGRectMake(7, 5, 36, 40)];
    _homeImageStartTime.font = [UIFont boldSystemFontOfSize:12];
    _homeImageStartTime.textAlignment = NSTextAlignmentCenter;
    _homeImageStartTime.numberOfLines = 2;
    _homeImageStartTime.textColor = [UIColor whiteColor];
    [_homeImageMark addSubview:_homeImageStartTime];
    
    // 今日将作业标题
    _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_imageView.frame) + 5, 145, 34)];
    _titleLab.text = [NSString stringWithFormat:@"这是第%d个标题,标题内容是这是今日将作业第几张图",1];
    _titleLab.font = [UIFont systemFontOfSize:13];
    _titleLab.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    _titleLab.numberOfLines = 2;
    [self.contentView addSubview:_titleLab];
    
    // 今日将作业年级
    _gradeLab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleLab.frame), _imageView.frame.size.width / 2, 20)];
    _gradeLab.textAlignment = NSTextAlignmentLeft;
    _gradeLab.text = @"四年级  英语";
    _gradeLab.textColor = [UIColor colorWithRed:34/255.0 green:196/255.0 blue:252/255.0 alpha:1];
    _gradeLab.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_gradeLab];
    
    // 今日将作业报名人数
    _signNumLab = [[UILabel alloc]initWithFrame:CGRectMake(0 + (_imageView.frame.size.width / 2), CGRectGetMaxY(_titleLab.frame), _imageView.frame.size.width / 2, 20)];
    _signNumLab.text = @"200人已报名";
    _signNumLab.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    _signNumLab.textAlignment = NSTextAlignmentRight;
    _signNumLab.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_signNumLab];
    
}

@end
