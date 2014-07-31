//
//  CardGame.m
//  GraphicalCardGame
//
//  Created by Kim Minsu on 2013/05/10.
//  Copyright (c) 2013年 Kim Minsu. All rights reserved.
//

#import "CardGame.h"

@interface CardGame()

@end

@implementation CardGame

- (NSMutableArray *)cards {
    if(!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck{
    self = [super init];
    if(self) {
        for(int i=0;i<cardCount;i++) {
            Card *card = [deck drawRandomCard];
            if(!card) {
                self = nil;
            } else {
                self.cards[i] = card;
            }
        }
    }
    return self;
}

- (BOOL)addCard:(NSUInteger)cardCount usingDeck:(Deck *)deck {
    for(int i=0;i<cardCount;i++) {
        Card *card = [deck drawRandomCard];
        if(!card) {
            return false;
        } else {
            [self.cards addObject:card];
        }
    }
    return true;
}

- (NSMutableArray *)result {
    if(!_result) {
        _result = [[NSMutableArray alloc] initWithCapacity:1000];
        [_result addObject:[[NSMutableAttributedString alloc] initWithString:@"Play Game!"]];
    }
    
    return _result;
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (BOOL)flipCardAtIndex:(NSUInteger)index {
    //abstract
    return false;
}

@end
