//
//  ListView.h
//  VOAImage
//
//  Created by zhao song on 13-6-18.
//  Copyright (c) 2013年 Dmitry Kondratyev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListCell.h"
#import "VOATitle.h"
#import "VOAFav.h"
#import "VOAView.h"

@class ListView;

@protocol ListViewDelegate <NSObject>
@optional
- (void)didImgPressed:(NSInteger)newsIndex;
- (void)didImgPressedLocal:(VOAView *)voaView;
//- (void)didAllPressed;
//- (void)didlocPressed;
@end

@interface  ListView: UIScrollView <UITableViewDataSource, UITableViewDelegate> {
    NSMutableArray *voaTitles;
    BOOL isAll;

}

@property (nonatomic, strong) IBOutlet UIButton* backBtn;
@property (nonatomic, strong) IBOutlet UIButton* allBtn;
@property (nonatomic, strong) IBOutlet UIButton* locBtn;
@property (nonatomic, strong) IBOutlet UITableView* listView;
@property (nonatomic, assign) id <ListViewDelegate> myDelegate;

- (IBAction)didAllPressed:(id)sender;
- (IBAction)didlocPressed:(id)sender;
- (void)localFlush;
- (void)allFlush;

@end
