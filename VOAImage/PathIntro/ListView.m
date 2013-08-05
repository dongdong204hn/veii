//
//  ListView.m
//  VOAImage
//
//  Created by zhao song on 13-6-18.
//  Copyright (c) 2013年 Dmitry Kondratyev. All rights reserved.
//

#import "ListView.h"
#import "JMWhenTapped.h"
#import "UIImageView+WebCache.h"

@implementation ListView
@synthesize backBtn;
@synthesize myDelegate;
@synthesize listView;
@synthesize allBtn;
@synthesize locBtn;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (void)awakeFromNib {
    voaTitles = [[NSMutableArray alloc] init];
    [VOATitle findAll:voaTitles];
    isAll = YES;
}

- (void)localFlush {
    isAll = NO;
    [voaTitles removeAllObjects];
    NSMutableArray *favs = [[NSMutableArray alloc] init];
    [VOAFav getList:favs];
    for (VOAFav *fav in favs) {
        [voaTitles addObject:[VOAView find:fav.voaid paraid:fav.paraid]];
    }
    [listView reloadData];
}

- (void)allFlush {
    isAll = YES;
    [voaTitles removeAllObjects];
    [VOATitle findAll:voaTitles];
    [listView reloadData];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
#pragma mark - My Aciton
- (IBAction)didAllPressed:(id)sender {
//    if ([myDelegate respondsToSelector:@selector(didAllPressed)]) {
//        [myDelegate didAllPressed];
//    }
    [allBtn setSelected:YES];
    [locBtn setSelected:NO];
    [self allFlush];
}

- (IBAction)didlocPressed:(id)sender {
//    if ([myDelegate respondsToSelector:@selector(didlocPressed)]) {
//        [myDelegate didlocPressed];
//    }
    [allBtn setSelected:NO];
    [locBtn setSelected:YES];
    [self localFlush];
}

#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView //明确cell数目
 numberOfRowsInSection:(NSInteger)section {
    return [voaTitles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    static NSString *FirstLevelCell= @"ListCell";
    ListCell *cell = (ListCell*)[tableView dequeueReusableCellWithIdentifier:FirstLevelCell];
    if (!cell) {
        cell = (ListCell*)[[[NSBundle mainBundle] loadNibNamed:@"ListCell"
                                                            owner:self
                                                          options:nil] objectAtIndex:0];
        if (isAll) {
            [cell.imgOne whenTapped:^{
                if ([myDelegate respondsToSelector:@selector(didImgPressed:)]) {
                    [myDelegate didImgPressed:cell.imgOne.tag];
                }
            }];
        } else {
            [cell.imgOne whenTapped:^{
                if ([myDelegate respondsToSelector:@selector(didImgPressedLocal:)]) {
                    [myDelegate didImgPressedLocal:[voaTitles objectAtIndex:row]];
                }
//                NSLog(@"aaaaaaaaaa:%@", [(VOAView *)[voaTitles objectAtIndex:row] title_Cn]);
            }];
            
        }
        
//        [cell.imgTwo whenTapped:^{
//            if ([myDelegate respondsToSelector:@selector(didImgPressed:)]) {
//                [myDelegate didImgPressed:cell.imgTwo.tag];
//            }
//        }];
//        [cell.imgThree whenTapped:^{
//            if ([myDelegate respondsToSelector:@selector(didImgPressed:)]) {
//                [myDelegate didImgPressed:cell.imgThree.tag];
//            }
//        }];
    }
    
    if (isAll) {
        VOATitle *voaTitle = [voaTitles objectAtIndex:row];
        NSLog(@"voaTitle:%@", voaTitle.pic);
        NSURL *url = [NSURL URLWithString:voaTitle.pic];
        [cell.imgOne setImageWithURL:url placeholderImage:[UIImage imageNamed:@"acquiesce.png"]];
        [cell.imgOne setTag:voaTitle.voaid];
        [cell.timeLabel setText:voaTitle.creatTime];
        [cell.descView setText:(voaTitle.descCn && ![voaTitle.descCn isEqualToString:@" null"])? voaTitle.descCn: @""];
    } else {
        VOAView *voaView = [voaTitles objectAtIndex:row];
        NSURL *url = [NSURL URLWithString:voaView.pic];
        [cell.imgOne setImageWithURL:url placeholderImage:[UIImage imageNamed:@"acquiesce.png"]];
        [cell.imgOne setTag:voaView.voaid];
        [cell.timeLabel setText:voaView.creatTime];
        [cell.descView setText:voaView.title_Cn];
    }
    
    
//    [cell.imgOne setImage:[UIImage imageNamed:[NSString stringWithFormat:@"20130501_%d.jpg", indexPath.row * 3 + 1]]];
//    [cell.imgOne setTag:indexPath.row * 3 + 1];
    
//    [cell.imgTwo setImage:[UIImage imageNamed:[NSString stringWithFormat:@"20130501_%d.jpg", indexPath.row * 3 + 2]]];
//    [cell.imgTwo setTag:indexPath.row * 3 + 2];
//    
//    [cell.imgThree setImage:[UIImage imageNamed:[NSString stringWithFormat:@"20130501_%d.jpg", indexPath.row * 3 + 3]]];
//    [cell.imgThree setTag:indexPath.row * 3 + 3];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}



#pragma mark -
#pragma mark Table View Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170.f;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}



@end
