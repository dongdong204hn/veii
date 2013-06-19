#import <UIKit/UIKit.h>
#import "IntroControll.h"
//#import "MoreViewController.h"
#import "MoreView.h"
#import "ListView.h"

@interface ExampleViewController : UIViewController <IntroControllDelegate, MyTopViewDelegate, UIScrollViewDelegate, ListViewDelegate, MoreViewDelegate> {
    
    ListView *listView;
    MoreView *moreView;
    BOOL downMoreView;
    IntroControll *myIntroControl;
}

@end
