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

@interface Card_DealerTests : XCTestCase

@end

@implementation Card_DealerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDeckAPI {
    Deck *deck = [Deck newDeck];
    Card *card;
    
    XCTAssert(deck, @"Deck class constructor returned nil.");
    
    /* Try shuffling, removing a card, then repeating until no cards left. */
    @try {
        while ( (card = [deck draw] ) != nil ) {
            [deck shuffle];
        }
    }
    /* Catch index out of bounds, etc. */
    @catch (NSException *exception) {
        XCTAssert(NO, @"Shuffle failed: %@", [exception reason]);
    }
    @finally {
        /* Make sure that drawing the deck, rebuilding, and drawing again returns the same sequence. */
        [deck rebuild];
        
        NSMutableArray *cards = [NSMutableArray array];
        while ( (card = [deck draw] ) != nil ) {
            [cards addObject:card];
        }
        
        [deck rebuild];
        
        for (int i = 0; i < cards.count; i++) {
            card = [deck draw];
            XCTAssert(card == cards[i], @"Deck is out of order after draw");
        }
    }
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
