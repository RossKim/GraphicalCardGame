//
//  CardSetGame.m
//  Matchismo
//
//  Created by Kim Minsu on 2013/04/28.
//  Copyright (c) 2013年 Kim Minsu. All rights reserved.
//

#import "CardSetGame.h"
#import "PlayingCardSet.h"
#import "PlayingCardSetDeck.h"

@interface CardSetGame()

@end

@implementation CardSetGame

- (int)mode {
    return 3;
}

- (BOOL)flipCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    BOOL doDelete = false;
    if(!card.isUnplayable) {
        if(!card.faceUp) {
            NSMutableArray *otherCards = [[NSMutableArray alloc] init];
            for(Card *otherCard in self.cards) {
                if(otherCard.isFaceUp && !otherCard.isUnplayable) {
                    [otherCards addObject:otherCard];
                }
            }
            if(otherCards.count == self.mode-1) {
                int matchScore = [card match:otherCards];
                if(matchScore) {
                    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:@"Matched "];
                    [result appendAttributedString:card.attributedContents];
                    for(Card *otherCard in otherCards) {
                        otherCard.unplayable = YES;
                        [result appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@" & "]];
                        [result appendAttributedString:otherCard.attributedContents];
                        [self.cards removeObject:otherCard];
                    }
                    card.unplayable = YES;
                    self.score += matchScore * MATCH_BONUS;
                    [result appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"\nfor %d points",(matchScore*MATCH_BONUS)]]];
                    [self.result addObject:result];
                    [self.cards removeObject:card];
                    doDelete = true;
                } else {
                    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithAttributedString:card.attributedContents];
                    for(Card *otherCard in otherCards) {
                        otherCard.faceUp = NO;
                        [result appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@" & "]];
                        [result appendAttributedString:otherCard.attributedContents];
                    }
                    self.score -= MISMATCH_PENALTY;
                    [result appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" don't match!\n%d point penalty!",MISMATCH_PENALTY]]];
                    [self.result addObject:result];
                }
            } else {
                NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Flipped up "]];
                [result appendAttributedString:card.attributedContents];
                [self.result addObject:result];
            }
            self.score -= FLIP_COST;
        } else {
            NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Flipped up "]];
            [result appendAttributedString:card.attributedContents];
            [self.result addObject:result];
        }
        card.faceUp = !card.faceUp;
    }
    return doDelete;
}

@end
