//
//  Card.m
//  Card Dealer
//
//  Created by Christopher Fuentes on 3/21/15.
//  Copyright (c) 2015 Christopher Fuentes. All rights reserved.
//

#import "Card.h"

@interface Card ()

/* private initializer for class initializer */
- (id)initWithValue:(CardValue)val suit:(CardSuit)suit;

/* class helper methods for converting card variables to NSString */
+ (NSString *)nameForCardSuit:(CardSuit)suit;
+ (NSString *)nameForCardValue:(CardValue)val;
@end

@implementation Card

/* Prevent client code from manually creating Cards */
- (id)init {
    NSAssert(NO, @"Must use +[Card cardWithValue:suit:] to initialize Cards");
    return nil;
}

- (id)initWithValue:(CardValue)val suit:(CardSuit)suit {
    if (self = [super init]) {
        _value  = val;
        _suit  = suit;
        _faceup = NO;    
    }
    return self;
}

+ (Card *)cardWithValue:(CardValue)val suit:(CardSuit)suit {
    Card *card = [[Card alloc] initWithValue:val suit:suit];
    return [card autorelease];
}

/* No objects to deallocate */
- (void)dealloc {
    [super dealloc];
}

#pragma mark - Card variables to NSString

/* Convenience macro to help clean up the switch statements in the next two methods */
#define HANDLE_CASE( val, ret ) case ( val ): return ret; break
+ (NSString *)nameForCardValue:(CardValue)val {
    switch (val) {
            HANDLE_CASE(kCardValueAce,      @"Ace");
            HANDLE_CASE(kCardValueTwo,      @"Two");
            HANDLE_CASE(kCardValueThree,    @"Three");
            HANDLE_CASE(kCardValueFour,     @"Four");
            HANDLE_CASE(kCardValueFive,     @"Five");
            HANDLE_CASE(kCardValueSix,      @"Six");
            HANDLE_CASE(kCardValueSeven,    @"Seven");
            HANDLE_CASE(kCardValueEight,    @"Eight");
            HANDLE_CASE(kCardValueNine,     @"Nine");
            HANDLE_CASE(kCardValueTen,      @"Ten");
            HANDLE_CASE(kCardValueJack,     @"Jack");
            HANDLE_CASE(kCardValueQueen,    @"Queen");
            HANDLE_CASE(kCardValueKing,     @"King");
            
        default:
            NSAssert(NO, @"Card value not handled in nameForCardValue: %d", val);
            return nil;
    }
}

+ (NSString *)nameForCardSuit:(CardSuit)suit {
    switch (suit) {
            HANDLE_CASE(kCardSuitClubs,     @"Clubs");
            HANDLE_CASE(kCardSuitHearts,    @"Hearts");
            HANDLE_CASE(kCardSuitSpades,    @"Spades");
            HANDLE_CASE(kCardSuitDiamonds,  @"Diamonds");
        default:
            NSAssert(NO, @"Card value not handled in nameForCardValue: %d", suit);
            return nil;
    }
}
#undef HANDLE_CASE

/* Description for UI purposes */
- (NSString *)description {
    NSString *valueName = [Card nameForCardValue:self.value];
    NSString *suitName  = [Card nameForCardSuit:self.suit];
    return [NSString stringWithFormat:@"%@ of %@", valueName, suitName];
}
@end
