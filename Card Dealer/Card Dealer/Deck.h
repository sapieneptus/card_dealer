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

/* returns the topmost num cards in the deck, or less if only fewer are available */
- (NSArray *)drawCards:(unsigned short)num;

/* Adds cards to the deck, e.g. when players discard their hands after a round */
- (void)addCards:(NSArray *)cards;

/* Randomizes order of cards currently available for draw */
- (void)shuffle;

/* new deck comprised of  */
+ (Deck *)newDeck;

@end
