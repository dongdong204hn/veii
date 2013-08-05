//
//  MoreView.m
//  VOAImage
//
//  Created by zhao song on 13-6-17.
//  Copyright (c) 2013年 Dmitry Kondratyev. All rights reserved.
//

#import "MoreView.h"
#import "MoreAppCell.h"

@implementation MoreView
@synthesize backBtn;
@synthesize myDelegate;
@synthesize appTable;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    appArray = [[NSArray alloc] init];
    NSString *bundlePath = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"AppSettings.bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    NSString *plistPath = [bundle pathForResource:@"Root" ofType:@"plist"];
    //    NSArray *array = [[NSArray alloc] initWithContentsOfFile:plistPath];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    appArray = [dictionary valueForKey:@"Apps"];
    NSString *plistPath2 = [bundle pathForResource:@"Root" ofType:@"strings"];
    //    NSArray *array2 = [[NSArray alloc] initWithContentsOfFile:plistPath];
    appDescDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath2];
    
    
    // build the array from the plist
//    NSDictionary *test4 = [appArray objectAtIndex:4];
//    NSLog(@"%@", [test4 valueForKey:@"Title"]);
//    
//    NSString *plistPath2 = [bundle pathForResource:@"Root" ofType:@"strings"];
//    //    NSArray *array2 = [[NSArray alloc] initWithContentsOfFile:plistPath];
//    NSDictionary *dictionary2 = [[NSDictionary alloc] initWithContentsOfFile:plistPath2];
//    NSLog(@"%@", [dictionary2 valueForKey:[test4 valueForKey:@"Title"]]);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)didSettingBtnPressed:(id)sender {
    if ([myDelegate respondsToSelector:@selector(didSettingBtnPressed)]) {
        [myDelegate didSettingBtnPressed];
    }
}

- (IBAction)didFeedbackBtnPressed:(id)sender {
    if ([myDelegate respondsToSelector:@selector(didFeedbackBtnPressed)]) {
        [myDelegate didFeedbackBtnPressed];
    }
}

- (IBAction)didAccountBtnPressed:(id)sender {
    if ([myDelegate respondsToSelector:@selector(didAccountBtnPressed)]) {
        [myDelegate didAccountBtnPressed];
    }
}

#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView //明确cell数目
 numberOfRowsInSection:(NSInteger)section {
    return [appArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSInteger row = indexPath.row;
    static NSString *FirstLevelCell= @"MoreAppCell";
    MoreAppCell *cell = (MoreAppCell*)[tableView dequeueReusableCellWithIdentifier:FirstLevelCell];
    if (!cell) {
        cell = (MoreAppCell*)[[[NSBundle mainBundle] loadNibNamed:@"MoreAppCell"
                                                            owner:self
                                                          options:nil] objectAtIndex:0];
//        if (isAll) {
//            [cell.imgOne whenTapped:^{
//                if ([myDelegate respondsToSelector:@selector(didImgPressed:)]) {
//                    [myDelegate didImgPressed:cell.imgOne.tag];
//                }
//            }];
//        } else {
//            [cell.imgOne whenTapped:^{
//                if ([myDelegate respondsToSelector:@selector(didImgPressedLocal:)]) {
//                    [myDelegate didImgPressedLocal:[voaTitles objectAtIndex:row]];
//                }
//            }];
//            
//        }
        
    }
    
    NSDictionary *nowApp = [appArray objectAtIndex:indexPath.row];
    
    [cell.appImg setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[appDescDic valueForKey:[nowApp valueForKey:@"img"]]  ofType:@"png"]]];
    
    [cell.titleLabel setText:[appDescDic valueForKey:[nowApp valueForKey:@"title"]]];
    
    [cell.descLabel setText:[appDescDic valueForKey:[nowApp valueForKey:@"desc"]]];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

#pragma mark -
#pragma mark TableView Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 73.f;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self endEditing:YES];
    NSDictionary *nowApp = [appArray objectAtIndex:indexPath.row];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[appDescDic valueForKey:[nowApp valueForKey:@"store"]]]];
}

@end
