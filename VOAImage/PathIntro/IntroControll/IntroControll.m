#import "IntroControll.h"

@implementation IntroControll
@synthesize delegate;
@synthesize topView;

- (id)initWithFrame:(CGRect)frame pages:(NSArray*)pagesArray
{
    self = [super initWithFrame:frame];
    if(self != nil) {
        
        //Initial Background images
        
        self.backgroundColor = [UIColor blackColor];
        
        backgroundImage1 = [[UIImageView alloc] initWithFrame:frame];
        [backgroundImage1 setContentMode:UIViewContentModeScaleAspectFill];
        [backgroundImage1 setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
        [self addSubview:backgroundImage1];

        backgroundImage2 = [[UIImageView alloc] initWithFrame:frame];
        [backgroundImage2 setContentMode:UIViewContentModeScaleAspectFill];
        [backgroundImage2 setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
        [self addSubview:backgroundImage2];
        
        //Initial shadow
        UIImageView *shadowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shadow.png"]];
        shadowImageView.contentMode = UIViewContentModeScaleToFill;
        shadowImageView.frame = CGRectMake(0, frame.size.height-300, frame.size.width, 300);
        [self addSubview:shadowImageView];
        
        //Initial ScrollView
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kSideViewHeight, kScreenWidth, kScreenHeight - 2*kSideViewHeight)];
        scrollView.backgroundColor = [UIColor clearColor];
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        
        //Initial PageView
//        pageControl = [[UIPageControl alloc] init];
//        pageControl.numberOfPages = pagesArray.count;
//        [pageControl sizeToFit];
//        [pageControl setCenter:CGPointMake(frame.size.width/2.0, frame.size.height-50)];
//        [self addSubview:pageControl];
        
        //Create pages
        pages = [NSMutableArray arrayWithArray:pagesArray];
        
        scrollView.contentSize = CGSizeMake(pages.count * frame.size.width, scrollView.frame.size.height);
        
        //新建顶栏和底栏
//        topView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, kSideViewHeight)];
//        topView.backgroundColor = [UIColor whiteColor];
        
        topView = (MyTopView *)[[[NSBundle mainBundle] loadNibNamed:@"MyTopView"
                                                            owner:self
                                                          options:nil] objectAtIndex:0];
        [topView setFrame:CGRectMake(0, 20, kScreenWidth, kSideViewHeight)];
        [self addSubview:topView];
//        bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - kSideViewHeight, kScreenWidth, kSideViewHeight)];
//        bottomView.backgroundColor = [UIColor whiteColor];
        
        bottomView = (MyBottomView *)[[[NSBundle mainBundle] loadNibNamed:@"MyBottomView"
                                                              owner:self
                                                            options:nil] objectAtIndex:0];
        [bottomView setFrame:CGRectMake(0, kScreenHeight - kSideViewHeight, kScreenWidth, kSideViewHeight)];
        [self addSubview:bottomView];
        
        currentPhotoNum = -1;
        arrayIndex = -1;
        isLeftScroll = YES;
        
        introViews = [[NSMutableArray alloc] initWithCapacity:5];
        
        //insert TextViews into ScrollView
        for(int i = 0; i <  pages.count; i++) {
            IntroView *view = [[IntroView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 2*kSideViewHeight) model:[pages objectAtIndex:i]];
            view.frame = CGRectOffset(view.frame, i*frame.size.width, 0);
            [view setTag:i];
            [introViews addObject:view];
            [scrollView addSubview:view];
        }
        
        [self initShow];
        
        //start timer
        timer =  [NSTimer scheduledTimerWithTimeInterval:kAutoScroll
                                                  target:self
                                                selector:@selector(tick)
                                                userInfo:nil
                                                 repeats:YES];
    }
    
    return self;
}

- (void) tick {
    [self judgeDirection];
    [scrollView setContentOffset:CGPointMake((isLeftScroll? currentPhotoNum+1: currentPhotoNum-1)*self.frame.size.width, 0) animated:YES];
}

- (void) judgeDirection {
    if (currentPhotoNum == 0) {
        if (!isLeftScroll) {
            isLeftScroll = YES;
        }
    } else if (currentPhotoNum == 9){
        if (isLeftScroll) {
            isLeftScroll = NO;
        }
    }
}

