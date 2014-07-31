//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Kim Minsu on 2013/04/17.
//  Copyright (c) 2013年 Kim Minsu. All rights reserved.
//

#import "CardMatchingGame.h"

@implementation CardMatchingGame

- (int)mode {
    return 2;
}

- (BOOL)flipCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
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
                    NSString *otherCardContents = @"";
                    for(Card *otherCard in otherCards) {
                        otherCard.unplayable = YES;
                        otherCardContents = [NSString stringWithFormat:@"%@ & %@",otherCardContents,otherCard.contents];
                    }
                    card.unplayable = YES;
                    self.score += matchScore * MATCH_BONUS;
                    [self.result addObject:[NSString stringWithFormat:@"Matched %@%@\nfor %d points",
                                   card.contents, otherCardContents, (matchScore * MATCH_BONUS)]];

                } else {
                    NSString *otherCardContents = @"";
                    for(Card *otherCard in otherCards) {
                        otherCard.faceUp = NO;
                        otherCardContents = [NSString stringWithFormat:@"%@ & %@",otherCardContents,otherCard.contents];
                    }
                    self.score -= MISMATCH_PENALTY;
                    [self.result addObject:[NSString stringWithFormat:@"%@%@ don't match!\n%d point penalty!",
                                   card.contents, otherCardContents, MISMATCH_PENALTY]];
                }
            } else {
                [self.result addObject:[NSString stringWithFormat:@"Flipped up %@",card.contents]];
            }
            self.score -= FLIP_COST;
        } else {
            [self.result addObject:[NSString stringWithFormat:@"Flipped up %@",card.contents]];
        }
        card.faceUp = !card.faceUp;
    }
    return false;
}

@end
