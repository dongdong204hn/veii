#import "ExampleViewController.h"

@implementation ExampleViewController

- (id)init
{
    self = [super initWithNibName:nil bundle:nil];
    self.wantsFullScreenLayout = YES;
    self.modalPresentationStyle = UIModalPresentationFullScreen;
    return self;
}

- (void) loadView {
    [super loadView];
    
//    IntroModel *model1 = [[IntroModel alloc] initWithTitle:@"Example 1" description:@"Hi, my name is Dmitry" image:@"image1.jpg"];
//    
//    IntroModel *model2 = [[IntroModel alloc] initWithTitle:@"Example 2" description:@"Several sample texts in Old, Middle, Early Modern, and Modern English are provided here for practice, reference, and reading." image:@"image2.jpg"];
//    
//    IntroModel *model3 = [[IntroModel alloc] initWithTitle:@"Example 3" description:@"The Tempest is the first play in the First Folio edition (see the signature) even though it is a later play (namely 1610) than Hamlet (1600), for example. The first page is reproduced here" image:@"image3.jpg"];
    
    IntroModel *model1 = [[IntroModel alloc] initWithTitle:@"Example 1" description:@"Hi, my name is Dmitry" image:@"20130501_1.jpg"];
    
    IntroModel *model2 = [[IntroModel alloc] initWithTitle:@"Example 2" description:@"Several sample texts in Old, Middle, Early Modern, and Modern English are provided here for practice, reference, and reading." image:@"20130501_2.jpg"];
    
    IntroModel *model3 = [[IntroModel alloc] initWithTitle:@"Example 3" description:@"The Tempest is the first play in the First Folio edition (see the signature) even though it is a later play (namely 1610) than Hamlet (1600), for example. The first page is reproduced here" image:@"20130501_3.jpg"];
    
    IntroModel *model4 = [[IntroModel alloc] initWithTitle:@"Example 4" description:@"4444444444." image:@"20130501_4.jpg"];
    
    IntroModel *model5 = [[IntroModel alloc] initWithTitle:@"Example 5" description:@"5555555555" image:@"20130501_5.jpg"];
    
    IntroControll *test = [[IntroControll alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) pages:@[model1, model2, model3, model4, model5]];
    test.topView.myDelegate = self;
    [test setDelegate:self];
    self.view = test;
    
//    self.view = [[IntroControll alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) pages:@[model1, model2, model3, model4, model5]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IntroModel *)catchIntro:(NSInteger)index {
    NSLog(@"111");
    IntroModel *model = [[IntroModel alloc] initWithTitle:[NSString stringWithFormat:@"Example %d", index] description:[NSString stringWithFormat:@"%d%d", index, index] image:[NSString stringWithFormat:@"20130501_%d.jpg", index]];
    return model;
}

//- (IntroModel *)catchFirstIntro:(NSInteger)index {
//    IntroModel *model = [[IntroModel alloc] initWithTitle:[NSString stringWithFormat:@"Example %d", index] description:[NSString stringWithFormat:@"%d%d", index, index] image:[NSString stringWithFormat:@"20130501_%d.jpg", index]];
//    return model;
//}

#pragma mark - MyTopViewDelegate
- (void)didListBtnPressed:(MyTopView *)myTopView {
    NSLog(@"list");
    KLViewController *myKlview = [KLViewController alloc];
    [self presentModalViewController:myKlview animated:YES];
}

- (void)didMoreBtnPressed:(MyTopView *)myTopView {
    NSLog(@"more");
//    MoreViewController *myKlview = [[MoreViewController alloc] initWithNibName:@"MoreViewController" bundle:nil];
//    [self presentModalViewController:myKlview animated:YES];
    
    moreView = (MoreView *)[[[NSBundle mainBundle] loadNibNamed:@"MoreView"
                                                          owner:self
                                                        options:nil] objectAtIndex:0];
//    [moreView setFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 0)];
    [moreView setFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:moreView];
    
//    [Constants beginAnimationWithName:@"SwitchTwo" duration:0.5f];
//    [moreView setFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height)];
//    [UIView commitAnimations];
}

@end
