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
@property (nonatomic)           unsigned short  nextDrawIndex;
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
    CARD_VALUES = @[
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
                    ];
    
    CARD_SUITS = @[
                    NSNumberFromCardSuit(kCardSuitClubs),
                    NSNumberFromCardSuit(kCardSuitSpades),
                    NSNumberFromCardSuit(kCardSuitHearts),
                    NSNumberFromCardSuit(kCardSuitDiamonds)
                    ];
    
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
        
        /*  nextDrawIndex starts at the end of the array, since removing the last
         object is the most performant removal operation on NSMutableArray */
        
        _nextDrawIndex  = _cardStack.count - 1;
    }
    return self;
}

#pragma mark - Class Method Constructor

+ (Deck *)newDeck {
    /* Setup the cardStack with all possible permutations of CardValue*CardSuit */
    NSInteger numCards          = NUM_CARDS_PER_SET * NUM_CARD_SETS;
    NSMutableArray *cardStack   = [NSMutableArray arrayWithCapacity:numCards];
    int num_sets_added          = 0;
    
    /*  
        We'll want to synthesize a stack of NUM_DECKS 52 card decks.
        Apparently, some variations of poker call for several 52-card decks
     */
    while (num_sets_added < NUM_CARD_SETS) {
        for (NSNumber *value in CARD_VALUES) {
            for (NSNumber *suit in CARD_SUITS) {
                Card *card =    [Card cardWithValue:CardValueFromNumber(value)
                                              suit:CardSuitFromNumber(suit) ];
                [cardStack addObject:card];
            }
        }
        num_sets_added++;
    }

    return [[[Deck alloc] initWithCardStack:cardStack]  autorelease];
}

#pragma mark - Public API

/*
 * Draw doesn't mutate the stack, it simply returns the card at 
 * index `nextDrawIndex` and decrements `nextDrawIndex`.
 *
 * If all cards have been drawn, returns nil.
 */
- (Card *)draw {
    if (_nextDrawIndex == 0) {
        return nil;
    }
    
    Card *next = _cardStack[_nextDrawIndex];
    _nextDrawIndex--;
    return next;
}

- (void)shuffle {
    /* Standard in-place array shuffle for drawable portion of deck */
    NSInteger numAvailableCards = _nextDrawIndex + 1;
    
    for (int i = 0; i < numAvailableCards; i++) {
        int index           = (arc4random() % (numAvailableCards - i)) + i;
        Card *tmp           = _cardStack[i];
        _cardStack[i]       = _cardStack[index];
        _cardStack[index]   = tmp;
    }
}

- (void)rebuild {
    _nextDrawIndex = _cardStack.count - 1;
}

#pragma mark - Dealloc
- (void)dealloc {
    [_cardStack release];
    _cardStack = nil;
    [super dealloc];
}

@end