//
//  PlayingSetView.h
//  GraphicalCardGame
//
//  Created by Kim Minsu on 2013/05/10.
//  Copyright (c) 2013年 Kim Minsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingSetView : UIView

@property (strong, nonatomic) NSString* symbol;
@property (nonatomic) NSUInteger number;
@property (nonatomic) UIColor *color;
@property (strong, nonatomic) NSString *shading;
@property (nonatomic) BOOL faceUp;
@property (nonatomic) CGFloat faceCardScaleFactor;

@end
