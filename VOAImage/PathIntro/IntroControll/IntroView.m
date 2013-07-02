#import "IntroView.h"

@implementation IntroView
//@synthesize titleLabel;
//@synthesize descriptionLabel;

- (id)initWithFrame:(CGRect)frame model:(IntroModel*)model
{
    self = [super initWithFrame:frame];
    if (self) {
        titleLabel = [[UITextView alloc] init];
        [titleLabel setText:model.titleText];
        [titleLabel setTextColor:[UIColor colorWithRed:163/255.0 green:144/255.0 blue:167/255.0 alpha:1.0]];
        [titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
//        [titleLabel setShadowColor:[UIColor blackColor]];
//        [titleLabel setShadowOffset:CGSizeMake(1, 1)];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel sizeToFit];
//        [titleLabel setCenter:CGPointMake(frame.size.width/2, frame.size.height*3/5)];
        [titleLabel setEditable:NO]; 
        
        descriptionLabel = [[UITextView alloc] init];
        [descriptionLabel setText:model.descriptionText];
        [descriptionLabel setFont:[UIFont systemFontOfSize:16]];
        [descriptionLabel setTextColor:[UIColor colorWithRed:222/255.0 green:210/255.0 blue:224/255.0 alpha:1.0]];
//        [descriptionLabel setShadowColor:[UIColor blackColor]];
//        [descriptionLabel setShadowOffset:CGSizeMake(1, 1)];
//        [descriptionLabel setNumberOfLines:0];
        [descriptionLabel setBackgroundColor:[UIColor clearColor]];
        [descriptionLabel setTextAlignment:NSTextAlignmentCenter];
        [descriptionLabel setEditable:NO];
        
      CGSize s = descriptionLabel.text != Nil ?[descriptionLabel.text sizeWithFont:descriptionLabel.font constrainedToSize:CGSizeMake(frame.size.width-25, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping] :CGSizeZero;
        
        CGSize t = titleLabel.text != Nil ?[titleLabel.text sizeWithFont:titleLabel.font constrainedToSize:CGSizeMake(frame.size.width-25, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping] :CGSizeZero;
        
//        descriptionLabel.frame = CGRectMake((self.frame.size.width-s.width)/2, titleLabel.frame.origin.y+titleLabel.frame.size.height+4,s.width, s.height);
        
//        //three lines height
        CGSize four = [@"1 \n 2 \n 3 \n 4" sizeWithFont:descriptionLabel.font constrainedToSize:CGSizeMake(frame.size.width-25, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
        
        CGSize seven = [@"1 \n 2 \n 3 \n 4 \n 5 \n 6 \n 7" sizeWithFont:descriptionLabel.font constrainedToSize:CGSizeMake(frame.size.width-25, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
//
//        descriptionLabel.frame = CGRectMake((self.frame.size.width-s.width)/2, titleLabel.frame.origin.y+titleLabel.frame.size.height+4,s.width, MIN(s.height, three.height));
        
        descriptionLabel.frame = CGRectMake((self.frame.size.width-s.width)/2, frame.size.height-MIN(MAX(four.height, s.height), seven.height)-25, s.width + 25, MIN(MAX(four.height, s.height), seven.height));
        [descriptionLabel setContentOffset:CGPointMake(0, 10)];
        
//        NSLog(@"%f", s.height);
//        [titleLabel setCenter:CGPointMake(50, frame.size.height-MIN(s.height, three.height)-80)];
        titleLabel.frame = CGRectMake(10, frame.size.height-MIN(MAX(four.height, s.height), seven.height)-45, t.width + 25, 20);
        [titleLabel setContentSize:CGSizeMake(t.width + 25, 20)];
        [titleLabel setContentOffset:CGPointMake(0, 10)]; 
        [self addSubview:titleLabel];
        
        
        UIButton *enBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [enBtn setTitle:@"en" forState:UIControlStateNormal];
        [enBtn setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"en@2x" ofType:@"png"]] forState:UIControlStateNormal];
        [enBtn setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"enPres@2x" ofType:@"png"]] forState:UIControlStateHighlighted];
        [enBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [enBtn setFrame:CGRectMake(0, 0, 20, 20)];
        
        UIButton *chBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [chBtn setTitle:@"ch" forState:UIControlStateNormal];
        [chBtn setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ch@2x" ofType:@"png"]] forState:UIControlStateNormal];
        [chBtn setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"chPres@2x" ofType:@"png"]] forState:UIControlStateHighlighted];
        [chBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [chBtn setFrame:CGRectMake(0, 0, 20, 20)];
        
        UIButton *defBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [defBtn setTitle:@"ch" forState:UIControlStateNormal];
        [defBtn setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"desc@2x" ofType:@"png"]] forState:UIControlStateNormal];
        [defBtn setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"descPres@2x" ofType:@"png"]] forState:UIControlStateHighlighted];
        [defBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [defBtn setFrame:CGRectMake(frame.size.width - 40, frame.size.height-MIN(MAX(four.height, s.height), seven.height)-35, 20, 20)];
//        [defBtn setFrame:CGRectMake(0, 0, 20, 30)];
        
        [enBtn setCenter:CGPointMake(frame.size.width - 120, frame.size.height-MIN(MAX(four.height, s.height), seven.height)-35)];
        [chBtn setCenter:CGPointMake(frame.size.width - 80, frame.size.height-MIN(MAX(four.height, s.height), seven.height)-35)];
        [defBtn setCenter:CGPointMake(frame.size.width - 40, frame.size.height-MIN(MAX(four.height, s.height), seven.height)-35)];
        
        
        [self addSubview:descriptionLabel];
        
        [self addSubview:enBtn];
        [self addSubview:chBtn];
        [self addSubview:defBtn];
    }
    return self;
}

- (void)setModel:(IntroModel*)model {
    [titleLabel setText:model.titleText];
    [descriptionLabel setText:model.descriptionText];
}

@end
