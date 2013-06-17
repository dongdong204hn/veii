#import <UIKit/UIKit.h>
#import "IntroControll.h"
#import "MoreViewController.h"
#import "MoreView.h"

@interface ExampleViewController : UIViewController <IntroControllDelegate, MyTopViewDelegate> {
    
    MoreView *moreView;
}
@end
