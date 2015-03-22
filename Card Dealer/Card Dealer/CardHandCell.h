//
//  CardHandCell.h
//  Card Dealer
//
//  Created by Christopher Fuentes on 3/21/15.
//  Copyright (c) 2015 Christopher Fuentes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardHandCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *playerNameLabel;

/* Setup cell UI from an array of Card objects */
- (void)fillFromCards:(NSArray *)cards;

@end
