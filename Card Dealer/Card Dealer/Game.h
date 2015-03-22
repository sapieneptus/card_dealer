//
//  Game.h
//  Card Dealer
//
//  Created by Christopher Fuentes on 3/21/15.
//  Copyright (c) 2015 Christopher Fuentes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RuleSet.h"

@interface Game : NSObject
@property (nonatomic, retain, readonly)   NSArray *players;
@property (nonatomic, retain, readonly)   NSArray *communityCards;

/* Deals the next round to players */
- (void)dealRound;

/* Start a new game with a given ruleset */
- (void)newGame:(RuleSet *)rules;

/* Convenience method to determine if current rule set has community cards */
- (BOOL)hasCommunityPool;

/* Game Singleton */
+ (Game *)sharedGame;
@end
