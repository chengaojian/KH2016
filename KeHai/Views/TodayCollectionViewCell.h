//
//  TodayCollectionViewCell.h
//  KeHai
//
//  Created by 三海 on 16/10/25.
//  Copyright © 2016年 陈高健. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodayCollectionViewCell : UICollectionViewCell

// 今日讲作业图片
@property (nonatomic, strong) UIImageView *imageView;

// 今日讲作业按钮
@property (nonatomic, strong) UIImageView *homeImageMark;

// 今日讲作业按钮时间
@property (nonatomic, strong) UILabel *homeImageStartTime;

// 今日将作业标题
@property (nonatomic, strong) UILabel *titleLab;

// 今日将作业年级
@property (nonatomic, strong) UILabel *gradeLab;

// 今日将作业报名人数
@property (nonatomic, strong) UILabel *signNumLab;

@end
