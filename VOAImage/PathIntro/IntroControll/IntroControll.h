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

@protocol IntroControllDelegate <NSObject>
@required
- (IntroModel *)catchIntro: (NSInteger) index;
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
    
    NSTimer *timer;
    
    int currentPhotoNum;
    int arrayIndex;
    
    NSMutableArray *introViews;
    
    BOOL isLeftScroll;
    
    MyTopView *topView;
    MyBottomView *bottomView;
}

@property (nonatomic, strong) id <IntroControllDelegate> delegate;
@property (nonatomic, strong) MyTopView *topView;
@property (nonatomic, strong) MyBottomView *bottomView;

- (id)initWithFrame:(CGRect)frame pages:(NSArray*)pages;
- (void)scrollViewToImgIndex:(NSInteger) index;

@end
