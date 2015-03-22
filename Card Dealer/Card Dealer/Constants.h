//
//  Constants.h
//  Card Dealer
//
//  Created by Christopher Fuentes on 3/21/15.
//  Copyright (c) 2015 Christopher Fuentes. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef unsigned short CardValueType;
typedef unsigned short CardSuitType;

/* Some macros for conversion between NSNumber and card value/suit enum values */
#define NSNumberFromCardValue( val )    [NSNumber numberWithShort:( val )]
#define NSNumberFromCardSuit( val )     [NSNumber numberWithShort:( val )]
#define CardValueFromNumber( num )      [( num ) shortValue]
#define CardSuitFromNumber( num )       [( num ) shortValue]

/* Convenience macro to help clean up the switch statements where 
 * a value is returned without any other operations performed */
#define HANDLE_CASE( val, ret ) case ( val ): return ret; break

/* Cards have a value Ace through King, which corresponds to 1 through 13 */
typedef NS_ENUM(CardValueType, CardValue) {
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

/*  Card suits, as in standard French setup
    See http://en.wikipedia.org/wiki/Playing_card#Modern_deck_formats  */
typedef NS_ENUM(CardSuitType, CardSuit) {
    kCardSuitHearts,
    kCardSuitDiamonds,
    kCardSuitClubs,
    kCardSuitSpades
};

/* Number of sets of cards to use in a single deck */
extern const unsigned short NUM_CARD_SETS;

/* Number of cards per deck. Should equal number of card values * number of card suits */
extern const unsigned short NUM_CARDS_PER_SET;

/* Total num cars = NUM_CARD_SETS * NUM_CARDS_PER_SET */
extern const unsigned short TOTAL_NUM_CARDS;

/* Number of players per game. For this app, it's just a constant */
extern const unsigned short NUM_PLAYERS;

/* 
 * Texas Hold'em configuration 
 */
extern const unsigned short TEXAS_HOLDEM_NUM_FACE_UP;
extern const unsigned short TEXAS_HOLDEM_NUM_FACE_DOWN;
extern const unsigned short TEXAS_HOLDEM_NUM_COMMUNITY;

/* 
 * Five Card Stud configuration
 */
extern const unsigned short FIVE_CARD_STUD_NUM_FACE_UP;
extern const unsigned short FIVE_CARD_STUD_NUM_FACE_DOWN;
extern const unsigned short FIVE_CARD_STUD_NUM_COMMUNITY;

