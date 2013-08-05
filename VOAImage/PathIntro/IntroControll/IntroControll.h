//
//  IntroControll.m
//  VOAImage


#import <UIKit/UIKit.h>
#import "IntroView.h"
#import "MyTopView.h"
#import "MyBottomView.h"
#import "UIImageView+WebCache.h"

#define kScreenWidth self.frame.size.width
#define kScreenHeight self.frame.size.height
#define kSideViewHeight 44.f
#define kAutoScroll 5.0
#define kShowNum 5

@protocol IntroControllDelegate <NSObject>
@required
//- (IntroModel *)catchIntro: (NSInteger) index;
- (VOAView *)catchVoa: (NSInteger)index;
- (NSInteger)catchLastVoa;
- (void)netLastVoa;
- (void)flushIntro;
//- (IntroModel *)catchFirstIntro: (NSInteger) index;
@end

/**
 *  主界面主展示视图
 */
@interface IntroControll : UIView<UIScrollViewDelegate> {
    id <IntroControllDelegate> delegate;
    
    UIImageView *backgroundImage1;
    UIImageView *backgroundImage2;
    
    UIScrollView *scrollView;
    UIPageControl *pageControl;
    NSMutableArray *pages;
    
//    NSTimer *timer;
    
    int currentPhotoNum; //当前所在的页面。
    int arrayIndex; //在VOA内容数组中的位置游标。
    int voaIndex; //在界面显示的容量大小为5的数组中位置游标。
    int voaNum;
    
    NSMutableArray *introViews;
    
    BOOL isLeftScroll;
    BOOL isFlush;
    
    MyTopView *topView;
    MyBottomView *bottomView;
}

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) id <IntroControllDelegate> delegate;
@property (nonatomic, strong) MyTopView *topView;
@property (nonatomic, strong) MyBottomView *bottomView;
@property (nonatomic, strong) NSMutableArray *pages;
@property (nonatomic, assign) int currentPhotoNum;
@property (nonatomic, assign) int arrayIndex;

- (id)initWithFrame:(CGRect)frame pages:(NSArray*)pages;
- (void)scrollViewToImgIndex:(NSInteger) index;
- (void)scrollViewtoTop;
- (void)scrollInitIntro:(CGRect)frame;
- (void)tick;

@end
