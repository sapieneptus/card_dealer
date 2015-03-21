//
//  RuleSeet.m
//  Card Dealer
//
//  Created by Christopher Fuentes on 3/21/15.
//  Copyright (c) 2015 Christopher Fuentes. All rights reserved.
//

#import "RuleSet.h"
#import "Constants.h"

@interface RuleSet ()

/* Private instance creation */
- (instancetype)initWithNumFaceUp:(unsigned short)faceUp
                      numFaceDown:(unsigned short)faceDown
                     numCommunity:(unsigned short)numCommunity
                             name:(NSString *)name;
@end

@implementation RuleSet

#pragma mark - Instance Instantiation
- (instancetype)initWithNumFaceUp:(unsigned short)faceUp
                      numFaceDown:(unsigned short)faceDown
                     numCommunity:(unsigned short)numCommunity
                             name:(NSString *)name {
    if (self = [super init]) {
        _numFaceUpCards     = faceUp;
        _numFaceDownCards   = faceDown;
        _numCommunityCards  = numCommunity;
        _name               = [name retain];
    }
    return self;
}

/* Prevent client code from manually creating a RuleSet */
- (id)init {
    NSAssert(NO, @"Must use a class method to instantiate RuleSet");
    return nil;
}

#pragma mark - Class Methods

+ (RuleSet *)texasHoldemRules {
    return [[[RuleSet alloc] initWithNumFaceUp:TEXAS_HOLDEM_NUM_FACE_UP
                                   numFaceDown:TEXAS_HOLDEM_NUM_FACE_DOWN
                                  numCommunity:TEXAS_HOLDEM_NUM_COMMUNITY
                                          name:@"Texas Hold'em"] autorelease];
}

+ (RuleSet *)fiveCardStudRules {
    return [[[RuleSet alloc] initWithNumFaceUp:FIVE_CARD_STUD_NUM_FACE_UP
                                   numFaceDown:FIVE_CARD_STUD_NUM_FACE_DOWN
                                  numCommunity:FIVE_CARD_STUD_NUM_COMMUNITY
                                          name:@"Five Card Stud"] autorelease];
}

#pragma mark - dealloc
- (void)dealloc {
    [_name release];
    _name = nil;
    [super dealloc];
}

@end
