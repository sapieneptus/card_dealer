//
//  Card.h
//  Card Dealer
//
//  Created by Christopher Fuentes on 3/21/15.
//  Copyright (c) 2015 Christopher Fuentes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface Card : NSObject
@property (nonatomic)           BOOL            faceup;     /* defaults to facedown */
@property (nonatomic, readonly) CardValue       value;
@property (nonatomic, readonly) CardSuit        suit;

/* Creates a new card with given value and suit */
+ (Card *)cardWithValue:(CardValue)val suit:(CardSuit)suit;

@end
