//
//  Player.h
//  Card Dealer
//
//  Created by Christopher Fuentes on 3/21/15.
//  Copyright (c) 2015 Christopher Fuentes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

@property (nonatomic, retain, setter=dealHand:)   NSArray *hand;

/*  Clears the players hand. Essentially an alias for dealHand:nil */
- (void)discardHand;

@end