- (void) initShow {
//    int scrollPhotoNumber = MAX(0, MIN(pages.count-1, (int)(scrollView.contentOffset.x / self.frame.size.width)));
    int scrollPhotoNumber = MAX(0, (int)(scrollView.contentOffset.x / self.frame.size.width));
    
    NSInteger state = 0; //0：不变 1：首加 2：尾加
    
    if(scrollPhotoNumber != currentPhotoNum) {
        
        if (scrollPhotoNumber > currentPhotoNum) {
            if (arrayIndex == 2 && scrollPhotoNumber < 8) {
                state = 2;
                arrayIndex = 2;
            }
            arrayIndex++;
        }
        else {
            if (arrayIndex == 2 && scrollPhotoNumber > 1) {
                state = 1;
                arrayIndex = 2;
            }
            arrayIndex--;
        }
        
//        NSLog(@"scrollPhotoNumber:%d", scrollPhotoNumber);
        
        currentPhotoNum = scrollPhotoNumber;
        
        //backgroundImage1.image = currentPhotoNum != 0 ? [(IntroModel*)[pages objectAtIndex:currentPhotoNum-1] image] : nil;
        backgroundImage1.image = [(IntroModel*)[pages objectAtIndex:arrayIndex] image];
        NSInteger myHeight = backgroundImage1.image.size.height * kScreenWidth / backgroundImage1.image.size.width;
        [backgroundImage1 setFrame:CGRectMake(0, 20 + kSideViewHeight + (scrollView.frame.size.height - myHeight)/2, kScreenWidth, myHeight)];
        [backgroundImage1 setFrame:CGRectMake(0, 20 + kSideViewHeight, kScreenWidth, myHeight)];
        backgroundImage2.image = arrayIndex+1 != [pages count] ? [(IntroModel*)[pages objectAtIndex:arrayIndex+1] image] : nil;
        if (backgroundImage2.image) {
            myHeight = backgroundImage2.image.size.height * kScreenWidth / backgroundImage2.image.size.width;
            [backgroundImage2 setFrame:CGRectMake(0, 20 + kSideViewHeight, kScreenWidth, myHeight)];
        }
    
    }
    
    float offset =  scrollView.contentOffset.x - (currentPhotoNum * self.frame.size.width);
    
    
    //left
    if(offset < 0) {
        pageControl.currentPage = 0;
        
        offset = self.frame.size.width - MIN(-offset, self.frame.size.width);
        backgroundImage2.alpha = 0;
        backgroundImage1.alpha = (offset / self.frame.size.width);
    
    //other
    } else if(offset != 0) {
        //last
        if(scrollPhotoNumber == pages.count-1) {
            pageControl.currentPage = pages.count-1;
            
            backgroundImage1.alpha = 1.0 - (offset / self.frame.size.width);
        } else {
            
            pageControl.currentPage = (offset > self.frame.size.width/2) ? currentPhotoNum+1 : currentPhotoNum;
            
            backgroundImage2.alpha = offset / self.frame.size.width;
            backgroundImage1.alpha = 1.0 - backgroundImage2.alpha;
        }
    //stable
    } else {
        pageControl.currentPage = currentPhotoNum;
        backgroundImage1.alpha = 1;
        backgroundImage2.alpha = 0;
    }
    
    if (state == 2) {
        arrayIndex = 2;
        //移除首部的IntroView
        [(UIView *)[introViews objectAtIndex:0] removeFromSuperview];
        [introViews removeObjectAtIndex:0];
        
        //移除首部的并在尾部添加新的IntroModel
        [pages removeObjectAtIndex:0];

        if ([delegate respondsToSelector:@selector(catchIntro:)]) {
            [pages addObject:[delegate catchIntro:scrollPhotoNumber + 2 + 1]];
        }
        
        //增大scrollView的contentSize
        scrollView.contentSize = CGSizeMake((scrollPhotoNumber + 3) * kScreenWidth, scrollView.contentSize.height);
        
        //在尾部添加新的IntroView
        NSInteger newTag = [(UIView *)[introViews lastObject] tag] + 1;
        IntroView *view = [[IntroView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 2*kSideViewHeight) model:[pages lastObject]];
        view.frame = CGRectOffset(view.frame, newTag * kScreenWidth, 0);
        [view setTag:newTag];
        [introViews addObject:view];
        [scrollView addSubview:view];
//        NSLog(@"newTag:%d", newTag);
    } else if (state == 1) {
        arrayIndex = 2;
        //移除尾部的IntroView
        [(UIView *)[introViews objectAtIndex:4] removeFromSuperview];
        [introViews removeObjectAtIndex:4];
        
        //移除尾部的并在首部添加新的IntroModel
        [pages removeObjectAtIndex:4];
        if ([delegate respondsToSelector:@selector(catchIntro:)]) {
            [pages insertObject:[delegate catchIntro:scrollPhotoNumber - 2 + 1] atIndex:0];
        }
        
        //增大scrollView的contentSize
//        scrollView.contentSize = CGSizeMake(scrollView.contentSize.width + kScreenWidth, scrollView.contentSize.height);
        
        //在首部添加新的IntroView
        NSInteger newTag = [(UIView *)[introViews objectAtIndex:0] tag] - 1;
        IntroView *view = [[IntroView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 2*kSideViewHeight) model:[pages objectAtIndex:0]];
        view.frame = CGRectOffset(view.frame, newTag * kScreenWidth, 0);
        [view setTag:newTag];
        [introViews insertObject:view atIndex:0];
        [scrollView addSubview:view];
//        NSLog(@"newTag:%d", newTag);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scroll {
    [self initShow];
//    NSLog(@"111");
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scroll {
    if(timer != nil) {
        [timer invalidate];
        timer = nil;
    }
    [self initShow];
//    NSLog(@"222");
}



@end
