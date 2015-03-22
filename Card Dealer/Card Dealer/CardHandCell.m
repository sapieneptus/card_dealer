//
//  CardHandCell.m
//  Card Dealer
//
//  Created by Christopher Fuentes on 3/21/15.
//  Copyright (c) 2015 Christopher Fuentes. All rights reserved.
//

#import "CardHandCell.h"
#import "Card.h"

#define START_Y     35
#define START_X     10
#define PADDING     10
#define CARD_HEIGHT 50
#define CARD_WIDTH  30

@interface CardHandCell ()
@property (nonatomic, retain) NSMutableArray *cardImageViews;
@end

@implementation CardHandCell

- (void)awakeFromNib {
    /* Cells should not appear to be interactive */
    self.selectionStyle     = UITableViewCellSelectionStyleNone;
    _cardImageViews         = [[NSMutableArray array] retain];
}

- (void)clearCards {
    for (UIImageView *imageView in _cardImageViews) {
        [imageView removeFromSuperview];
    }
    [_cardImageViews removeAllObjects];
}

- (void)fillFromCards:(NSArray *)cards {
    
    
    float x = START_X, y = START_Y;
    for (Card *card in cards) {
        UIImage *cardImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", card.description]];
        if (cardImage) {
            UIImageView *cardImageView  = [[[UIImageView alloc] initWithImage:cardImage] autorelease];
            CGRect frame                = cardImageView.frame;
            frame.origin.x              = x;
            frame.origin.y              = y;
            frame.size.height           = CARD_HEIGHT;
            frame.size.width            = CARD_WIDTH;
            cardImageView.frame         = frame;
            [self addSubview:cardImageView];
            
            x += cardImageView.frame.size.width + PADDING;
            
            [_cardImageViews addObject:cardImageView];
        }
    }
}

- (void)dealloc {
    [_playerNameLabel release];
    [_cardImageViews dealloc];
    [super dealloc];
}
@end
