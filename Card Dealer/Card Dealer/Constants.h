//
//  Constants.h
//  Card Dealer
//
//  Created by Christopher Fuentes on 3/21/15.
//  Copyright (c) 2015 Christopher Fuentes. All rights reserved.
//

#import <Foundation/Foundation.h>

/* Cards have a value Ace through King, which corresponds to 1 through 13 */
typedef NS_ENUM(unsigned short, CardValue) {
    kCardValueAce   = 1,
    kCardValueTwo   = 2,
    kCardValueThree = 3,
    kCardValueFour  = 4,
    kCardValueFive  = 5,
    kCardValueSix   = 6,
    kCardValueSeven = 7,
    kCardValueEight = 8,
    kCardValueNine  = 9,
    kCardValueTen   = 10,
    kCardValueJack  = 11,
    kCardValueQueen = 12,
    kCardValueKing  = 13,
};

/* Card colors. As per standard French layout, card can be Red or Black.
    See http://en.wikipedia.org/wiki/Playing_card#Modern_deck_formats */
typedef NS_ENUM(unsigned short, CardColor) {
    kCardColorRed,
    kCardColorBlack
};

/* Card suites, as in standard French setup */
typedef NS_ENUM(unsigned short, CardSuite) {
    kCardSuiteHearts,
    kCardSuiteDiamonds,
    kCardSuiteClubs,
    kCardSuiteSpades
};

/* Number of 52 card decks to use */
extern const unsigned short NUM_DECKS;
