//
//  ListView.h
//  VOAImage
//
//  Created by zhao song on 13-6-18.
//  Copyright (c) 2013年 Dmitry Kondratyev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListCell.h"

@class ListView;

@protocol ListViewDelegate <NSObject>
@optional
- (void)didImgPressed:(NSInteger) newsIndex;
@end

@interface  ListView: UIScrollView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UIButton* backBtn;
@property (nonatomic, assign) id <ListViewDelegate> myDelegate;

@end
