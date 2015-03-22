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

+ (NSString *)nameForCardValue:(CardValue)val {
    switch (val) {
            HANDLE_CASE(kCardValueAce,      @"ace");
            HANDLE_CASE(kCardValueTwo,      @"2");
            HANDLE_CASE(kCardValueThree,    @"3");
            HANDLE_CASE(kCardValueFour,     @"4");
            HANDLE_CASE(kCardValueFive,     @"5");
            HANDLE_CASE(kCardValueSix,      @"6");
            HANDLE_CASE(kCardValueSeven,    @"7");
            HANDLE_CASE(kCardValueEight,    @"8");
            HANDLE_CASE(kCardValueNine,     @"9");
            HANDLE_CASE(kCardValueTen,      @"10");
            HANDLE_CASE(kCardValueJack,     @"jack");
            HANDLE_CASE(kCardValueQueen,    @"queen");
            HANDLE_CASE(kCardValueKing,     @"king");
            
        default:
            NSAssert(NO, @"Card value not handled in nameForCardValue: %d", val);
            return nil;
    }
}

+ (NSString *)nameForCardSuit:(CardSuit)suit {
    switch (suit) {
            HANDLE_CASE(kCardSuitClubs,     @"clubs");
            HANDLE_CASE(kCardSuitHearts,    @"hearts");
            HANDLE_CASE(kCardSuitSpades,    @"spades");
            HANDLE_CASE(kCardSuitDiamonds,  @"diamonds");
        default:
            NSAssert(NO, @"Card value not handled in nameForCardValue: %d", suit);
            return nil;
    }
}

/* Description for UI purposes */
- (NSString *)description {
    NSString *valueName = [Card nameForCardValue:self.value];
    NSString *suitName  = [Card nameForCardSuit:self.suit];
    return [NSString stringWithFormat:@"%@ of %@", valueName, suitName];
}
@end
