//
//  AdvertScrollView.m
//  KeHai
//
//  Created by 三海 on 16/10/24.
//  Copyright © 2016年 陈高健. All rights reserved.
//

#import "advertScrollView.h"
#import "ZQLoopScrollView.h"
#import "AdvertScrollViewModel.h"

@implementation AdvertScrollView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
//    NSMutableArray *images = [NSMutableArray array];
//    ZQLoopScrollView *loop = [ZQLoopScrollView loopScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200) imageUrls:images timeInterval:5.0 didSelect:^(NSInteger atIndex, ZQLoadImageView *sender) {
//    } didScroll:^(NSInteger toIndex, ZQLoadImageView *sender) {
//    }];
//    loop.placeholder = [UIImage imageNamed:@"default_image.png"];
//    [loop setCurrentPageIndicatorTintColor:[UIColor colorWithRed:51.0/255 green:204.0/255 blue:204.0/255 alpha:1]];
//    [loop setPageControlTintColor:[UIColor greenColor]];
//    [self addSubview:loop];
}

- (void)configWithAdvertScrollViewArr:(NSArray *)pictureArr{
    
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 0 ; i< pictureArr.count; i++) {
        AdvertScrollViewModel *model = pictureArr[i];
        NSString *imageUrl = [NSString stringWithFormat:@"http://f.kehai.com/file/loadImage/%@.r",model.picId];
        [images addObject:imageUrl];
    }
    ZQLoopScrollView *loop = [ZQLoopScrollView loopScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200) imageUrls:images timeInterval:5.0 didSelect:^(NSInteger atIndex, ZQLoadImageView *sender) {
    } didScroll:^(NSInteger toIndex, ZQLoadImageView *sender) {
    }];
    loop.placeholder = [UIImage imageNamed:@"default_image.png"];
    [loop setCurrentPageIndicatorTintColor:[UIColor colorWithRed:51.0/255 green:204.0/255 blue:204.0/255 alpha:1]];
    [loop setPageControlTintColor:[UIColor greenColor]];
    [self addSubview:loop];

}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
