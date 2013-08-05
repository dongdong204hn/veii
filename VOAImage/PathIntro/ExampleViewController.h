#import <UIKit/UIKit.h>
#import "IntroControll.h"
//#import "MoreViewController.h"
#import "MoreView.h"
#import "ListView.h"
#import "CommentView.h"
#import "DDXML.h"
#import "DDXMLElementAdditions.h"
#import "ExplainView.h"
#import "VOATitle.h"
#import "VOAFav.h"
#import "CL_AudioRecorder.h"

#define kRecorderDirectory [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]  stringByAppendingPathComponent:@"Recorders"]
#define kBufferSize 8192

#define kRecordFile @"recordAudio.aac"
#define kCutFile @"export.wav"


#define kSpeakImage1         @"speaker_1.png"
#define kSpeakImage2         @"speaker_2.png"
#define kSpeakImage3         @"speaker_3.png"
#define kSpeakImage4         @"speaker_4.png"
#define kSpeakImage5         @"speaker_5.png"
#define kSpeakImage6         @"speaker_6.png"
#define kSpeakImage7         @"speaker_7.png"
#define kSpeakImage8         @"speaker_8.png"

@interface ExampleViewController : UIViewController <IntroControllDelegate, MyTopViewDelegate, UIScrollViewDelegate, ListViewDelegate, MoreViewDelegate, MyBottomViewDelegate, UIActionSheetDelegate, CommentViewDelegate> {
    
    ListView *listView;
    MoreView *moreView;
    CommentView *commentView;
    
    BOOL downMoreView;
    BOOL isSelectList;
    BOOL islocal;
    BOOL              m_isRecording; //标识是否正在录音
    
    IntroControll *myIntroControl;
    
//    NSInteger titleIndex;
//    NSInteger addNum;
    NSInteger titleTotal;
    NSInteger offset;
    NSInteger netVoaid; //记录最后一次联网获取数据时的voaid。
    NSInteger listVoaid; //列表中选中的项所属的voaid
    NSInteger senTimerNum; //记录显示senLabel倒计时
    
//    NSString *creatTime;
    
    UIAlertView *alert;
    
    NSMutableArray *myVoas;
    
    VOAView *listVoa;
    
    AVPlayer *commPlayer;
    
    NSTimer         *recordTimer; //录音定时器
    
    CGFloat             nowRecordSeconds; //实际录音时长的备份
    
    CGFloat recordSeconds;    //记录实际录音时长
    
    CL_AudioRecorder* audioRecoder;
    
    BOOL isNewComm;   //标记当前用户是否有发表新评论，方便滚动评论界面到最新的评论
    
    BOOL isEvaluate;  //标记对评论赞或踩是否成功。
    
    NSTimer *senLabelTimer;   //用户录语音时显示英文句子内容的定时器
    
    NSTimer *timer;
    
    
}

@property (nonatomic, retain) NSOperationQueue *sharedSingleQueue; //下载队列

@end
