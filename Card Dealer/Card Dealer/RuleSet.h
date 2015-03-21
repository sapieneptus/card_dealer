//
//  RuleSeet.h
//  Card Dealer
//
//  Created by Christopher Fuentes on 3/21/15.
//  Copyright (c) 2015 Christopher Fuentes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RuleSet : NSObject

@property (nonatomic, readonly)     unsigned short  numFaceUpCards;      /* face up cards per round per player */
@property (nonatomic, readonly)     unsigned short  numFaceDownCards;    /* face down cards per round per player */
@property (nonatomic, readonly)     unsigned short  numCommunityCards;   /* face up cards that all players share */
@property (nonatomic, retain, readonly) NSString    *name;

+ (RuleSet *)texasHoldemRules;      /* http://en.wikipedia.org/wiki/Texas_hold_%27em  */
+ (RuleSet *)fiveCardStudRules;     /* http://www.pagat.com/poker/variants/5stud.html */

@end
