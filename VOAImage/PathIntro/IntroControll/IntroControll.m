#import "IntroControll.h"
#import "UIImageView+WebCache.h"
//#import <QuartzCore/QuartzCore.h>
//#import <CoreGraphics/CoreGraphics.h>

static const float kVPadding = 5.0f;
static const float kHPadding = 10.0f;
static const float kUpperPartRate = 0.75f;

@implementation IntroControll
@synthesize delegate;
@synthesize topView;
@synthesize bottomView;
@synthesize currentPhotoNum;
@synthesize arrayIndex;
@synthesize pages;
@synthesize scrollView;

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
//    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
//    CGContextFillRect(context, rect);
//    
//    CGPoint points[2];
//    points[0] = CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect) + kUpperPartRate * rect.size.height);
//    points[1] = CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect) + kUpperPartRate * rect.size.height);
//    
//    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
//    CGContextStrokeLineSegments(context, points, 2);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    //    CGFloat colors[] = {
    //        0x2f/255.0f, 0x2f/255.0f, 0x2f/255.0f, 1.0f,
    //        0x12/255.0f, 0x12/255.0f, 0x12/255.0f, 1.0f
    //    };
    
    /*voa的黑红*/
    //    CGFloat colors[] = { //设置分享框下边的颜色
    //        0/255.0f, 0/255.0f, 0.f/255.0f, 1.0f,
    //        198/255.0f, 18/255.0f, 0/255.0f, 1.0f
    //    };
    
    CGFloat colors[] = { 
        100/255.0f, 100/255.0f, 100/255.0f, 1.0f,
        2/255.0f, 2/255.0f, 2/255.0f, 1.0f
    };
    
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colors, NULL, 2);
//    CGContextDrawLinearGradient(context, gradient,
//                                CGPointMake(CGRectGetMidX(rect),
//                                            CGRectGetMinY(rect) + kUpperPartRate * rect.size.height),
//                                CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect)), 0);
    CGContextDrawLinearGradient(context, gradient,
                                CGPointMake(CGRectGetMinX(rect),
                                            CGRectGetMinY(rect)),
                                CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect)), 0);
    CGColorSpaceRelease(colorSpace);
}

