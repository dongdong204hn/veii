//
//  ListView.m
//  VOAImage
//
//  Created by zhao song on 13-6-18.
//  Copyright (c) 2013年 Dmitry Kondratyev. All rights reserved.
//

#import "ListView.h"
#import "JMWhenTapped.h"


@implementation ListView
@synthesize backBtn;
@synthesize myDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView //明确cell数目
 numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *FirstLevelCell= @"ListCell";
    ListCell *cell = (ListCell*)[tableView dequeueReusableCellWithIdentifier:FirstLevelCell];
    if (!cell) {
        cell = (ListCell*)[[[NSBundle mainBundle] loadNibNamed:@"ListCell"
                                                            owner:self
                                                          options:nil] objectAtIndex:0];
        [cell.imgOne whenTapped:^{
            if ([myDelegate respondsToSelector:@selector(didImgPressed:)]) {
                [myDelegate didImgPressed:cell.imgOne.tag];
            }
        }];
        [cell.imgTwo whenTapped:^{
            if ([myDelegate respondsToSelector:@selector(didImgPressed:)]) {
                [myDelegate didImgPressed:cell.imgTwo.tag];
            }
        }];
        [cell.imgThree whenTapped:^{
            if ([myDelegate respondsToSelector:@selector(didImgPressed:)]) {
                [myDelegate didImgPressed:cell.imgThree.tag];
            }
        }];
    }
    
    [cell.imgOne setImage:[UIImage imageNamed:[NSString stringWithFormat:@"20130501_%d.jpg", indexPath.row * 3 + 1]]];
    [cell.imgOne setTag:indexPath.row * 3 + 1];
    
    [cell.imgTwo setImage:[UIImage imageNamed:[NSString stringWithFormat:@"20130501_%d.jpg", indexPath.row * 3 + 2]]];
    [cell.imgTwo setTag:indexPath.row * 3 + 2];
    
    [cell.imgThree setImage:[UIImage imageNamed:[NSString stringWithFormat:@"20130501_%d.jpg", indexPath.row * 3 + 3]]];
    [cell.imgThree setTag:indexPath.row * 3 + 3];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

#pragma mark -
#pragma mark Table View Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130.f;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
