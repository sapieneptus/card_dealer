//
//  CardHandCell.m
//  Card Dealer
//
//  Created by Christopher Fuentes on 3/21/15.
//  Copyright (c) 2015 Christopher Fuentes. All rights reserved.
//

#import "CardHandCell.h"
#import "Card.h"

#define CARD_START_Y     35
#define CARD_START_X     20
#define CARD_PADDING     25
#define CARD_HEIGHT 65
#define CARD_WIDTH  40


@interface CardHandCell ()
@property (nonatomic, retain) NSMutableArray *cardImageViews;

/* Remove current card images from subviews so they can be released */
- (void)clearCards;
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
    [self clearCards];
    
    /* Layout cards left to right. 
     Facedown cards will be slanted toward the right */
    float x = CARD_START_X, y = CARD_START_Y;
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
            
            x += CARD_WIDTH + CARD_PADDING;
            if (!card.faceup) {
                cardImageView.transform = CGAffineTransformMakeRotation((M_PI * 45 / 180));
            }
            
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
