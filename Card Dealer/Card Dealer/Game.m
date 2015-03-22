//
//  Game.m
//  Card Dealer
//
//  Created by Christopher Fuentes on 3/21/15.
//  Copyright (c) 2015 Christopher Fuentes. All rights reserved.
//

#import "Game.h"
#import "Deck.h"
#import "Player.h"

@interface Game ()
@property (nonatomic, retain) RuleSet   *rules;
@property (nonatomic, retain) Deck      *deck;

/* Pull cards from deck to be shared by players */
- (void)drawCommunityCards;

/* Prepare the table for the next round */
- (void)resetTableState;
@end

@implementation Game

static Game *sharedGame = nil;

- (id)init {
    if (self = [super init]) {
        /* Get the standard deck */
        _deck = [[Deck newDeck] retain];
        
        /* Set up players. Initially, they don't have any hand, so we just have to init the objects. */
        NSMutableArray *players = [NSMutableArray arrayWithCapacity:NUM_PLAYERS];
        
        for (int i = 0; i < NUM_PLAYERS; i++) {
            [players addObject:[Player new]];
        }
        
        _players = [[NSArray arrayWithArray:players] retain];
    }
    return self;
}

+ (instancetype)sharedGame {
    @synchronized(self) {
        if(sharedGame == nil)
            sharedGame = [[super allocWithZone:NULL] init];
    }
    return sharedGame;
}

#pragma mark - Gameplay methods
- (void)resetTableState {
    /* Prepare the deck for the round */
    [_deck rebuild];
    [_deck shuffle];
    
    /* Clear players' hands */
    for (Player *player in _players) {
        [player discardHand];
    }
}

- (void)drawCommunityCards {
    [_communityCards release];
    _communityCards = [[_deck drawCards:_rules.numCommunityCards] retain];
    NSAssert(_communityCards,
             @"Deck became overdrawn. Ensure decksize can handle number of playser/rules");
    
    /* Turn Community Cards Face Up */
    for (Card *card in _communityCards) {
        card.faceup = YES;
    }
}

- (void)dealRound {
    [self resetTableState];
    [self drawCommunityCards];
    
    for (Player *player in _players) {
        /* Clear player's hand */
        [player discardHand];
        
        /* Get numFaceUpCards cards, turn them face up */
        NSArray *playerFaceUp = [_deck drawCards:_rules.numFaceUpCards];
        NSAssert(playerFaceUp,
                 @"Deck became overdrawn. Ensure decksize can handle number of playser/rules");
        for (Card *card in playerFaceUp) { card.faceup = YES; }
        
        /* Get face down cards */
        NSArray *playerFaceDown = [_deck drawCards:_rules.numFaceDownCards];
        NSAssert(playerFaceDown,
                 @"Deck became overdrawn. Ensure decksize can handle number of playser/rules");

        /* Deal cards to player */
        NSMutableArray *playerCards = [NSMutableArray arrayWithArray:playerFaceUp];
        [playerCards addObjectsFromArray:playerFaceDown];
        [player dealHand:playerCards];
    }
}

- (void)newGame:(RuleSet *)rules {
    /* Set new rulees */
    if (_rules != rules) {
        [_rules release];
        _rules = [rules retain];
    }
    
    /* Deal the next round according to new rules */
    [self dealRound];
}


#pragma mark - MRR Method Overrides

+ (id)allocWithZone:(NSZone *)zone {
    NSAssert(sharedGame == nil, @"Attempted to allocate a second instance of sharedGame singleton");
    return [[self sharedGame] retain];
}

+ (id)alloc {
    NSAssert(sharedGame == nil, @"Attempted to allocate a second instance of sharedGame singleton");
    return [[self sharedGame] retain];
}

/* Copy not allowed for singletons */
- (id)copyWithZone:(NSZone *)zone {
    return self;
}

/* No reason to increment retain count, since it can't be dealloc'ed */
- (id)retain {
    return self;
}

/* Ensures it won't be dealloc'ed */
- (NSUInteger)retainCount {
    return UINT_MAX;
}

/* Should not decrement retain count, since this is a singleton */
- (oneway void)release {}

/* 
 Can't mark it for auto release since we may need to hold on to
 this for the entirety of the application. E.g. if client code created 
 another autorelease pool and tried to free it early, the entire app
 would lose access to the singleton (at least, the current state of it)
 */
- (id)autorelease {
    return self;
}

/* Since this is a singleton, this will never actually get called */
- (void)dealloc {
    [_rules release];
    [_players release];
    [_deck release];
    [_communityCards release];
    
    _rules          = nil;
    _players        = nil;
    _deck           = nil;
    _communityCards = nil;
    
    [super dealloc];
}

@end
