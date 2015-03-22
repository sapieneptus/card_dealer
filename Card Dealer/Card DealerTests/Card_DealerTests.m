//
//  Card_DealerTests.m
//  Card DealerTests
//
//  Created by Christopher Fuentes on 3/21/15.
//  Copyright (c) 2015 Christopher Fuentes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Deck.h"
#import "Game.h"
#import "Player.h"

@interface Card_DealerTests : XCTestCase

@end

@implementation Card_DealerTests

- (void)setUp {
    [super setUp];
    
}

- (void)tearDown {
    [super tearDown];
}

- (void)testDeckShuffle {
    Deck *deck = [Deck newDeck];
    XCTAssert(deck, @"Deck class constructor returned nil.");
    
    /* Try shuffling, removing a card, then repeating until no cards left. */
    @try {
        while ( [deck drawCards:1].count > 0 ) {
            [deck shuffle];
        }
    }
    /* Catch index out of bounds, etc. */
    @catch (NSException *exception) {
        XCTAssert(NO, @"Shuffle failed: %@", [exception reason]);
    }
}

- (void)testDeckIntegrity {
    Deck *deck              = [Deck newDeck];
    [deck shuffle];
    
    NSArray *forwardsCards  = [deck drawCards:TOTAL_NUM_CARDS];
    XCTAssert(forwardsCards.count == TOTAL_NUM_CARDS,
              @"Drew %d cards but only got %ld", TOTAL_NUM_CARDS, (long)forwardsCards.count);
    [deck addCards:forwardsCards];
    
    /* Deck is now backwards */
    
    NSArray *backwardsCards = [deck drawCards:TOTAL_NUM_CARDS];
    [deck addCards:backwardsCards];
    XCTAssert(backwardsCards.count == TOTAL_NUM_CARDS,
              @"Drew %d cards but only got %ld", TOTAL_NUM_CARDS, (long)backwardsCards.count);
    
    /* Deck should now be forwards again */
    
    NSArray *newCards       = [deck drawCards:TOTAL_NUM_CARDS];
    
    for (int i = 0; i < newCards.count; i++) {
        XCTAssert(forwardsCards[i] == newCards[i], @"Deck is out of order after draw");
    }
    
    /* Make sure that when a card is drawn, it can't be drawn again.
     Note that we can't use isEqual, since it is possible for there to be
     duplicates if NUM_CARD_SETS > 1 */
    
    deck = [Deck newDeck];
    [deck shuffle];
    
    Card *card = [deck drawCards:1][0];
    NSArray *draw;
    while ( (draw = [deck drawCards:1]).count > 0 ) {
        Card *drawn = draw[0];
        XCTAssert(card != drawn, @"The same card was drawn twice from the deck.");
    }
}

- (void)testGameSetup {

    /* Test singleton enforcement */
    Game *game  = [Game sharedGame];
    Game *dup   = [Game sharedGame];
    XCTAssert(game == dup, @"Duplicate instance of game singleton created");
    
    /* Ensure num players is correct */
    NSInteger gameNumPlayers = game.players.count;
    XCTAssert(game.players.count == NUM_PLAYERS, @"Expected %d players, got %ld", NUM_PLAYERS, (long)gameNumPlayers);
}

- (void)testGameWithRules {
    Game *game  = [Game sharedGame];
    
    NSInteger gameNumPlayers = game.players.count;
    
    /* Test that all rules work with the decksize */
    for (RuleSet *rules in @[[RuleSet texasHoldemRules], [RuleSet fiveCardStudRules]]) {
        [game newGame:rules];
        
        /* Ensure num players is still correct */
        gameNumPlayers = game.players.count;
        XCTAssert(game.players.count == NUM_PLAYERS, @"Expected %d players, got %ld", NUM_PLAYERS, (long)gameNumPlayers);
        
        /* Ensure deck can not overflow */
        NSInteger cardsPerPlayer    = rules.numFaceDownCards + rules.numFaceUpCards;
        NSInteger cardsPerRound     = (cardsPerPlayer * NUM_PLAYERS ) + rules.numCommunityCards;
        int maxCards                = (NUM_CARD_SETS * NUM_CARDS_PER_SET);
        XCTAssert(cardsPerRound <= maxCards,
                  @"Decksize is %d but size %ld is required. Check configuration in Constants.m",
                  maxCards, (long)cardsPerRound);
        
        /* Ensure that players are consistently dealt the appropriate number of cards */
        short i = 1000;
        while (i--) {
            [game dealRound];
            for (Player *player in game.players) {
                unsigned short numPlayerCards = rules.numFaceDownCards + rules.numFaceUpCards;
                XCTAssert(player.hand.count == numPlayerCards,
                          @"Expected %d cards for player, got %ld", numPlayerCards, (long)player.hand.count);
            }
        }
    }
}

@end
