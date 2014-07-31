//
//  CardGameViewController.m
//  GraphicalCardGame
//
//  Created by Kim Minsu on 2013/05/10.
//  Copyright (c) 2013年 Kim Minsu. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardGame.h"
#import "GameResult.h"

@interface CardGameViewController () <UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *flipLabel;
@property (nonatomic) NSUInteger flipCount;
@property (strong, nonatomic) GameResult *gameResult;
@end

@implementation CardGameViewController

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.startingCardCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PlayingCard" forIndexPath:indexPath];
    Card *card = [self.game cardAtIndex:indexPath.item];
    [self updateCell:cell usingCard:card];
    return cell;
}

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card {
    // abstract
}

- (GameResult *)gameResult
{
    if(!_gameResult) {
        _gameResult = [[GameResult alloc] init];
    }
    return _gameResult;
}

- (Deck *)createDeck { return nil; } //abstract

- (void)updateUI {
    for(UICollectionViewCell *cell in [self.cardCollectionView visibleCells]) {
        NSIndexPath *indexPath = [self.cardCollectionView indexPathForCell:cell];
        Card *card = [self.game cardAtIndex:indexPath.item];
        [self updateCell:cell usingCard:card];
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score : %d",self.game.score];
}

- (void)setFlipCount:(NSUInteger)flipCount {
    _flipCount = flipCount;
    self.flipLabel.text = [NSString stringWithFormat:@"Flips : %d",self.flipCount];
}

- (IBAction)dealGame:(UIButton *)sender {
    [self initGame];
    self.gameResult = nil;
    self.flipCount = 0;
    [self.cardCollectionView reloadData];
}

- (void)initGame { }//abstract

- (IBAction)flipCard:(UITapGestureRecognizer *)gesture {
    CGPoint tapLocation = [gesture locationInView:self.cardCollectionView];
    NSIndexPath *indexPath = [self.cardCollectionView indexPathForItemAtPoint:tapLocation];
    if(indexPath) {
        if([self.game flipCardAtIndex:indexPath.item]) {
            [self doDeleteCardCount:self.mode];
            [self.cardCollectionView reloadData];
        }
        self.flipCount++;
        [self updateUI];
        [self.gameResult setGame:self.game.score mode:self.mode];
    }
}

- (void)doDeleteCardCount:(NSUInteger)mode {
    //abstract
}
@end
