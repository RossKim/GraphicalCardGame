//
//  PlayingCardView.h
//  GraphicalCardGame
//
//  Created by Kim Minsu on 2013/05/10.
//  Copyright (c) 2013年 Kim Minsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView

@property (nonatomic) NSUInteger rank;
@property (nonatomic, retain) NSString *suit;
@property (nonatomic) BOOL faceUp;
@property (nonatomic) CGFloat faceCardScaleFactor;

@end
