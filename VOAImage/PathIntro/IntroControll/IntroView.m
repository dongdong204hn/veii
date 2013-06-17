#import "IntroView.h"

@implementation IntroView
//@synthesize titleLabel;
//@synthesize descriptionLabel;

- (id)initWithFrame:(CGRect)frame model:(IntroModel*)model
{
    self = [super initWithFrame:frame];
    if (self) {
        titleLabel = [[UILabel alloc] init];
        [titleLabel setText:model.titleText];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
        [titleLabel setShadowColor:[UIColor blackColor]];
        [titleLabel setShadowOffset:CGSizeMake(1, 1)];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel sizeToFit];
//        [titleLabel setCenter:CGPointMake(frame.size.width/2, frame.size.height*3/5)];
        
        descriptionLabel = [[UILabel alloc] init];
        [descriptionLabel setText:model.descriptionText];
        [descriptionLabel setFont:[UIFont systemFontOfSize:16]];
        [descriptionLabel setTextColor:[UIColor whiteColor]];
        [descriptionLabel setShadowColor:[UIColor blackColor]];
        [descriptionLabel setShadowOffset:CGSizeMake(1, 1)];
        [descriptionLabel setNumberOfLines:0];
        [descriptionLabel setBackgroundColor:[UIColor clearColor]];
        [descriptionLabel setTextAlignment:NSTextAlignmentCenter];
        
        CGSize s = [descriptionLabel.text sizeWithFont:descriptionLabel.font constrainedToSize:CGSizeMake(frame.size.width-40, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
        
//        descriptionLabel.frame = CGRectMake((self.frame.size.width-s.width)/2, titleLabel.frame.origin.y+titleLabel.frame.size.height+4,s.width, s.height);
        
//        //three lines height
        CGSize three = [@"1 \n 2 \n 3" sizeWithFont:descriptionLabel.font constrainedToSize:CGSizeMake(frame.size.width-40, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
//
//        descriptionLabel.frame = CGRectMake((self.frame.size.width-s.width)/2, titleLabel.frame.origin.y+titleLabel.frame.size.height+4,s.width, MIN(s.height, three.height));
        
        descriptionLabel.frame = CGRectMake((self.frame.size.width-s.width)/2, frame.size.height-MIN(s.height, three.height)-20, s.width, MIN(s.height, three.height));
        
//        NSLog(@"%f", s.height);
        [titleLabel setCenter:CGPointMake(50, frame.size.height-MIN(s.height, three.height)-35)];
        [self addSubview:titleLabel];
        
        
        UIButton *enBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [enBtn setTitle:@"ch" forState:UIControlStateNormal];
        [enBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [enBtn setFrame:CGRectMake(0, 0, 20, 30)];
        
        UIButton *chBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [chBtn setTitle:@"ch" forState:UIControlStateNormal];
        [chBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [chBtn setFrame:CGRectMake(0, 0, 20, 20)];
//
        
        
        UIButton *defBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [defBtn setTitle:@"ch" forState:UIControlStateNormal];
        [defBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [defBtn setFrame:CGRectMake(0, 0, 20, 20)];
        
        [enBtn setCenter:CGPointMake(frame.size.width - 120, frame.size.height-MIN(s.height, three.height)-35)];
        [chBtn setCenter:CGPointMake(frame.size.width - 80, frame.size.height-MIN(s.height, three.height)-35)];
        [defBtn setCenter:CGPointMake(frame.size.width - 40, frame.size.height-MIN(s.height, three.height)-35)];
        
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
