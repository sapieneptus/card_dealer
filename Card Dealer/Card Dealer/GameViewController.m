//
//  GameViewController.m
//  Card Dealer
//
//  Created by Christopher Fuentes on 3/21/15.
//  Copyright (c) 2015 Christopher Fuentes. All rights reserved.
//

#import "GameViewController.h"
#import "Constants.h"
#import "Game.h"

#define CELL_ID                         @"cell_id"
#define PLAYER_HANDS_SECTION_TITLE      @"Player Hands"
#define COMMUNITY_POOL_SECTION_TITLE    @"Community Pool"
#define CHOOSE_GAME_ALERT_TITLE         @"Choose Game"
#define CHOOSE_GAME_ALERT_MESSAGE       @""
#define CHOOSE_GAME_CANCEL_BUTTON_TITLE @"Cancel"

typedef NS_ENUM(short, TableSections) {
    kTableSectionCommunity,
    kTableSectionPlayers
};

@interface GameViewController ()

@end

@implementation GameViewController
static const NSArray *GAME_RULES_OPTIONS;
static const NSArray *GAME_RULES_OPTION_NAMES;

+ (void)initialize {
    /* Define the set of rule choices for the user */
    GAME_RULES_OPTIONS = [@[ [RuleSet texasHoldemRules], [RuleSet fiveCardStudRules] ] retain];
    
    /* Get a corresponding array of the names of those rulesets, e.g. "Texas Hold'em" */
    NSMutableArray *gameNames = [NSMutableArray arrayWithCapacity:GAME_RULES_OPTIONS.count];
    for (RuleSet *ruleSet in GAME_RULES_OPTIONS) {
        [gameNames addObject:ruleSet.name];
    }
    
    GAME_RULES_OPTION_NAMES = [[NSArray arrayWithArray:gameNames] retain];
}

#pragma mark - UIViewController LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    _gameInfoTable.dataSource   = self;
    _gameInfoTable.delegate     = self;
}


#pragma mark - UITableViewDelegate/Datasource methods

/* One row for each player + 1 row for the  */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
            HANDLE_CASE(kTableSectionCommunity, 1);
            HANDLE_CASE(kTableSectionPlayers,   [Game sharedGame].players.count);
        default:
            NSAssert(NO, @"Unhandled section for table: %ld", (long)section);
            return 0;
            break;
    }
}

/* There are up to two sections: Community Card section (if any), and player section*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([Game sharedGame].communityCards.count > 0) {
        return 2;
    } else {
        return 1;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([Game sharedGame].communityCards.count > 0) {
        switch (section) {
                HANDLE_CASE(kTableSectionPlayers,   PLAYER_HANDS_SECTION_TITLE);
                HANDLE_CASE(kTableSectionCommunity, COMMUNITY_POOL_SECTION_TITLE);
                
            default:
                NSAssert(NO, @"Unhandled section for table: %ld", (long)section);
                return nil;
                break;
        }
    } else {
        return PLAYER_HANDS_SECTION_TITLE;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_ID] autorelease];
    }
    
    if (indexPath.section == kTableSectionCommunity) {
        cell.textLabel.text = @"";
    } else {
        cell.textLabel.text = [NSString stringWithFormat:@"Player %ld", indexPath.row + 1];
    }
    
    /* Cells should not appear to be interactive */
    cell.selectionStyle     = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - UIAlertView Delegate Methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        /* Canel button, do nothing */
    } else {
        /* Get the corresponding RuleSet and start a new game */
        RuleSet *rules = GAME_RULES_OPTIONS[buttonIndex];
        [[Game sharedGame] newGame:rules];
        [_gameInfoTable reloadData];
        
        _gameInfoTable.hidden = NO;
    }
}

/* Deal a new round */
- (IBAction)dealRoundPressed:(id)sender {
    [[Game sharedGame] dealRound];
    [_gameInfoTable reloadData];
}

#pragma mark - Button Actions
- (IBAction)newGamePressed:(id)sender {
    UIAlertView *av = [[[UIAlertView alloc] initWithTitle:CHOOSE_GAME_ALERT_TITLE
                                                 message:CHOOSE_GAME_ALERT_MESSAGE
                                                delegate:self
                                       cancelButtonTitle:CHOOSE_GAME_CANCEL_BUTTON_TITLE
                                        otherButtonTitles:nil] autorelease];
    
    /* Add a button for each set of rules */
    for (NSString *rulesName in GAME_RULES_OPTION_NAMES) {
        [av addButtonWithTitle:rulesName];
    }
    
    [av show];
}

#pragma mark - Dealloc

- (void)dealloc {
    [_gameInfoTable release];
    [super dealloc];
}

@end
