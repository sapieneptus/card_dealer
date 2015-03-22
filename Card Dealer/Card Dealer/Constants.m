//
//  Constants.m
//  Card Dealer
//
//  Created by Christopher Fuentes on 3/21/15.
//  Copyright (c) 2015 Christopher Fuentes. All rights reserved.
//

#import "Constants.h"

/*
 * Deck configuration
 */
const unsigned short NUM_CARD_SETS                  = 1;
const unsigned short NUM_CARDS_PER_SET              = 52; /* == number of card values * number of card suits */
const unsigned short TOTAL_NUM_CARDS                = NUM_CARD_SETS * NUM_CARDS_PER_SET;

/*
 * Player configuration
 */
const unsigned short NUM_PLAYERS                    = 4;

/*
 * Texas Hold'em configuration
 */
const unsigned short TEXAS_HOLDEM_NUM_FACE_UP       = 0;
const unsigned short TEXAS_HOLDEM_NUM_FACE_DOWN     = 2;
const unsigned short TEXAS_HOLDEM_NUM_COMMUNITY     = 3;

/*
 * Five Card Stud configuration
 */
const unsigned short FIVE_CARD_STUD_NUM_FACE_UP     = 4;
const unsigned short FIVE_CARD_STUD_NUM_FACE_DOWN   = 1;
const unsigned short FIVE_CARD_STUD_NUM_COMMUNITY   = 0;

/*
*   Constants for Card UI Layout
*/
const float CARD_START_Y                            = 35.0;
const float CARD_START_X                            = 20.0;
const float CARD_PADDING                            = 25.0;
const float CARD_HEIGHT                             = 65.0;
const float CARD_WIDTH                              = 40.0;
