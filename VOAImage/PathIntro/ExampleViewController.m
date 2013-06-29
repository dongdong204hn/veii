#import "ExampleViewController.h"
#import "IASKAppSettingsViewController.h"

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
    
    IntroModel *model3 = [[IntroModel alloc] initWithTitle:@"Example 3" description:@"The Tempest is the first play in the First Folio edition (see the signature) even though it is a later play (namely 1610) than Hamlet (1600), for example. The first page is reproduced here." image:@"20130501_3.jpg"];
    
    IntroModel *model4 = [[IntroModel alloc] initWithTitle:@"Example 4" description:@"4444444444." image:@"20130501_4.jpg"];
    
    IntroModel *model5 = [[IntroModel alloc] initWithTitle:@"Example 5" description:@"5555555555" image:@"20130501_5.jpg"];
    
    myIntroControl = [[IntroControll alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) pages:@[model1, model2, model3, model4, model5]];
    myIntroControl.topView.myDelegate = self;
    myIntroControl.bottomView.myDelegate = self;
    [myIntroControl setDelegate:self];
    self.view = myIntroControl;
    
//    self.view = [[IntroControll alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) pages:@[model1, model2, model3, model4, model5]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    downMoreView = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IntroModel *)catchIntro:(NSInteger)index {
//    NSLog(@"111");
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
//    KLViewController *myKlview = [KLViewController alloc];
//    [self presentModalViewController:myKlview animated:YES];

    listView = (ListView *)[[[NSBundle mainBundle] loadNibNamed:@"ListView"
                                                          owner:self
                                                        options:nil] objectAtIndex:0];
    [listView setFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 0)];
    //    [moreView setFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height)];
    [listView.backBtn addTarget:self action:@selector(backBtnPressed:) forControlEvents:UIControlEventTouchDown];
    [listView setDelegate:self];
    [listView setMyDelegate:self];
    [self.view addSubview:listView];

    [Constants beginAnimationWithName:@"SwitchTwo" duration:0.5f];
    [listView setFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height)];
    [UIView commitAnimations];
}

- (void)didMoreBtnPressed:(MyTopView *)myTopView {
    NSLog(@"more");
//    MoreViewController *myKlview = [[MoreViewController alloc] initWithNibName:@"MoreViewController" bundle:nil];
//    [self presentModalViewController:myKlview animated:YES];
    
    moreView = (MoreView *)[[[NSBundle mainBundle] loadNibNamed:@"MoreView"
                                                          owner:self
                                                        options:nil] objectAtIndex:0];
    [moreView setFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 0)];
//    [moreView setFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height)];
    [moreView.backBtn addTarget:self action:@selector(backBtnPressed:) forControlEvents:UIControlEventTouchDown];
    [moreView setDelegate:self];
    [moreView setMyDelegate:self];
    [self.view addSubview:moreView];
    
    [Constants beginAnimationWithName:@"SwitchTwo" duration:0.5f];
    [moreView setFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height)];
    [UIView commitAnimations];
}

- (void)didCommBtnPressed:(MyBottomView *)myBottomView {
    commentView = (CommentView *)[[[NSBundle mainBundle] loadNibNamed:@"CommentView"
                                                          owner:self
                                                        options:nil] objectAtIndex:0];
    [commentView setFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 0)];
    //    [moreView setFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height)];
    [commentView.backBtn addTarget:self action:@selector(backBtnPressed:) forControlEvents:UIControlEventTouchDown];
    [commentView setDelegate:self];
//    [commentView setMyDelegate:self];
    [self.view addSubview:commentView];
    
    [Constants beginAnimationWithName:@"SwitchTwo" duration:0.5f];
    [commentView setFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height)];
    [UIView commitAnimations];
}

- (void)backBtnPressed:(UIButton *) sender {
    [Constants beginAnimationWithName:@"SwitchOne" duration:1.0f];
    [sender.superview.superview setFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 0)];
    [UIView commitAnimations];
}

#pragma mark - ListViewDelegate
/**
 *
 */
- (void)didImgPressed:(NSInteger)newsIndex {
    NSLog(@"newsIndex:%d", newsIndex);
    [myIntroControl scrollViewToImgIndex:newsIndex];
    [Constants beginAnimationWithName:@"SwitchOne" duration:1.0f];
    [listView setFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 0)];
    [UIView commitAnimations];
}

#pragma mark - MoreViewDelegate
/**
 *
 */
- (void)didSettingBtnPressed {
    IASKAppSettingsViewController *mySetting = [IASKAppSettingsViewController alloc];
    [self presentModalViewController:mySetting animated:YES];
}

#pragma mark - UIScrollViewDelegate
/**
 *  滑动UIScrollView时响应
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
//    scrollView set
    NSLog(@"offsety:%f", scrollView.contentOffset.y);
    if (scrollView.contentOffset.y < -[[UIScreen mainScreen] bounds].size.height * 0.2f) {
        downMoreView = YES;
//        [Constants beginAnimationWithName:@"SwitchOne" duration:1.0f];
        [UIScrollView beginAnimations:@"SwitchOne" context:nil];
        [UIScrollView setAnimationDuration:1.0f];
        [UIScrollView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [scrollView setFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 0)];
        [UIScrollView commitAnimations];
        downMoreView = NO;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (downMoreView) {
//        [self backBtnPressed];
//        [Constants beginAnimationWithName:@"SwitchOne" duration:1.0f];
//        [scrollView setFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 0)];
//        [UIView commitAnimations];
//        downMoreView = NO;
    }
}

@end
