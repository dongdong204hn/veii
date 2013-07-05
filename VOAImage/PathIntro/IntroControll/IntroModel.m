#import "IntroModel.h"


@implementation IntroModel

@synthesize titleText;
@synthesize descriptionText;
@synthesize imageName;
//@synthesize image;

- (id) initWithTitle:(NSString*)title description:(NSString*)desc image:(NSString*)imageText {
    self = [super init];
    if(self != nil) {
        titleText = title;
        descriptionText = desc;
        imageName = imageText;
//        image = [UIImage imageNamed:imageText];
//        [image setImageWithURL:imageText placeholderImage:[UIImage imageNamed:@"listBg.png"]];
    }
    return self;
}

@end
