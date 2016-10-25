//
//  HomeViewController.m
//  KeHai
//
//  Created by 三海 on 16/10/22.
//  Copyright © 2016年 陈高健. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCell.h"
#import "MainMenuCell.h"
#import "AdvertScrollView.h"
#import "ScheduleViewController.h"
#import "SpeakHomeWorkTodayCell.h"
#import "TodayCollectionViewCell.h"
#import "SpeakHomeWorkFireCell.h"
#import "SpeakHomeWorkPrivateOneToOneCell.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>

// 数组
@property (nonatomic, copy) NSMutableArray *dataArr;
// TableView
@property (nonatomic, copy) UITableView *listView;
// CollectionView
@property (nonatomic, copy) UICollectionView *speakHomeWorkCollectionView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, 1, SCREEN_WIDTH, SCREEN_HEIGHT - 49 - 1) style:UITableViewStylePlain];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.separatorColor = [UIColor clearColor];
    [self.view addSubview:_listView];
    
    // Do any additional setup after loading the view.
}

#pragma mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section != 4) {
        return 1;
    }else{
    return 10;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        static NSString *cellIndentifier = @"advertScrollViewCell";
        AdvertScrollView *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[AdvertScrollView alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }
        cell.backgroundColor = [UIColor redColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1) {
        static NSString *cellIndentifier = @"homeCell";
        MainMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[MainMenuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            
            // 创建主菜单
            NSArray *titleArr = @[@"一对一",@"辅导班",@"讲作业",@"课海"];
            NSArray *imageArr = @[@"一对一",@"辅导班",@"讲作业",@"课海"];
            
            UIView *menuView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 90)];
            menuView.backgroundColor = [UIColor whiteColor];
            
            // 循环创建菜单项
            for (int i = 0; i < titleArr.count; i++) {
                UIImageView *menuImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10 + ((SCREEN_WIDTH - 20 - 50 * (titleArr.count))/(titleArr.count - 1) + 50)* i, 10, 50, 50)];
                menuImageView.backgroundColor = [UIColor whiteColor];
                menuImageView.image = [UIImage imageNamed:imageArr[i]];
                [menuView addSubview:menuImageView];
                UILabel *menuLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 + ((SCREEN_WIDTH - 20 - 50 * (titleArr.count)) / (titleArr.count-1) + 50 ) * i, 65, 50, 15)];
                menuLabel.font = [UIFont systemFontOfSize:15];
                menuLabel.text = titleArr[i];
                menuLabel.textAlignment = NSTextAlignmentCenter;
                [menuView addSubview:menuLabel];
                
                // 创建按钮,用来处理点击菜单后的事件
                UIButton *menuBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / titleArr.count * i, 5, SCREEN_WIDTH / titleArr.count, 80)];
                menuBtn.backgroundColor = [UIColor clearColor];
                [menuBtn addTarget:self action:@selector(menuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [menuView addSubview:menuBtn];
            }
            
            
            [cell addSubview:menuView];
        }
        cell.backgroundColor = [UIColor yellowColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 2){
        static NSString *cellIndentifier = @"speakHomeWorkTodayCell";
        SpeakHomeWorkTodayCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[SpeakHomeWorkTodayCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            
            // 讲作业标题
            UIView *speakHomeWorkView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 20, 40)];
            speakHomeWorkView.backgroundColor = [UIColor whiteColor];
            
            // 今日讲作业标签
            UIImageView *speakImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 7, 20)];
            speakImageView.image = [UIImage imageNamed:@"speakHomeWork.png"];
            [speakHomeWorkView addSubview:speakImageView];
            
            // 今日讲作业标题
            UILabel *speakHomeworkTitle = [[UILabel alloc]initWithFrame:CGRectMake(12, 10, 120, 20)];
            speakHomeworkTitle.text = @"今日的讲作业";
            speakHomeworkTitle.textColor = [UIColor colorWithRed:81/255.0 green:81/255.0 blue:81/255.0 alpha:1];
            speakHomeworkTitle.font = [UIFont boldSystemFontOfSize:17];
            speakHomeworkTitle.textAlignment = NSTextAlignmentLeft;
            [speakHomeWorkView addSubview:speakHomeworkTitle];
            
            // 今日讲作业更多
            UILabel *moreLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 10, 70, 20)];
            moreLabel.text = @"更多 >>";
            moreLabel.textAlignment = NSTextAlignmentRight;
            moreLabel.textColor = [UIColor colorWithRed:34/255.0 green:196/255.0 blue:252/255.0 alpha:1];
            moreLabel.font = [UIFont boldSystemFontOfSize:17];
            moreLabel.userInteractionEnabled = YES;
            [speakHomeWorkView addSubview:moreLabel];
            
            [cell addSubview:speakHomeWorkView];
    
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
            // 设置单元格间距
            layout.minimumInteritemSpacing = 10;
            // 设置排列方式
            [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
            // 设置单元格大小
            [layout setItemSize:CGSizeMake(145, 130)];
            
            _speakHomeWorkCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 41 , SCREEN_WIDTH - 20, 134) collectionViewLayout:layout];
            _speakHomeWorkCollectionView.delegate = self;
            _speakHomeWorkCollectionView.dataSource = self;
            _speakHomeWorkCollectionView.backgroundColor = [UIColor whiteColor];
            _speakHomeWorkCollectionView.showsHorizontalScrollIndicator = NO;
            [cell addSubview:_speakHomeWorkCollectionView];
            
            [_speakHomeWorkCollectionView registerClass:[TodayCollectionViewCell class] forCellWithReuseIdentifier:@"speakHomeWorkCollectionViewCell"];
        }
        return cell;
    }else if (indexPath.section == 3) {
        static NSString *cellIndentifier = @"homeCell";
        SpeakHomeWorkFireCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[SpeakHomeWorkFireCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            
            // 最火课程模块
            UIView *fireView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 20, 40)];
            fireView.backgroundColor = [UIColor whiteColor];
            [cell addSubview:fireView];
            
            // 最火课程标签
            UIImageView *fireImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 7, 20)];
            fireImageView.image = [UIImage imageNamed:@"fire.png"];
            [fireView addSubview:fireImageView];
            
            // 最火课程标题
            UILabel *fireCourse = [[UILabel alloc]initWithFrame:CGRectMake(12, 10, 140, 20)];
            fireCourse.text = @"最火课程--讲作业";
            fireCourse.font = [UIFont boldSystemFontOfSize:17];
            fireCourse.textColor = [UIColor colorWithRed:81/255.0 green:81/255.0 blue:81/255.0 alpha:1];
            fireCourse.textAlignment = NSTextAlignmentLeft;
            [fireView addSubview:fireCourse];
            
            // 最火课程副标题
            UILabel *subtitleTitle = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(fireCourse.frame), 10, (SCREEN_WIDTH - 20) / 2, 20)];
            subtitleTitle.font = [UIFont boldSystemFontOfSize:15];
            subtitleTitle.text = @"当周问题当周解决";
            subtitleTitle.textAlignment = NSTextAlignmentLeft;
            subtitleTitle.textColor = [UIColor colorWithRed:169/255.0 green:169/255.0 blue:169/255.0 alpha:1];;
            [fireView addSubview:subtitleTitle];
            
            // 最火课程更多
            UILabel *moreLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 10, 70, 20)];
            moreLabel.text = @"更多 >>";
            moreLabel.textAlignment = NSTextAlignmentRight;
            moreLabel.textColor = [UIColor colorWithRed:34/255.0 green:196/255.0 blue:252/255.0 alpha:1];
            moreLabel.font = [UIFont boldSystemFontOfSize:17];
            moreLabel.userInteractionEnabled = YES;
            [fireView addSubview:moreLabel];
            
            // 最火课程内容
            UIView *courseView = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(fireImageView.frame) + 10, SCREEN_WIDTH - 20 , 320)];
            [cell addSubview:courseView];
            
            // 最火课程
            int colCount = 2;
            int courseCount =  4;  //(int)fireCourseArr.count;
            CGFloat courseW = ((SCREEN_WIDTH - 20) - 10 ) /2;
            CGFloat courseH = 150;
            CGFloat courseMargin = 10;
            courseCount = courseCount > 4 ? 4 :courseCount;
            for (int i = 0; i< courseCount; i ++) {
                
                //                NewHomeCellModel *model = fireCourseArr[i];
                
                // 行号
                int row = i / colCount;
                // 列号
                int col = i % colCount;
                
                // X
                CGFloat courseX = (courseMargin + courseW ) * col;
                // Y
                CGFloat courseY = (courseMargin + courseH ) * row;
                
                // Frame
                UIView *courseHomeWorkView = [[UIView alloc]initWithFrame:CGRectMake(courseX,courseY,courseW,courseH)];
                [courseView addSubview:courseHomeWorkView];
                
                // 添加点击手势
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fireCourseBtnClick:)];
                
                UIImageView *fireCourseImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, courseW, 100)];
                fireCourseImageView.tag = 12343 + i;
                fireCourseImageView.userInteractionEnabled = YES;
                fireCourseImageView.image = [UIImage imageNamed:@"default_image.png"];
                //                // 图片
                //                if (![model.courseResId isEqualToString:@"0"]) {
                //                    [BaseInfo getImage:fireCourseImageView UserImageWithString:model.courseResId andType:kehaiPpresId];
                //                }
                [fireCourseImageView addGestureRecognizer:tap];
                [courseHomeWorkView addSubview:fireCourseImageView];
                
                UIImageView *fireMarkImageView = [[UIImageView alloc]initWithFrame:CGRectMake(courseW - 35, 0, 25, 45)];
                fireMarkImageView.image = [UIImage imageNamed:@"报名中.png"];
                [fireCourseImageView addSubview:fireMarkImageView];
                
                UILabel *fireCourseTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(fireCourseImageView.frame) + 5, courseW, 34)];
                fireCourseTitle.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
                fireCourseTitle.font = [UIFont systemFontOfSize:13];
                fireCourseTitle.text = @"这是最火课程的课程标题,这是最火课程模块,一共有四节课"; //[NSString stringWithFormat:@"%@",model.theme];
                fireCourseTitle.numberOfLines = 2;
                [courseHomeWorkView addSubview:fireCourseTitle];
                
                UILabel *fireGradeLab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(fireCourseTitle.frame) , fireCourseImageView.frame.size.width /2, 20)];
                fireGradeLab.text = @"年级 科目";//[NSString stringWithFormat:@"%@  %@",[[ScreenInfoDic shareScreenInfo] getSubjectWithCode:model.gradeId andType:classType],[BaseInfo changeString:[[ScreenInfoDic shareScreenInfo]getSubjectWithCode:model.subjectId andType:subjectType] forCancelString:@"," withReplaceString:@" "]];
                fireGradeLab.textColor = [UIColor colorWithRed:34/255.0 green:196/255.0 blue:252/255.0 alpha:1];
                fireGradeLab.textAlignment = NSTextAlignmentLeft;
                fireGradeLab.font = [UIFont systemFontOfSize:12];
                [courseHomeWorkView addSubview:fireGradeLab];
                
                UILabel *fireSignNumLab = [[UILabel alloc]initWithFrame:CGRectMake(fireCourseImageView.frame.size.width /2, CGRectGetMaxY(fireCourseTitle.frame) , fireCourseImageView.frame.size.width /2, 20)];
                fireSignNumLab.textAlignment = NSTextAlignmentRight;
                fireSignNumLab.text = @"10人已报名";//[NSString stringWithFormat:@"%@人已报名",model.bmNum];
                fireSignNumLab.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
                fireSignNumLab.font = [UIFont systemFontOfSize:12];
                [courseHomeWorkView addSubview:fireSignNumLab];
            }
        }
        return cell;
    }else{
        static NSString *cellIndentifier = @"SpeakHomeWorkPrivateOneToOneCell";
        SpeakHomeWorkPrivateOneToOneCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[SpeakHomeWorkPrivateOneToOneCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ScheduleViewController *vc = [[ScheduleViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 200;
    }else if (indexPath.section == 1){
        return 90;
    }else if (indexPath.section == 2){
        return 175;
    }else if (indexPath.section == 3){
        return 360;
    }else{
        return 115;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.1;
    }else{
        return 0.1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0 || section == 4) {
        return 0.1;
    }
    return 10;
}


#pragma mark UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TodayCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"speakHomeWorkCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

#pragma mark MenuBtnClick

- (void)menuBtnClick:(UIButton *)sender{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
