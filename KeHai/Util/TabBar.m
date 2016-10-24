//
//  TabBar.m
//  KeHai
//
//  Created by 三海 on 16/10/24.
//  Copyright © 2016年 陈高健. All rights reserved.
//

#import "TabBar.h"
#import "UIView+Frame.h"
#import "MyToos.h"

@interface TabBar ()

@property (strong, nonatomic) UIButton *composeButton;
@property (strong, nonatomic) UILabel *composeButtonLabel;
@property (strong, nonatomic) UIView *composeButtonView;
@property (strong, nonatomic) UIView *composeButtonCoverView;

@end

@implementation TabBar

- (UIButton *)composeButton {
    if (!_composeButton) {
        _composeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [_composeButton addTarget:self action:@selector(composeButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_composeButton setImage:[UIImage imageNamed:@"tab_new_camera"] forState:UIControlStateNormal];
    }
    return _composeButton;
}

- (UIView *)composeButtonView {
    if (!_composeButtonView) {
        _composeButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        _composeButtonView.backgroundColor = [UIColor whiteColor];
        _composeButtonView.layer.borderColor = [MyToos colorWithHexString:@"e6e6e6"].CGColor;
        _composeButtonView.layer.borderWidth = 1;
        _composeButtonView.layer.cornerRadius = 25;
        _composeButtonView.layer.masksToBounds = YES;
    }
    return _composeButtonView;
}

- (UIView *)composeButtonCoverView {
    if (!_composeButtonCoverView) {
        _composeButtonCoverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
        _composeButtonCoverView.backgroundColor = [UIColor whiteColor];
    }
    return _composeButtonCoverView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.composeButton.centerY = self.bounds.size.height * 0.2;
    self.composeButton.centerX = self.bounds.size.width * 0.5;
    
    self.composeButtonCoverView.centerX = self.bounds.size.width * 0.5;
    
    self.composeButtonView.centerY = self.bounds.size.height * 0.2;
    self.composeButtonView.centerX = self.bounds.size.width * 0.5;
    
    float childW = self.bounds.size.width * 0.2;
    int index = 0;
    for (UIView *value in self.subviews) {
        if ([value isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            value.width = childW;
            value.x = index * childW;
            
            index ++;
            if (index == 2) {
                //                index ++;
            }
        }
    }
}


- (void)setupUI {
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, -1, SCREEN_WIDTH, 1)];
    line.backgroundColor = [MyToos colorWithHexString:@"e6e6e6"];
    [self addSubview:line];
    
    [self addSubview:self.composeButtonView];
    [self addSubview:self.composeButtonCoverView];
    [self addSubview:self.composeButton];
    
    [self setBackgroundImage:[UIImage imageNamed:@"tabbar_background"]];
    [self setShadowImage:[[UIImage alloc] init]];
}


- (void)composeButtonClick {
    if (self.buttonClickBlock) {
        self.buttonClickBlock();
    }
}
@end
