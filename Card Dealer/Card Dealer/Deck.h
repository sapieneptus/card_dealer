//
//  Deck.h
//  Card Dealer
//
//  Created by Christopher Fuentes on 3/21/15.
//  Copyright (c) 2015 Christopher Fuentes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

/* returns the topmost num cards in the deck, or nil if that many cards aren't available */
- (NSArray *)drawCards:(unsigned short)num;

/* Replaces all cards in the deck */
- (void)rebuild;

/* Randomizes order of cards currently available for draw */
- (void)shuffle;

/* new deck comprised of  */
+ (Deck *)newDeck;

@end
