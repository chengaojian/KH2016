//
//  HomeCell.m
//  KeHai
//
//  Created by 三海 on 16/10/24.
//  Copyright © 2016年 陈高健. All rights reserved.
//

#import "HomeCell.h"
#import "ZQLoopScrollView.h"

@implementation HomeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    
    NSMutableArray *images = [NSMutableArray array];
    [images addObject:@"http://192.168.1.214:9702/file/loadImage/541311286.r"];
    [images addObject:@"http://192.168.1.214:9702/file/loadImage/541311287.r"];
    [images addObject:@"http://192.168.1.214:9702/file/loadImage/541311288.r"];
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
