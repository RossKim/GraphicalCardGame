//
//  CardGameViewController.h
//  GraphicalCardGame
//
//  Created by Kim Minsu on 2013/05/10.
//  Copyright (c) 2013年 Kim Minsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardGame.h"
@interface CardGameViewController : UIViewController

@property (nonatomic) NSUInteger startingCardCount; //abstract
@property (strong, nonatomic) CardGame *game; //abstract
@property (weak, nonatomic) IBOutlet UICollectionView *cardCollectionView;
- (Deck *)createDeck; //abstract
- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card; //abstract
- (void)initGame; //abstract
- (void)doDeleteCardCount:(NSUInteger)mode; //abstract
@property (nonatomic) NSUInteger mode; //abstract
@end
