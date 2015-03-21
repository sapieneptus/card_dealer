//
//  Player.m
//  Card Dealer
//
//  Created by Christopher Fuentes on 3/21/15.
//  Copyright (c) 2015 Christopher Fuentes. All rights reserved.
//

#import "Player.h"

@implementation Player

/*
 *  dealHand is just an alias for the hand setter.
 *  Semantically more understandable when called from the 
 *  another class.
 */
- (void)dealHand:(NSArray *)hand {
    if (hand == _hand) return;
    
    [_hand release];
    _hand   = [hand retain];
}

- (void)discardHand {
    [_hand  release];
    _hand   = nil;
}

- (void)dealloc {
    [_hand release];
    [super dealloc];
}

@end
