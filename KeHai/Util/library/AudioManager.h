//
//  AudioManager.h
//  Additions
//
//  Created by Johnil on 13-5-30.
//  Copyright (c) 2013年 Johnil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#define AudioPlayNotification @"audioPaly"
#define AudioPauseNotification @"audioPause"
#define AudioNextNotification @"audioNext"
#define AudioPreNotification @"audioPre"
#define AudioProgressNotification @"audioProgress"


@interface AudioManager : NSObject

// 返回AudioManager的对象
+ (AudioManager *)defaultManager;

// 添加音乐到播放列表
- (void)addAudioToList:(NSString *)url;

// 添加音乐URL数组到播放列表
- (void)addAudioListToList:(NSArray *)arr;

// 插入音乐到播放列表第一首
- (void)insertAudioToList:(NSString *)name;

// 插入音乐URL数组到播放列表表首
- (void)insertAudioListToList:(NSArray *)arr;

// 清除播放列表
- (void)clearAudioList;

// 当前播放列表是否为空
- (BOOL)needURL;

// 修改当前音乐状态,如果为播放则暂停,否则继续播放.
- (BOOL)changeStat;

// 当前音乐播放状态
- (MPMoviePlaybackState)stat;

// 在线播放URL
- (void)playWithURL:(NSString *)url;

// 继续播放音乐
- (void)resume;

// 暂停音乐
- (void)pause;

// 播放下一首音乐,如果没有下一首则会从第一首开始播放
- (void)next;

// 播放上一首音乐,如果没有上一首则会从最后一首开始播放
- (void)pre;

// 将当前播放的音乐跳到x%的位置,对应slider拖动时间条
- (void)skipTo:(float)percentage;

// 当前音乐的时间总长
- (float)duration;

// 当前音乐播放时间
- (float)currentPlaybackTime;

// 音乐播放列表是否有下一首
- (BOOL)hasNext;

// 音乐播放列表是否有上一首
- (BOOL)hasPre;

// 从列表第一首开始播放音乐
- (void)playListAtFirst;

// 当前播放的音乐是播放列表的第几首
- (int)currentIndex;

// 播放当前播放列表的第index首
- (void)playIndex:(int)index;

// 是否在播放
- (BOOL)playing;

// 当前播放进度
- (float)progress;

// 设置锁屏时音乐封面
- (void)setMediaInfo:(UIImage *)img andTitle:(NSString *)title andArtist:(NSString *)artist;


@end