- (id)initWithFrame:(CGRect)frame pages:(NSArray*)pagesArray
{
    self = [super initWithFrame:frame];
    if(self != nil) {
        
        //Initial Background images
        
//        self.backgroundColor = [UIColor blackColor];
        
        backgroundImage1 = [[UIImageView alloc] initWithFrame:frame];
//        backgroundImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20 + kSideViewHeight, kScreenWidth, frame.size.height - 108)];
        [backgroundImage1 setContentMode:UIViewContentModeScaleAspectFill];
        [backgroundImage1 setAutoresizingMask: UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
        [self addSubview:backgroundImage1];
        
        backgroundImage2 = [[UIImageView alloc] initWithFrame:frame];
//        backgroundImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20 + kSideViewHeight, kScreenWidth, frame.size.height - 108)];
        [backgroundImage2 setContentMode:UIViewContentModeScaleAspectFill];
        [backgroundImage2 setAutoresizingMask: UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
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
        
        introViews = [[NSMutableArray alloc] initWithCapacity:5];
        isLeftScroll = YES;
        isFlush = NO;
        //Create pages
        pages = [NSMutableArray arrayWithArray:pagesArray];
        
        [self initIntros:frame];
        
        
        
//        //start timer
//        timer =  [NSTimer scheduledTimerWithTimeInterval:kAutoScroll
//                                                  target:self
//                                                selector:@selector(tick)
//                                                userInfo:nil
//                                                 repeats:YES];
    }
    
    return self;
}

- (void) scrollInitIntro:(CGRect)frame {
    [pages removeAllObjects];
    [VOAView findNew:0 newVoas:pages];
    [self initIntros:frame];
}

- (void) initIntros:(CGRect)frame {
    [introViews removeAllObjects];
    for (UIView *view in [scrollView subviews]) {
        [view removeFromSuperview];
    }
    scrollView.contentSize = CGSizeMake(kShowNum * frame.size.width, scrollView.frame.size.height);
    voaNum = [pages count];
    currentPhotoNum = -1;
    arrayIndex = -1;
    voaIndex = -1;
    
    //insert TextViews into ScrollView
    for(int i = 0; i < kShowNum; i++) {
        IntroView *view = [[IntroView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 2*kSideViewHeight) model:[pages objectAtIndex:i]];
        view.frame = CGRectOffset(view.frame, i*frame.size.width, 0);
        [view setTag:i];
        [introViews addObject:view];
        [scrollView addSubview:view];
    }
    
//    for (UIView *view in [scrollView subviews]) {
//        NSLog(@"class:%@", [view class]);
//    }
    
    [self initShow];
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

- (void)scrollViewtoTop {
    [scrollView scrollsToTop];
}

- (void) initShow {
//    int scrollPhotoNumber = MAX(0, MIN(pages.count-1, (int)(scrollView.contentOffset.x / self.frame.size.width)));
    if (scrollView.contentOffset.x < 0) {
        if (scrollView.contentOffset.x < -1*kScreenWidth/6 && !isFlush) {
            isFlush = YES;
            if ([delegate respondsToSelector:@selector(flushIntro)]) {
                [delegate flushIntro];
            }
        }
//<<<<<<< HEAD
    } else {
        int scrollPhotoNumber = MAX(0, (int)(scrollView.contentOffset.x / self.frame.size.width)); //滑到的页数。0-9
        //    NSLog(@"scrollPhotoNumber:%f", scrollView.contentOffset.x);
        //    NSLog(@"scrollPhotoNumber:%d",scrollPhotoNumber);
        NSInteger state = 0; //0：不变 1：首加 2：尾加 3：先扩充数组，首加 4：先扩充数组，尾加
//=======
//        else {
//            if (arrayIndex == 2 && scrollPhotoNumber > 1) {
//                state = 1;
//                arrayIndex = 2;
//            }
//            arrayIndex--;
//        }
//        
////        NSLog(@"scrollPhotoNumber:%d", scrollPhotoNumber);
//        
//        currentPhotoNum = scrollPhotoNumber;
//        
//        //backgroundImage1.image = currentPhotoNum != 0 ? [(IntroModel*)[pages objectAtIndex:currentPhotoNum-1] image] : nil;
//        
//        [backgroundImage1 setImageWithURL: [NSURL URLWithString:[(IntroModel*)[pages objectAtIndex:arrayIndex] imageName]] ];
////        backgroundImage1.image = [(IntroModel*)[pages objectAtIndex:arrayIndex] image];
//        NSInteger myHeight = backgroundImage1.image.size.height * kScreenWidth / backgroundImage1.image.size.width;
//        [backgroundImage1 setFrame:CGRectMake(0, 20 + kSideViewHeight + (scrollView.frame.size.height - myHeight)/2, kScreenWidth, myHeight)];
//        [backgroundImage1 setFrame:CGRectMake(0, 20 + kSideViewHeight, kScreenWidth, myHeight)];
//        [backgroundImage2 setImageWithURL: [NSURL URLWithString:arrayIndex+1 != [pages count] ? [(IntroModel*)[pages objectAtIndex:arrayIndex+1] imageName] : nil] ];
////        backgroundImage2.image = arrayIndex+1 != [pages count] ? [(IntroModel*)[pages objectAtIndex:arrayIndex+1] image] : nil;
//        if (backgroundImage2.image) {
//            myHeight = backgroundImage2.image.size.height * kScreenWidth / backgroundImage2.image.size.width;
//            [backgroundImage2 setFrame:CGRectMake(0, 20 + kSideViewHeight, kScreenWidth, myHeight)];
//        }
//    
//    }
//    
//    float offset =  scrollView.contentOffset.x - (currentPhotoNum * self.frame.size.width);
//    
//    //left
//    if(offset < 0) {
//        pageControl.currentPage = 0;
//>>>>>>> 416dbaff103c1c4eac6d20b8d1b53791ec71a232
        
        if(scrollPhotoNumber != currentPhotoNum) {
            
            if (scrollPhotoNumber > currentPhotoNum) {
                if (arrayIndex == 2) {
                    if ( scrollPhotoNumber < voaNum - 2) { //`````````````
                        state = 2;
                    } else {
                        state = 4;
                    }
                    if (scrollPhotoNumber == voaNum - 7) {
                        state = 6;
                    }
                }
                voaIndex++;
                arrayIndex++;
            }
            else {
                if (arrayIndex == 2) {
                    
                    if (scrollPhotoNumber > 1) {//`````````````
                        state = 1;
                    } else {
                        state = 3;
                        
                    }
                }
                voaIndex--;
                arrayIndex--;
            }
            //        NSLog(@"arrayIndex:%d",arrayIndex);
            
            //        NSLog(@"scrollPhotoNumber:%d", scrollPhotoNumber);
            
            currentPhotoNum = scrollPhotoNumber;
            
            //backgroundImage1.image = currentPhotoNum != 0 ? [(IntroModel*)[pages objectAtIndex:currentPhotoNum-1] image] : nil;
            //        backgroundImage1.image = [(IntroModel*)[pages objectAtIndex:arrayIndex] image];
            //        NSURL *url = [NSURL URLWithString:@"http://static.iyuba.com/images/voa/519.jpg"];
            VOAView *nowVoa = [pages objectAtIndex:arrayIndex];
//            NSURL *url = [NSURL URLWithString: [(VOAView *)[pages objectAtIndex:arrayIndex] pic]];
            NSURL *url = [NSURL URLWithString: [nowVoa pic]];
//            [bottomView.userImg setImageWithURL:[NSURL URLWithString:nowVoa.userImgUrl]];
//            [bottomView.userName setText:nowVoa.userName];

            //        NSLog(@"img:%@", [(VOAView *)[pages objectAtIndex:arrayIndex] pic]);
            [backgroundImage1 setImageWithURL:url placeholderImage:[UIImage imageNamed:@"acquiesce.png"]];
            NSInteger myHeight = backgroundImage1.image.size.height * kScreenWidth / backgroundImage1.image.size.width;
            //        [backgroundImage1 setFrame:CGRectMake(0, 20 + kSideViewHeight + (scrollView.frame.size.height - myHeight)/2, kScreenWidth, myHeight)];
            [backgroundImage1 setFrame:CGRectMake(0, 20 + kSideViewHeight, kScreenWidth, myHeight)];
            NSURL *urlTwo = [NSURL URLWithString: (arrayIndex+1 < 5 ? [(VOAView *)[pages objectAtIndex:arrayIndex+1] pic]: nil)];
            [backgroundImage2 setImageWithURL:urlTwo placeholderImage:[UIImage imageNamed:@"acquiesce.png"]];
            //        backgroundImage2.image = arrayIndex+1 != kShowNum ? [(IntroModel *)[pages objectAtIndex:arrayIndex+1] image] : nil;
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
            if(scrollPhotoNumber == kShowNum-1) {
                pageControl.currentPage = kShowNum-1;
                
                backgroundImage1.alpha = 1.0 - (offset / self.frame.size.width);
            } else {
                
                pageControl.currentPage = (offset > self.frame.size.width/2) ? currentPhotoNum+1 : currentPhotoNum;
                
                backgroundImage2.alpha = offset / self.frame.size.width;
                backgroundImage1.alpha = 1.0 - backgroundImage2.alpha;
            }
            //stable
        } else {
            VOAView *nowVoa = [pages objectAtIndex:arrayIndex];
            if (nowVoa.userid > 0) {
                [bottomView.userImg setImageWithURL:[NSURL URLWithString:nowVoa.userImgUrl] placeholderImage:[UIImage imageNamed:@"userDefault.png"]];
                [bottomView.userName setText:nowVoa.userName];
            } else {
                [bottomView.userImg setImageWithURL:nil];
                [bottomView.userName setText:@""];
            }
            pageControl.currentPage = currentPhotoNum;
            backgroundImage1.alpha = 1;
            backgroundImage2.alpha = 0;
        }
        
        if (state == 2 || state == 4 || state == 6) {
            if (state == 6) {
                if ([delegate respondsToSelector:@selector(netLastVoa)]) {
                    [delegate netLastVoa];
                }
            }
            if (state == 4) {
                int addNum = 0;
                if ([delegate respondsToSelector:@selector(catchLastVoa)]) {
                    addNum = [delegate catchLastVoa];
                }
                if (addNum == 0) {
                    return;
                } else {
                    voaNum += addNum;
                }
            }
            
            arrayIndex = 2;
            //移除首部的IntroView
            [(UIView *)[introViews objectAtIndex:0] removeFromSuperview];
            [introViews removeObjectAtIndex:0];
            
            //移除首部的并在尾部添加新的IntroModel
            [pages removeObjectAtIndex:0];
            
            if ([delegate respondsToSelector:@selector(catchVoa:)]) {
                [pages insertObject:[delegate catchVoa:scrollPhotoNumber + 2] atIndex:4];
                //            [pages addObject:[delegate catchVoa:scrollPhotoNumber + 2]];
            }
            
            //增大scrollView的contentSize
            scrollView.contentSize = CGSizeMake((scrollPhotoNumber + 3) * kScreenWidth, scrollView.contentSize.height);//`````````````
            
            //在尾部添加新的IntroView
            NSInteger newTag = [(UIView *)[introViews lastObject] tag] + 1;
            IntroView *view = [[IntroView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 2*kSideViewHeight) model:[pages objectAtIndex:4]];
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
            if ([delegate respondsToSelector:@selector(catchVoa:)]) {
                [pages insertObject:[delegate catchVoa:scrollPhotoNumber - 2] atIndex:0];
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
}

- (void)scrollViewToImgIndex:(NSInteger) index {
    [scrollView setContentOffset:CGPointMake((index - 1)*self.frame.size.width, 0) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scroll {
    [self initShow];
//    NSLog(@"111");
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scroll {
//    if(timer != nil) {
//        [timer invalidate];
//        timer = nil;
//    }
    
    isFlush = NO;
    
    [self initShow];
//    NSLog(@"222");
    
}



@end
