//
//  ListCell.h
//  VOAImage
//
//  Created by zhao song on 13-6-18.
//  Copyright (c) 2013年 Dmitry Kondratyev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UIImageView *imgOne;
@property (nonatomic,strong) IBOutlet UILabel *timeLabel;
@property (nonatomic,strong) IBOutlet UITextView *descView;

//@property (nonatomic,strong) IBOutlet UIImageView *imgTwo;
//@property (nonatomic,strong) IBOutlet UIImageView *imgThree;

@end
