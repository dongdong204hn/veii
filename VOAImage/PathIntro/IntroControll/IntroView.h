#import <UIKit/UIKit.h>
//#import "IntroModel.h"
#import "VOAView.h"
//#import "MyTextView.h"
#import "LocalWord.h"
#import "VOAWord.h"
#import "DDXML.h"
#import "DDXMLElementAdditions.h"
#import <AVFoundation/AVFoundation.h>
#import "NSString+URLEncoding.h"
//#import "TouchView.h"
#import "ExplainView.h"

@interface IntroView : UIView<ASIHTTPRequestDelegate> {
    UITextView *titleLabel;
    UITextView *descriptionLabel;
    
    VOAView *nowModel;
    UIButton *chBtn;
    UIButton *enBtn;
    UIButton *defBtn;
    
    ExplainView *explainView;
//    UILabel     *myHighLightWord;
//    NSSet *wordTouches;
    VOAWord *myWord;
    BOOL isiPhone;
    AVPlayer	*wordPlayer;
    NSString	*selectWord;    //选择的字符串
//    UITextView        *nowTextView;
}

//@property (nonatomic, retain) AVPlayer	*wordPlayer;
//@property (nonatomic, strong) UITextView  *nowTextView;

- (id)initWithFrame:(CGRect)frame model:(VOAView*)model;
//- (void)setModel:(VOAView*)model;

@end
