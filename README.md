# Card Dealer
Objective-C iOS App w/out ARC representing two card games


### Games
This project implements the dealer component of two card games: 5 Card Stud and Texas Hold'em.
Admittedly, I don't know how to play either of these games, so the rules are taken from 
http://www.pagat.com/poker/variants/5stud.html and http://en.wikipedia.org/wiki/Texas_hold_%27em 
respectively. 

The game allows you to 
  - Start a new game (of either variety) 
  - Deal the next round for the current game
   
The game does not
  - Evaluate player hands
  - Determine a winner
  - Handle the individual steps within a round (e.g., the flop, turn, and river for Texas Hold'em)
  
As I understand it, in casinos there is a very slanted distribution of cards in a playing deck to
bend odds against the players. However, for this application the deck will be a standard uniform 52 card
deck. The deck is shuffled after each round (I'm not sure if that's standard practice but seems reasonable). 

### Threading
This app requires no web calls and has a small enough data footprint that disk storage isn't necessary.
There also aren't any major arithmatic operations or long loops of calculations. Therefore, this app
is written as a single threaded application on the Main Thread. 

### Models and Data Structures

#### Player
A player just needs a reference to an array of cards. Since we're not dealing with the actual player
component of the game, we don't need to worry about things such as player name, winnings, etc... 

The player's 'hand' object can simply be an array.  Since the rounds are dealt in a single action, 
it is possible to use an immutable array for the hand (whereas if the rounds were dealt card by card, 
an immutable array would make more sense). 

Players should have a method for receiving a new hand of cards, which involves discarding the old one. 

### Deck
A deck can be thought of as two collections of cards: the facedown stack from which you draw, and the 
cards that are no longer in the deck (either in play or discarded), but will return to the deck at next 
shuffle. Therefore, one mutable array will be maintained as the draw-stack (from which cards are drawn) 
and another will be maintained as the drawn-stack (cards which have been used up. For this app, it 
doesn't really matter semantically where they are as long as it is noted that they are not in the
draw stack). 

An alternative (but worse) approach is simply to maintain the draw stack and then re-create a new 
shuffled deck at each shuffle action. However, this needlessly allocates and deallocates instances of 
the same set of cards. 

There should be a class method for generating a new shuffled deck as well as a `shuffle` instance method.
`- (void)shuffle` will shuffle the underlying mutable array in place, since we can do that easily with 
a mutable array (as opposed to, say, a linked-list implementation of a stack). 

### Card
Cards need to be aware of their value (number/court), suit, color, and faceup/facedown status. 
Therefore, this will be represented by three variables: a numeric value 1 through 13 
(ace through 10, jack, queen, king), an enum value representing their suite (taken from the standard 
French suites, Spade | Club | Hearts | Diamonds, see http://en.wikipedia.org/wiki/Playing_card#Modern_deck_formats), 
and an enum value representing the color red or black. The faceup/down status can be maintained with a `BOOL`.

Note that the suite technically entails a color already, but if the application were going to actually evaluate
hands it would need to redundantly call some map function to translate suite to color every time a card is 
evaluated. Storing a 2 byte short enum value seems like a reasonable tradeoff. 

Similarly, the house could be considered a distinct value from the numeric value (e.g., 'king' vs 13), but 
as I understand it the evaluation of cards could be implemented by pattern matching the sets of numeric values 
against a dictionary of hand evaluations. E.g., we don't need to know that you have a 'king' to know that 
you have a 'pair of kings', since 'pair of kings' can be codified as 'pair of 13'. 

### RuleSet
Admittedly I am shaky on domain knowledge for poker, but as I understand it there are a number of commonalities
amongst variations. In particular for dealing purposes, the main differences seem to be in how many cards 
each player gets, whether those cards are face up or face down, and the configuration of the 'community pool'.

A RuleSet object should therefore have a name (for UI display), a configuration of number of cards per 
player as well as face up/down count, and count for the community pool (which could be zero). 

Community cards have to be face up, so a simple `short` will suffice (we don't need a full `int` because even
the most extreme decks generally stay under a few hundred cards). We could use a dictionary/table for the
player hand configuration, but since it is only two distinct numeric values I will just use `short`s 
for those as well. 

Though it's conceivable to make an object for the 'Community Pool', the usecase allows us to simply 
deal community cards to each player as part of their hand. I.e., any given community card will just
be referenced by all four players. I can imagine some rules variants where this might lead to trouble, 
but for the purpose of this application it will suffice.

For this app, we are assuming 4 players per game, but that number could also be abstracted to the RuleSet
if the variation of poker had some specifications for that. 

RuleSets will be available with class methods that return pre-defined sets of rules. 

### Game
A game object needs to be aware of some number of Players (which will have a turn ordering, so an array
makes sense), a Deck of cards, and a RuleSet. There is only one game at a time, so it should be a singleton.

The game should have a method to deal out a new round, which will first shuffle the deck and then use 
the RuleSet to determine how many cards to take from the Deck and in what face up/down configuration 
they should be. It then iterates through the players and gives them cards as appropriate. 

The game should also have a method to start a new game, which will accept an enum representing which 
set of rules (Hold'em or Stud), shuffle the deck and deal the first round using the new RuleSet.

Since winners/hand evaluation are not part of this project, that's really all we need from our models. 

## Views
There only needs to be one Xib for this app, which in a perfect would would contain first-in-class UI for 
a poker table. More likely, I'll have a barebones UI or maybe even purely textual. New Game / Deal Round 
can be handled via alert views and action sheets. 

## View Controllers
Since there is only one view, we only need one VC. Since `Game` is a singleton, we don't need to maintain
a reference. I imagine this class will be fairly barebones, as it more or less only has to pass events from 
the UI directly to the `Game` or its `Deck`, and reflect the results of those actions back in the UI. There's
virtually no middle step/process between a UI action and a method call on the underlying model. 

