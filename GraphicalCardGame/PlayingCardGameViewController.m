//
//  PlayingCardGameViewController.m
//  GraphicalCardGame
//
//  Created by Kim Minsu on 2013/05/10.
//  Copyright (c) 2013年 Kim Minsu. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "PlayingCardViewCell.h"
#import "CardMatchingGame.h"

@interface PlayingCardGameViewController ()
@property (strong, nonatomic) CardMatchingGame *cardMatchingGame;
@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (NSUInteger)startingCardCount {
    return 22;
}

- (CardGame *)game {
    return self.cardMatchingGame;
}

- (CardMatchingGame *)cardMatchingGame {
    if(!_cardMatchingGame) {
        _cardMatchingGame = [[CardMatchingGame alloc] initWithCardCount:self.startingCardCount
                                                              usingDeck:[self createDeck]];
    }
    return _cardMatchingGame;
}

- (void)initGame {
    self.cardMatchingGame = nil;
}

- (NSUInteger)mode {
    return 1;
}

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card {
    if([cell isKindOfClass:[PlayingCardViewCell class]]) {
        PlayingCardView *cardView = ((PlayingCardViewCell *)cell).playingCardView;
        if([card isKindOfClass:[PlayingCard class]]) {
            PlayingCard *playingCard = (PlayingCard *)card;
            cardView.rank = playingCard.rank;
            cardView.suit = playingCard.suit;
            cardView.faceUp = playingCard.faceUp;
            cardView.alpha = playingCard.isUnplayable ? 0.3 : 1.0;
        }
    }
}

@end
