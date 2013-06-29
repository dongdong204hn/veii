#import <UIKit/UIKit.h>
#import "IntroModel.h"

@interface IntroView : UIView {
    UITextView *titleLabel;
    UITextView *descriptionLabel;
}

//@property (nonatomic, retain) UILabel *titleLabel;
//@property (nonatomic, retain) UILabel *descriptionLabel;

- (id)initWithFrame:(CGRect)frame model:(IntroModel*)model;
- (void)setModel:(IntroModel*)model;

@end
