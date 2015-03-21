//
//  Constants.m
//  Card Dealer
//
//  Created by Christopher Fuentes on 3/21/15.
//  Copyright (c) 2015 Christopher Fuentes. All rights reserved.
//

#import "Constants.h"

const unsigned short NUM_DECKS  = 1;



/* Array of NSNumbers representing all valid card values */
const NSArray *CARD_VALUES = @[
                               [NSNumber numberWithShort:kCardValueAce],
                               ];

/* Array of NSNumbers representing all valid card colors */
extern const NSArray *CARD_COLORS;

/* Array of NSNumbers representing all valid card suites */
extern const NSArray *CARD_SUITES;