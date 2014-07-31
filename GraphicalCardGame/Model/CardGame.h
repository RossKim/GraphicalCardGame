//
//  CardGame.h
//  GraphicalCardGame
//
//  Created by Kim Minsu on 2013/05/10.
//  Copyright (c) 2013年 Kim Minsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface CardGame : NSObject

#define FLIP_COST 1
#define MISMATCH_PENALTY 2
#define MATCH_BONUS 4

//designated initializer
- (id)initWithCardCount:(NSUInteger)cardCount
              usingDeck:(Deck *)deck;

- (BOOL)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

- (BOOL)addCard:(NSUInteger)cardCount usingDeck:(Deck *)deck;

@property (nonatomic) int score;
@property (nonatomic, strong) NSMutableArray *cards; //of Card
@property (nonatomic) NSMutableArray *result; //of NSMutableAttributedString
@property (nonatomic) int mode; //abstract

@end
