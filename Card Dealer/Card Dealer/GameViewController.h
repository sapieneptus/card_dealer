//
//  ViewController.h
//  Card Dealer
//
//  Created by Christopher Fuentes on 3/21/15.
//  Copyright (c) 2015 Christopher Fuentes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (retain, nonatomic) IBOutlet UITableView *gameInfoTable;

- (IBAction)newGamePressed:(id)sender;
- (IBAction)dealRoundPressed:(id)sender;

@end

