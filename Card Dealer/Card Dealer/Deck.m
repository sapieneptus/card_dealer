//
//  Deck.m
//  Card Dealer
//
//  Created by Christopher Fuentes on 3/21/15.
//  Copyright (c) 2015 Christopher Fuentes. All rights reserved.
//

#import "Deck.h"
#import "Constants.h"

@interface Deck()
@property (nonatomic, retain)   NSMutableArray  *cardStack;

/* private initialization method */
- (id)initWithCardStack:(NSMutableArray *)cardStack;
@end

@implementation Deck


static NSArray *CARD_VALUES;
static NSArray *CARD_SUITS;

/*  When class is initialized, we create NSArrays of the enums
 so that we can perform fast iteration to create the new deck */
+ (void)initialize {
    CARD_VALUES = [@[
                    NSNumberFromCardValue(kCardValueAce),
                    NSNumberFromCardValue(kCardValueTwo),
                    NSNumberFromCardValue(kCardValueThree),
                    NSNumberFromCardValue(kCardValueFour),
                    NSNumberFromCardValue(kCardValueFive),
                    NSNumberFromCardValue(kCardValueSix),
                    NSNumberFromCardValue(kCardValueSeven),
                    NSNumberFromCardValue(kCardValueEight),
                    NSNumberFromCardValue(kCardValueNine),
                    NSNumberFromCardValue(kCardValueTen),
                    NSNumberFromCardValue(kCardValueJack),
                    NSNumberFromCardValue(kCardValueQueen),
                    NSNumberFromCardValue(kCardValueKing),
                    ] retain];
    
    CARD_SUITS = [@[
                    NSNumberFromCardSuit(kCardSuitClubs),
                    NSNumberFromCardSuit(kCardSuitSpades),
                    NSNumberFromCardSuit(kCardSuitHearts),
                    NSNumberFromCardSuit(kCardSuitDiamonds)
                    ] retain];
    
    /* The following assumes no jokers/wildcards are used.  */
    NSAssert(NUM_CARDS_PER_SET == CARD_SUITS.count * CARD_VALUES.count,
             @"NUM_CARDS_PER_SET constant is wrong. Should equal number of card vals * number of card suits");
}

#pragma mark - Instance Constructors

/* Prevent client code from manually creating a Deck */
- (id)init {
    NSAssert(NO, @"Must user +[Deck newDeck] to create Decks");
    return nil;
}

/* Private init method used by class constructor */
- (id)initWithCardStack:(NSMutableArray *)cards {
    if (self = [super init]) {
        _cardStack = [cards retain];
    }
    return self;
}

#pragma mark - Class Method Constructor

+ (Deck *)newDeck {
    /* Setup the cardStack with all possible permutations of CardValue*CardSuit */
    NSInteger numCards          = TOTAL_NUM_CARDS;
    NSMutableArray *cardStack   = [NSMutableArray arrayWithCapacity:numCards];
    int num_sets_added          = 0;
    
    /*  
        We'll want to synthesize a stack of NUM_DECKS card sets.
        Apparently, some variations of poker call for several decks to be combined into one deck
     */
    while (num_sets_added < NUM_CARD_SETS) {
        for (NSNumber *value in CARD_VALUES) {
            for (NSNumber *suit in CARD_SUITS) {
                Card *card =    [[Card cardWithValue:CardValueFromNumber(value)
                                              suit:CardSuitFromNumber(suit) ] retain];
                [cardStack addObject:card];
            }
        }
        num_sets_added++;
    }

    return [[[Deck alloc] initWithCardStack:cardStack]  autorelease];
}

#pragma mark - Public API

/*
 * drawCards removes num cards from the stack and returns them
 * in a new NSArray object. Attempts to draw num cards but 
 * will return a smaller array if fewer are available.
 *
 * Client code must therefore verify that num drawn == num expected
 */
- (NSArray *)drawCards:(unsigned short)num;{
    NSMutableArray *cards = [NSMutableArray arrayWithCapacity:num];
    
    while ( (num--) && num < _cardStack.count ) {
        
        /* Pop the next card from the stack */
        Card *next = [_cardStack lastObject];
        
        /* Cards should be added face-down */
        next.faceup = NO;
        
        [cards addObject:next];
        [_cardStack removeLastObject];

    }
    return [NSArray arrayWithArray:cards];
}

- (void)addCards:(NSArray *)cards {
    [_cardStack addObjectsFromArray:cards];
}

- (void)shuffle {
    /* Standard in-place array shuffle  */
    for (int i = 0; i < _cardStack.count; i++) {
        int index           = (arc4random() % (_cardStack.count - i)) + i;
        Card *tmp           = _cardStack[i];
        _cardStack[i]       = _cardStack[index];
        _cardStack[index]   = tmp;
    }
}

#pragma mark - Dealloc
- (void)dealloc {
    [_cardStack release];
    [super dealloc];
}

@end