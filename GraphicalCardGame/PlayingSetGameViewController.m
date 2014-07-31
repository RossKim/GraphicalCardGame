//
//  PlayingSetGameViewController.m
//  GraphicalCardGame
//
//  Created by Kim Minsu on 2013/05/10.
//  Copyright (c) 2013年 Kim Minsu. All rights reserved.
//

#import "PlayingSetGameViewController.h"
#import "PlayingCardSetDeck.h"
#import "PlayingCardSet.h"
#import "CardSetGame.h"
#import "PlayingSetViewCell.h"

@interface PlayingSetGameViewController ()
@property (strong, nonatomic) CardSetGame *setGame;
@property (strong, nonatomic) PlayingCardSetDeck *deck;
@property (nonatomic) NSUInteger cardCount;
@end

@implementation PlayingSetGameViewController

- (Deck *)createDeck {
    _deck = nil;
    return self.deck;
}

- (PlayingCardSetDeck *)deck {
    if(!_deck) {
        _deck = [[PlayingCardSetDeck alloc] init];
    }
    return _deck;
}

- (NSUInteger)startingCardCount {
    return self.cardCount;
}

- (NSUInteger)cardCount {
    if(!_cardCount) {
        _cardCount = 12;
    }
    return _cardCount;
}

- (CardGame *)game {
    return self.setGame;
}

- (CardSetGame *)setGame {
    if(!_setGame) {
        _setGame = [[CardSetGame alloc] initWithCardCount:self.startingCardCount
                                                usingDeck:[self createDeck]];
    }
    return _setGame;
}

- (void)initGame {
    _setGame = nil;
    _deck = nil;
    _cardCount = 0;
}

- (NSUInteger)mode {
    return 2;
}

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card {
    if([cell isKindOfClass:[PlayingSetViewCell class]]) {
        PlayingSetView *setView = ((PlayingSetViewCell *)cell).playingSetView;
        if(!card) {
            
            ((PlayingSetViewCell *)cell).playingSetView = nil;
            return;
        }
        if([card isKindOfClass:[PlayingCardSet class]]) {
            PlayingCardSet *playingCardSet = (PlayingCardSet *)card;
            setView.symbol = playingCardSet.symbol;
            setView.color = playingCardSet.color;
            setView.number = playingCardSet.number;
            setView.shading = playingCardSet.shading;
            setView.faceUp = playingCardSet.faceUp;
            setView.alpha = playingCardSet.unplayable ? 0.3 : 1.0;
        }
    }
}

- (IBAction)addCard:(UIButton *)sender {
    int cardCount = 3;
    if(![self.game addCard:cardCount usingDeck:self.deck]) {
        NSLog(@"There's no more Card");
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Add Card Error"
                                                            message:@"There's no more Card!"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
    self.cardCount += 3;
    [self.cardCollectionView reloadData];
}

- (void)doDeleteCardCount:(NSUInteger)mode {
    self.cardCount -= (mode+1);
}

@end
