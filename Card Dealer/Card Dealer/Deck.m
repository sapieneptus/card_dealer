//
//  Deck.m
//  Card Dealer
//
//  Created by Christopher Fuentes on 3/21/15.
//  Copyright (c) 2015 Christopher Fuentes. All rights reserved.
//

#import "Deck.h"
#import "Constants.h"

@interface Deck(private)
@property (nonatomic)           unsigned short  nextDrawIndex;
@property (nonatomic, retain)   NSMutableArray  *cardStack;

/* Initialize the cardStack with cards */
- (void)setupCardStack;

@end

@implementation Deck

static NSArray *CARD_VALUES;
static NSArray *CARD_SUITES;
static NSArray *CARD_COLORS;

+ (void)initialize {
    CARD_VALUES = @[
                    [NSNumber numberWithShort:kCardValueAce],
                    [NSNumber numberWithShort:kCardValueTwo],
                    [NSNumber numberWithShort:kCardValueThree],
                    [NSNumber numberWithShort:kCardValueFour],
                    [NSNumber numberWithShort:kCardValueFive],
                    [NSNumber numberWithShort:kCardValueSix],
                    [NSNumber numberWithShort:kCardValueSeven],
                    [NSNumber numberWithShort:kCardValueEight],
                    [NSNumber numberWithShort:kCardValueNine],
                    [NSNumber numberWithShort:kCardValueTen],
                    [NSNumber numberWithShort:kCardValueJack],
                    [NSNumber numberWithShort:kCardValueQueen],
                    [NSNumber numberWithShort:kCardValueKing]
                    ];
    
    CARD_SUITES = @[
                    [NSNumber numberWithShort:kCardSuiteClubs],
                    [NSNumber numberWithShort:kCardSuiteSpades],
                    [NSNumber numberWithShort:kCardSuiteHearts],
                    [NSNumber numberWithShort:kCardSuiteDiamonds]
                    ];
    CARD_COLORS = @[
                    [NSNumber numberWithShort:kCardColorBlack],
                    [NSNumber numberWithShort:kCardColorRed]
                    ];
}

+ (Deck *)newDeck {
    Deck *deck  = [Deck new];
    
    
    return [deck autorelease];
}

- (void)setupCardStack {
    
}

- (Card *)draw {
    return nil;
}

- (void)shuffle {
    
}

- (void)rebuild {
    
}

@end
