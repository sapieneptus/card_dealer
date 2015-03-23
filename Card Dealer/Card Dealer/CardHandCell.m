//
//  CardHandCell.m
//  Card Dealer
//
//  Created by Christopher Fuentes on 3/21/15.
//  Copyright (c) 2015 Christopher Fuentes. All rights reserved.
//

#import "CardHandCell.h"
#import "Constants.h"
#import "Card.h"

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

/* Animates the cards offscreen and removes them from their superview */
- (void)clearCards {
    
    float   anim_delay_factor   = CARD_EXIT_ANIM_DELAY_FACTOR,
            anim_constant       = CARD_EXIT_ANIM_CONSTANT,
            screenWidth         = [UIScreen mainScreen].bounds.size.width;
    
    for (UIImageView *imageView in _cardImageViews) {
        
        /* Calculate staggered animation delay for card */
        float anim_delay = anim_constant + F_INVERSE(anim_delay_factor += anim_delay_factor);
        
        /* Calculate offscreen location as card's destination */
        CGRect offscreen = CGRectMake(screenWidth + CARD_WIDTH, CARD_START_Y, CARD_WIDTH, CARD_HEIGHT);
        
        [UIView animateWithDuration:anim_delay animations:^{
            imageView.frame = offscreen;
        } completion:^(BOOL finished) {
            [imageView removeFromSuperview];
        }];
    }
    
    [_cardImageViews removeAllObjects];
}

/*
 *  fillFromCards clears the current cards, 
 *  looks up png images for each card,
 *  places them offscreen and then animates them 
 *  onscreen in a staggered way after a short delay. 
 *
 *  The end result is that the current cards on the 
 *  table will be swept off as the new cards are 
 *  being pulled in.
 */
- (void)fillFromCards:(NSArray *)cards {
    [self clearCards];
    
    /* Layout cards left to right. 
     Facedown cards will be slanted toward the right */
    
    float   x           = CARD_START_X,
            y           = CARD_START_Y,
            anim_delay  = 2;
    
    for (Card *card in cards) {
        
        /* Get the corresponding .png image */
        UIImage *cardImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", card.description]];
        
        /* If Constants have been modified, it's possible there won't be an image for the card.  */
        if (cardImage) {
            UIImageView *cardImageView  = [[[UIImageView alloc] initWithImage:cardImage] autorelease];
            
            /* Start cards offscreen to the left */
            CGRect frame                = CGRectMake(-CARD_WIDTH, y, CARD_WIDTH, CARD_HEIGHT);
            cardImageView.frame         = frame;
            [self addSubview:cardImageView];
            
            /* Now we calculate the card's onscreen position */
            frame                       = CGRectMake(x, y, CARD_WIDTH, CARD_HEIGHT);
            
            /* Animate the card's entrance with a reverse stagger, such that
                the last card dealt will move the fastest onscreen           */
            [UIView animateWithDuration:CARD_ENTER_ANIM_CONSTANT + F_INVERSE(anim_delay += anim_delay)
                                  delay:CARD_ENTER_ANIM_DELAY
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                cardImageView.frame = frame;
                if (!card.faceup) {
                    cardImageView.transform = CGAffineTransformMakeRotation(CARD_TILT_RADIANS);
                }
            } completion:nil];
            
            /* Update x with the onscreen position of the next card */
            x += CARD_WIDTH + CARD_PADDING;
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
