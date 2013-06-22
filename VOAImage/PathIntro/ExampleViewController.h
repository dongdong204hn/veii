#import <UIKit/UIKit.h>
#import "IntroControll.h"
//#import "MoreViewController.h"
#import "MoreView.h"
#import "ListView.h"
#import "CommentView.h"

@interface ExampleViewController : UIViewController <IntroControllDelegate, MyTopViewDelegate, UIScrollViewDelegate, ListViewDelegate, MoreViewDelegate, MyBottomViewDelegate> {
    
    ListView *listView;
    MoreView *moreView;
    CommentView *commentView;
    
    BOOL downMoreView;
    IntroControll *myIntroControl;
}

@end
